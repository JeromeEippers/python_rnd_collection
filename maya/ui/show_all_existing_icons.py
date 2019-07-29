
from PySide2 import QtWidgets, QtGui

class MyWindow(QtWidgets.QDialog):


    def __init__(self, parent=None):
        super(MyWindow, self).__init__(parent)
        
        scrollLay = QtWidgets.QGridLayout(self)
        scroll = QtWidgets.QScrollArea()
        scrollLay.addWidget(scroll)
        
        widget = QtWidgets.QWidget()
        lay = QtWidgets.QGridLayout(widget)
        
        imgs = cmds.resourceManager(nameFilter="*")
        
        counts = int( len(imgs) ** 0.5 )
        index = 0
        for r in range(counts):
            for c in range(int(counts*1.5)):
                if index < len(imgs):
                    img = imgs[index]
                    index += 1
                    label = QtWidgets.QToolButton()
                    label.setIcon(QtGui.QIcon(":/"+img))
                    label.setToolTip(img)
                    lay.addWidget(label,r,c)
        
        scroll.setWidget(widget)
        
        
            


        

win = MyWindow()
win.show()