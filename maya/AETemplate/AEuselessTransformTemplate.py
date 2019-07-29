import maya.cmds as cmds

import sys
from PySide2 import QtWidgets, QtCore, QtGui

import shiboken2
import maya.OpenMayaUI as apiUI


################################################################################
#Base Attribute Widget
################################################################################
class BaseAttrWidget(QtWidgets.QWidget):
    '''
    This is the base attribute widget from which all other attribute widgets
    will inherit. Sets up all the relevant methods + common widgets and initial
    layout.
    '''
    def __init__(self, node, attr, label='', parent=None):
        '''
        Initialize
        
        @type node: str
        @param node: The name of the node that this widget should start with.
        @type attr: str
        @param attr: The name of the attribute this widget is responsible for.
        @type label: str
        @param label: The text that should be displayed in the descriptive label.
        '''
        super(BaseAttrWidget, self).__init__(parent)
        
        self.node = node    #: Store the node name
        self.attr = attr    #: Store the attribute name
        
        #: This will store information about the scriptJob that we will create
        #: so that we can update this widget whenever its attribute is updated
        #: separately.
        self.sj = None
        
        #: Use this variable to track whether the gui is currently being updated
        #: or not.
        self.updatingGUI = False
        
        ########################################################################
        #Widgets
        ########################################################################
        #: The QLabel widget with the name of the attribute
        self.label = QtWidgets.QLabel(label if label else attr, parent=self)
        
        ########################################################################
        #Layout
        ########################################################################
        self.layout = QtWidgets.QBoxLayout(QtWidgets.QBoxLayout.LeftToRight, self)
        self.layout.setContentsMargins(0,0,0,0)
        self.layout.setSpacing(5)
        
        self.layout.addWidget(self.label)
        
        
    def callUpdateGUI(self):
        '''
        Calls the updateGUI method but makes sure to set the updatingGUI variable
        while doing so.
        
        This is necessary so that we don't get caught in a loop where updating
        the UI will trigger a signal that updates the attr on the node, which
        in turn triggers the scriptJob to run updateGUI again.
        '''
        self.updatingGUI = True
        
        self.updateGUI()
        
        self.updatingGUI = False
        
    def updateGUI(self):
        '''
        VIRTUAL method. Called whenever the widget needs to update its displayed
        value to match the value of the attribute on the node.
        '''
        raise NotImplementedError
        
    def callUpdateAttr(self):
        '''
        Calls the updateAttr method but only if not currently updatingGUI
        '''
        if not self.updatingGUI:
            self.updateAttr()
            
    def updateAttr(self):
        '''
        VIRTUAL method. Should be called whenever the user makes a change to this
        widget via the UI. This method is then responsible for applying the same
        change to the actual attribute on the node.
        '''
        raise NotImplementedError
        
    def setNode(self, node):
        '''
        This widget should now represent the same attr on a different node.
        '''
        oldNode = self.node
        self.node = node
        self.callUpdateGUI()
        
        if not self.sj or not cmds.scriptJob(exists=self.sj) or not oldNode == self.node:
            #script job
            ct = 0
            while self.sj:
                #Kill the old script job.
                try:
                    if cmds.scriptJob(exists=self.sj):
                        cmds.scriptJob(kill=self.sj, force=True)
                    self.sj = None
                except RuntimeError:
                    #Could not kill the old script job for some reason.
                    #This happens, albeit very rarely, when that scriptJob is
                    #being executed at the same time we try to kill it. Pause
                    #for a second and then retry.
                    ct += 1
                    if ct < 10:
                        cmds.warning("Got RuntimeError trying to kill scriptjob...trying again")
                        time.sleep(1)
                    else:
                        #We've failed to kill the scriptJob 10 consecutive times.
                        #Time to give up and move on.
                        cmds.warning("Killing scriptjob is taking too long...skipping")
                        break
                        
            #Set the new scriptJob to call the callUpdateGUI method everytime the
            #node.attr is changed.
            self.sj = cmds.scriptJob(ac=['%s.%s' % (self.node, self.attr), self.callUpdateGUI], killWithScene=1)
        

################################################################################
#Attribute widgets
################################################################################
class NumWidget(BaseAttrWidget):
    '''
    This widget can be used with numerical attributes.
    '''
    def __init__(self, node, attr, label='', parent=None):
        '''
        Initialize
        '''
        super(NumWidget, self).__init__(node, attr, label, parent)
        
        ########################################################################
        #Widgets
        ########################################################################
        #: The QLineEdit storing the value of the attribute
        self.valLE = QtWidgets.QLineEdit(parent=self)
        
        #Set a validator for the valLE that will ensure that the user may only
        #enter numerical values
        self.valLE.setValidator(QtGui.QDoubleValidator(self.valLE))
        
        ########################################################################
        #Layout
        ########################################################################
        self.layout.addWidget(self.valLE)
        self.layout.addStretch(1)
        
        ########################################################################
        #Connections
        ########################################################################
        #We need to call the callUpdateAttr method whenever the user modifies the
        #value in valLE
        self.connect(self.valLE, QtCore.SIGNAL("editingFinished()"), self.callUpdateAttr)
        
        ########################################################################
        #Set the initial node
        ########################################################################
        self.setNode(node)
        
    def updateGUI(self):
        '''
        Implement this virtual method to update the value in valLE based on the
        current node.attr
        '''
        self.valLE.setText('%.03f' % round(cmds.getAttr("%s.%s" % (self.node, self.attr)), 3))
        
    def updateAttr(self):
        '''
        Implement this virtual method to update the actual node.attr value to
        reflect what's currently in the UI.
        '''
        cmds.setAttr("%s.%s" % (self.node, self.attr), float(self.valLE.text()))
        
        
class StrWidget(BaseAttrWidget):
    '''
    This widget can be used with string attributes.
    '''
    def __init__(self, node, attr, label='', parent=None):
        '''
        Initialize
        '''
        super(StrWidget, self).__init__(node, attr, label, parent)
        
        ########################################################################
        #Widgets
        ########################################################################
        #: The QLineEdit storing the value of the attribute
        self.valLE = QtWidgets.QLineEdit(parent=self)
        
        ########################################################################
        #Layout
        ########################################################################
        self.layout.addWidget(self.valLE, 1)
        
        ########################################################################
        #Connections
        ########################################################################
        #We need to call the callUpdateAttr method whenever the user modifies the
        #value in valLE
        self.connect(self.valLE, QtCore.SIGNAL("editingFinished()"), self.callUpdateAttr)
        
        ########################################################################
        #Set the initial node
        ########################################################################
        self.setNode(node)
        
    def updateGUI(self):
        '''
        Implement this virtual method to update the value in valLE based on the
        current node.attr
        '''
        self.valLE.setText(str(cmds.getAttr("%s.%s" % (self.node, self.attr))))
        
    def updateAttr(self):
        '''
        Implement this virtual method to update the actual node.attr value to
        reflect what's currently in the UI.
        '''
        cmds.setAttr("%s.%s" % (self.node, self.attr), str(self.valLE.text()), type='string')
        
        
class EnumWidget(BaseAttrWidget):
    '''
    This widget can be used with enumerated attributes.
    '''
    def __init__(self, node, attr, label='', enums=None, parent=None):
        '''
        Initialize
        
        @type enum: list
        @param enum: An ordered list of the values to be show in the enumeration list
        '''
        super(EnumWidget, self).__init__(node, attr, label, parent)
        
        #Make sure the provided enums are not None
        enums = enums if enums else []
        
        ########################################################################
        #Widgets
        ########################################################################
        #: The QComboBox storing the enums
        self.valCB = QtWidgets.QComboBox(parent=self)
        
        #Populate valCB with the enums
        self.valCB.addItems(enums)
        
        ########################################################################
        #Layout
        ########################################################################
        self.layout.addWidget(self.valCB)
        self.layout.addStretch(1)
        
        ########################################################################
        #Connections
        ########################################################################
        #We need to call the callUpdateAttr method whenever the user modifies the
        #value in valCB
        self.connect(self.valCB, QtCore.SIGNAL("currentIndexChanged(int)"), self.callUpdateAttr)
        
        ########################################################################
        #Set the initial node
        ########################################################################
        self.setNode(node)
        
    def updateGUI(self):
        '''
        Implement this virtual method to update the value in valCB based on the
        current node.attr
        '''
        self.valCB.setCurrentIndex(cmds.getAttr('%s.%s' % (self.node, self.attr)))
        
    def updateAttr(self):
        '''
        Implement this virtual method to update the actual node.attr value to
        reflect what's currently in the UI.
        '''
        cmds.setAttr("%s.%s" % (self.node, self.attr), self.valCB.currentIndex())

################################################################################
#Main AETemplate Widget
################################################################################
class AEuselessTransformTemplate(QtWidgets.QWidget):
    '''
    The main class that holds all the controls for the uselessTransform node
    '''
    def __init__(self, node, parent=None):
        '''
        Initialize
        '''
        super(AEuselessTransformTemplate, self).__init__(parent)
        self.node = node
        
        ########################################################################
        #Widgets
        ########################################################################
        #: Store the widget that will display/update the stringAttr attribute
        self.strAttr = StrWidget(node, 'stringAttr', label='TXT:', parent=self)
        
        #: Store the widget that will display/update the enumAttr attribute
        self.enumAttr = EnumWidget(node,
                                   'enumAttr',
                                   label='Enumerated:',
                                   enums=['zero', 'one', 'two', 'three', 'four',
                                          'five', 'six', 'seven', 'eight', 'nine'],
                                   parent=self)
                                   
        #: Store the widget that will display/update the numAttr attribute
        self.numAttr = NumWidget(node, 'numAttr', label='NUM:', parent=self)
        
        
        ########################################################################
        #Layout
        ########################################################################
        self.layout = QtWidgets.QBoxLayout(QtWidgets.QBoxLayout.TopToBottom, self)
        self.layout.setContentsMargins(5,3,11,3)
        self.layout.setSpacing(5)
        self.layout.addWidget(self.strAttr)
        self.layout.addWidget(self.enumAttr)
        self.layout.addWidget(self.numAttr)
        
    def setNode(self, node):
        '''
        Set the current node
        '''
        self.node = node
        
        self.strAttr.setNode(node)
        self.enumAttr.setNode(node)
        self.numAttr.setNode(node)


################################################################################
#Initialize/Update methods:
#   These are the methods that get called to Initialize & install the QT GUI
#   and to update/repoint it to a different node
################################################################################
def getLayout(lay):
    '''
    Get the layout object
    
    @type lay: str
    @param lay: The (full) name of the layout that we need to get
    
    @rtype: QtWidgets.QLayout (or child)
    @returns: The QLayout object
    '''
    ptr = apiUI.MQtUtil.findLayout(lay)
    if ptr is not None:
        return shiboken2.wrapInstance(long(ptr), QtWidgets.QWidget)
    return None
    
def buildQT(lay, node):
    '''
    Build/Initialize/Install the QT GUI into the layout.
    
    @type lay: str
    @param lay: Name of the Maya layout to add the QT GUI to
    @type node: str
    @param node: Name of the node to (initially) connect to the QT GUI
    '''
    #get the layout object
    mLayout = getLayout(lay)
    
    #create the GUI/widget
    widg = AEuselessTransformTemplate(node)
    
    #add the widget to the layout
    mLayout.layout().addWidget(widg)
    
def updateQT(lay, node):
    '''
    Update the QT GUI to point to a different node
    
    @type lay: str
    @param lay: Name of the Maya layout to where the QT GUI lives
    @type node: str
    @param node: Name of the new node to connect to the QT GUI
    '''
    #get the layout
    mLayout = getLayout(lay)
    
    #find the widget
    for c in range(mLayout.layout().count()):
        widg = mLayout.layout().itemAt(c).widget()
        if isinstance(widg, AEuselessTransformTemplate):
            #found the widget, update the node it's pointing to
            widg.setNode(node)
            break