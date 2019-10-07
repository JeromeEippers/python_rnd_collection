//Maya ASCII 2018 scene
//Name: scene.ma
//Last modified: Mon, Oct 07, 2019 02:04:25 PM
//Codeset: 1252
requires maya "2018";
requires -nodeType "HIKSolverNode" -nodeType "HIKCharacterNode" -nodeType "HIKSkeletonGeneratorNode"
		 -nodeType "HIKControlSetNode" -nodeType "HIKEffectorFromCharacter" -nodeType "HIKFK2State"
		 -nodeType "HIKState2FK" -nodeType "HIKState2SK" -nodeType "HIKEffector2State" -nodeType "HIKState2Effector"
		 -nodeType "HIKProperty2State" -nodeType "HIKPinning2State" -dataType "HIKCharacter"
		 -dataType "HIKCharacterState" -dataType "HIKEffectorState" -dataType "HIKPropertySetState"
		 "mayaHIK" "1.0_HIK_2016.5";
currentUnit -l centimeter -a degree -t ntsc;
fileInfo "application" "maya";
fileInfo "product" "Maya 2018";
fileInfo "version" "2018";
fileInfo "cutIdentifier" "201706261615-f9658c4cfc";
fileInfo "osv" "Microsoft Windows 8 Business Edition, 64-bit  (Build 9200)\n";
createNode transform -s -n "persp";
	rename -uid "DDF1B004-4142-2BE0-3AFA-E298FB2E146D";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1.514580502230136 137.43709341383868 338.30875069248538 ;
	setAttr ".r" -type "double3" -9.2416494329004291 0.26153846153895366 -8.0757112557481552e-17 ;
	setAttr ".rp" -type "double3" 0 0 2.8421709430404007e-14 ;
	setAttr ".rpt" -type "double3" 7.7813676630328461e-15 2.0187627061128546e-14 -2.6370012144728262e-15 ;
createNode camera -s -n "perspShape" -p "persp";
	rename -uid "18C83AA8-4BCF-C514-9949-738BE3457BF2";
	setAttr -k off ".v" no;
	setAttr ".fl" 34.999999999999979;
	setAttr ".coi" 336.19854367505661;
	setAttr ".imn" -type "string" "persp";
	setAttr ".den" -type "string" "persp_depth";
	setAttr ".man" -type "string" "persp_mask";
	setAttr ".tp" -type "double3" -0.00014211295339772168 83.444039577000098 6.4775940450001599 ;
	setAttr ".hc" -type "string" "viewSet -p %camera";
	setAttr ".ai_translator" -type "string" "perspective";
createNode transform -s -n "top";
	rename -uid "4435BC9D-4E37-FF21-8A42-FAA4BAAB59EB";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 1000.1 0 ;
	setAttr ".r" -type "double3" -89.999999999999986 0 0 ;
createNode camera -s -n "topShape" -p "top";
	rename -uid "00E0D16D-47E9-856A-A1BD-B187811EC755";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "top";
	setAttr ".den" -type "string" "top_depth";
	setAttr ".man" -type "string" "top_mask";
	setAttr ".hc" -type "string" "viewSet -t %camera";
	setAttr ".o" yes;
	setAttr ".ai_translator" -type "string" "orthographic";
createNode transform -s -n "front";
	rename -uid "E1F50348-42D2-FA25-1C90-90A564874ACB";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 0 0 1000.1 ;
createNode camera -s -n "frontShape" -p "front";
	rename -uid "5E47EFFE-47AE-8D5E-38DE-F296F40C4FDD";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "front";
	setAttr ".den" -type "string" "front_depth";
	setAttr ".man" -type "string" "front_mask";
	setAttr ".hc" -type "string" "viewSet -f %camera";
	setAttr ".o" yes;
	setAttr ".ai_translator" -type "string" "orthographic";
createNode transform -s -n "side";
	rename -uid "17B37407-4FA7-712D-7995-E49F85CE4027";
	setAttr ".v" no;
	setAttr ".t" -type "double3" 1000.1 0 0 ;
	setAttr ".r" -type "double3" 0 89.999999999999986 0 ;
createNode camera -s -n "sideShape" -p "side";
	rename -uid "05843BC7-4B06-3B0E-2924-889AE710C208";
	setAttr -k off ".v" no;
	setAttr ".rnd" no;
	setAttr ".coi" 1000.1;
	setAttr ".ow" 30;
	setAttr ".imn" -type "string" "side";
	setAttr ".den" -type "string" "side_depth";
	setAttr ".man" -type "string" "side_mask";
	setAttr ".hc" -type "string" "viewSet -s %camera";
	setAttr ".o" yes;
	setAttr ".ai_translator" -type "string" "orthographic";
createNode transform -n "Reference";
	rename -uid "9B88178C-41BE-AF38-3B4B-41AAA7BDE0C6";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
createNode locator -n "ReferenceShape" -p "Reference";
	rename -uid "CB75806B-43A3-B67F-1BFC-4D95589F3B10";
	setAttr -k off ".v";
createNode joint -n "Hips" -p "Reference";
	rename -uid "E9483FEB-4171-0978-17B8-809F97FECAB0";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".typ" 1;
	setAttr ".radi" 1.5;
createNode joint -n "LeftUpLeg" -p "Hips";
	rename -uid "28BB079A-4CAF-F48E-32BA-529FAB7AFA77";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".sd" 1;
	setAttr ".typ" 2;
	setAttr ".radi" 1.5;
createNode joint -n "LeftLeg" -p "LeftUpLeg";
	rename -uid "5FC4AE7C-4108-6604-5F9F-E1982AEA7EF7";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".sd" 1;
	setAttr ".typ" 3;
	setAttr ".radi" 1.5;
createNode joint -n "LeftFoot" -p "LeftLeg";
	rename -uid "D620CF0D-4825-D7BB-08F6-05B5ADD172E2";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".sd" 1;
	setAttr ".typ" 4;
	setAttr ".radi" 1.5;
createNode joint -n "LeftToeBase" -p "LeftFoot";
	rename -uid "EC793A35-4646-53F8-65E3-6AA95A22D17C";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".sd" 1;
	setAttr ".typ" 5;
	setAttr ".radi" 1.5;
createNode joint -n "RightUpLeg" -p "Hips";
	rename -uid "97D72A8D-46F0-249C-D4AA-B7848AAF1BD1";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".sd" 2;
	setAttr ".typ" 2;
	setAttr ".radi" 1.5;
createNode joint -n "RightLeg" -p "RightUpLeg";
	rename -uid "B09C4F72-4884-0FE6-3403-018553FB10B7";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".sd" 2;
	setAttr ".typ" 3;
	setAttr ".radi" 1.5;
createNode joint -n "RightFoot" -p "RightLeg";
	rename -uid "6D6304D2-444E-D7DD-17BB-DD9353F54748";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".sd" 2;
	setAttr ".typ" 4;
	setAttr ".radi" 1.5;
createNode joint -n "RightToeBase" -p "RightFoot";
	rename -uid "F3805736-4AE6-ACC9-C243-6EB3454DD223";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".jo" -type "double3" 0 0.0048003860000000002 0 ;
	setAttr ".ds" 2;
	setAttr ".sd" 2;
	setAttr ".typ" 5;
	setAttr ".radi" 1.5;
createNode joint -n "Spine" -p "Hips";
	rename -uid "14415F6D-4690-BBDA-A9A7-9B9D992A2353";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".typ" 6;
	setAttr ".radi" 1.5;
createNode joint -n "Spine1" -p "Spine";
	rename -uid "4DBCA111-4BBE-460E-A66C-FCBC51E52EF8";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".typ" 6;
	setAttr ".radi" 1.5;
createNode joint -n "LeftShoulder" -p "Spine1";
	rename -uid "8867251D-4788-99F1-2993-0D9A880806E3";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".sd" 1;
	setAttr ".typ" 9;
	setAttr ".radi" 1.5;
createNode joint -n "LeftArm" -p "LeftShoulder";
	rename -uid "C9C6F829-4595-8383-DE35-B89D66CB0938";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".jo" -type "double3" 0 0 -0.00073528200000000073 ;
	setAttr ".ds" 2;
	setAttr ".sd" 1;
	setAttr ".typ" 10;
	setAttr ".radi" 1.5;
createNode joint -n "LeftForeArm" -p "LeftArm";
	rename -uid "30C0B5B1-4F6D-1601-2AD9-76B13FD8CE0C";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".jo" -type "double3" 0 0 0.0051469740000000029 ;
	setAttr ".ds" 2;
	setAttr ".sd" 1;
	setAttr ".typ" 11;
	setAttr ".radi" 1.5;
createNode joint -n "LeftHand" -p "LeftForeArm";
	rename -uid "9DC43036-45B0-400A-2A23-37A3575AB181";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".jo" -type "double3" 0 0 -0.015440922000000015 ;
	setAttr ".ds" 2;
	setAttr ".sd" 1;
	setAttr ".typ" 12;
	setAttr ".radi" 1.5;
createNode joint -n "RightShoulder" -p "Spine1";
	rename -uid "45A39CFE-4006-CCB4-6F70-64B56BD7FDF7";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".sd" 2;
	setAttr ".typ" 9;
	setAttr ".radi" 1.5;
createNode joint -n "RightArm" -p "RightShoulder";
	rename -uid "CE300074-4AAD-5308-42B9-72B3D61DF195";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".jo" -type "double3" 0 0 0.0023183610000000032 ;
	setAttr ".ds" 2;
	setAttr ".sd" 2;
	setAttr ".typ" 10;
	setAttr ".radi" 1.5;
createNode joint -n "RightForeArm" -p "RightArm";
	rename -uid "C9A45F44-4AB3-8B84-8DBD-5181DFA99EB7";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".jo" -type "double3" 0 0 -0.016228527000000017 ;
	setAttr ".ds" 2;
	setAttr ".sd" 2;
	setAttr ".typ" 11;
	setAttr ".radi" 1.5;
createNode joint -n "RightHand" -p "RightForeArm";
	rename -uid "A0F9B81C-45D2-44EA-20BD-74A96973D2B4";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".jo" -type "double3" 0 0 0.048685581000000019 ;
	setAttr ".ds" 2;
	setAttr ".sd" 2;
	setAttr ".typ" 12;
	setAttr ".radi" 1.5;
createNode joint -n "Neck" -p "Spine1";
	rename -uid "DFD9D383-4E7A-06B4-34F6-5893BBFE8F14";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".typ" 7;
	setAttr ".radi" 1.5;
createNode joint -n "Head" -p "Neck";
	rename -uid "EB6C65A1-4BE2-D6EF-3BD0-82A2B6E69C8D";
	addAttr -s false -ci true -sn "ch" -ln "Character" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".ds" 2;
	setAttr ".typ" 8;
	setAttr ".radi" 1.5;
createNode transform -n "Character1_Ctrl_Reference";
	rename -uid "239EA4BF-4E67-52DA-9204-D6A7113B1DAC";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr -l on ".ra";
createNode locator -n "Character1_Ctrl_ReferenceShape" -p "Character1_Ctrl_Reference";
	rename -uid "14B85201-4A97-5EA0-1EEC-AA88F9AE6911";
	setAttr -k off ".v";
createNode hikIKEffector -n "Character1_Ctrl_HipsEffector" -p "Character1_Ctrl_Reference";
	rename -uid "6ECBDEA7-40B5-A04B-A50C-039C8AFE3F18";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -90 -90 0 ;
	setAttr -l on ".ra";
	setAttr ".rt" 1;
	setAttr ".rr" 1;
	setAttr ".radi" 15;
	setAttr -l on ".jo" -type "double3" 90 0 90 ;
	setAttr -l on ".jo";
	setAttr ".lk" 2;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_LeftAnkleEffector" -p "Character1_Ctrl_Reference";
	rename -uid "759930FF-4D93-2EF3-6798-4D8FE77B165B";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 154.200858241437 -89.999965822788084 0 ;
	setAttr -l on ".ra";
	setAttr ".pin" 3;
	setAttr ".ei" 1;
	setAttr ".rt" 1;
	setAttr ".rr" 1;
	setAttr ".radi" 8;
	setAttr -l on ".jo" -type "double3" -90.00007070166123 -64.200858241415929 -89.999921470981704 ;
	setAttr -l on ".jo";
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_RightAnkleEffector" -p "Character1_Ctrl_Reference";
	rename -uid "83114665-4F5C-F257-083C-0A895435EDF9";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -25.799092755428251 -89.995678489082195 180 ;
	setAttr -l on ".ra";
	setAttr ".pin" 3;
	setAttr ".ei" 2;
	setAttr ".rt" 1;
	setAttr ".rr" 1;
	setAttr ".radi" 8;
	setAttr -l on ".jo" -type "double3" -89.991060164130957 -64.20090690744297 -90.009929557987491 ;
	setAttr -l on ".jo";
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_LeftWristEffector" -p "Character1_Ctrl_Reference";
	rename -uid "F8FB42CD-410A-38F7-9C89-4C8DA28390EF";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 3;
	setAttr ".radi" 5;
	setAttr -l on ".jo" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".rof" -type "double3" 0 0 90 ;
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_RightWristEffector" -p "Character1_Ctrl_Reference";
	rename -uid "9813CF98-4451-0431-3E35-039B55C009F9";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90.000000000000014 0 180 ;
	setAttr -l on ".ra";
	setAttr ".ei" 4;
	setAttr ".radi" 5;
	setAttr -l on ".jo" -type "double3" 90.000000000000014 0 180 ;
	setAttr -l on ".jo";
	setAttr ".rof" -type "double3" 0 0 90 ;
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_LeftKneeEffector" -p "Character1_Ctrl_Reference";
	rename -uid "D26D1200-4A5B-8A63-F613-718454704CD1";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90 -90 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 5;
	setAttr ".radi" 2;
	setAttr -l on ".jo" -type "double3" -90 0 -90 ;
	setAttr -l on ".jo";
	setAttr ".tof" -type "double3" 0 0 10 ;
	setAttr ".lk" 6;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness" 0.5;
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_RightKneeEffector" -p "Character1_Ctrl_Reference";
	rename -uid "1E14E71D-4AB8-3896-5A3B-D9ACFC717C6C";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90 -89.999998657488334 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 6;
	setAttr ".radi" 2;
	setAttr -l on ".jo" -type "double3" -90.000000000000014 0 -89.999998657488348 ;
	setAttr -l on ".jo";
	setAttr ".tof" -type "double3" 0 0 10 ;
	setAttr ".lk" 6;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness" 0.5;
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_LeftElbowEffector" -p "Character1_Ctrl_Reference";
	rename -uid "A6A329EC-449D-BAB9-C356-64B3140FD66B";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 7;
	setAttr ".radi" 2;
	setAttr -l on ".jo" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".tof" -type "double3" 0 0 -10 ;
	setAttr ".lk" 6;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness" 0.5;
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_RightElbowEffector" -p "Character1_Ctrl_Reference";
	rename -uid "CB4C7F72-49CB-B9B2-9227-0C97BF02B454";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 8;
	setAttr ".radi" 2;
	setAttr -l on ".jo" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".tof" -type "double3" 0 0 -10 ;
	setAttr ".lk" 6;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness" 0.5;
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_ChestOriginEffector" -p "Character1_Ctrl_Reference";
	rename -uid "8DC5CD39-4777-037C-0592-6FAE37218F11";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -90 -90 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 9;
	setAttr ".radi" 2;
	setAttr -l on ".jo" -type "double3" 90 0 90 ;
	setAttr -l on ".jo";
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_ChestEndEffector" -p "Character1_Ctrl_Reference";
	rename -uid "2B305919-4B3B-443F-82A8-4BA53D140C0D";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -90 -90 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 10;
	setAttr ".radi" 15;
	setAttr -l on ".jo" -type "double3" 90 0 90 ;
	setAttr -l on ".jo";
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_LeftFootEffector" -p "Character1_Ctrl_Reference";
	rename -uid "5BD2BD4B-4ACA-1B92-C397-F68DC413A9F9";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -180 -89.999999999999986 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 11;
	setAttr ".radi" 6;
	setAttr -l on ".jo" -type "double3" -180 -89.999999999999986 0 ;
	setAttr -l on ".jo";
	setAttr ".rof" -type "double3" 90 0 0 ;
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_RightFootEffector" -p "Character1_Ctrl_Reference";
	rename -uid "55F35AAE-4755-330B-C2CF-699CAF5EA684";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -180 -89.999999999999986 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 12;
	setAttr ".radi" 6;
	setAttr -l on ".jo" -type "double3" -180 -89.999999999999986 0 ;
	setAttr -l on ".jo";
	setAttr ".rof" -type "double3" 90 0 0 ;
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_LeftShoulderEffector" -p "Character1_Ctrl_Reference";
	rename -uid "FD038D78-4D5A-B0DB-A064-DFA2BA8128B3";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 13;
	setAttr ".radi" 8;
	setAttr -l on ".jo" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".rof" -type "double3" 0 0 90 ;
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness" 0.5;
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_RightShoulderEffector" -p "Character1_Ctrl_Reference";
	rename -uid "9F6A877A-4037-CD58-76AD-8BAE05FE91F2";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 14;
	setAttr ".radi" 8;
	setAttr -l on ".jo" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".rof" -type "double3" 0 0 90 ;
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness" 0.5;
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_HeadEffector" -p "Character1_Ctrl_Reference";
	rename -uid "18A9B998-4DE3-93DB-735D-D3B6B4EEA7A6";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 4;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -90 -90 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 15;
	setAttr ".radi" 10;
	setAttr -l on ".jo" -type "double3" 90 0 90 ;
	setAttr -l on ".jo";
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_LeftHipEffector" -p "Character1_Ctrl_Reference";
	rename -uid "A0B520DE-424F-53AC-0EEE-1E81ADF8C3B9";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90 -89.999999999999986 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 16;
	setAttr ".radi" 8;
	setAttr -l on ".jo" -type "double3" -90 0 -89.999999999999986 ;
	setAttr -l on ".jo";
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikIKEffector -n "Character1_Ctrl_RightHipEffector" -p "Character1_Ctrl_Reference";
	rename -uid "25A3A2EF-4A95-DD33-FE32-42A3791FEF22";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	addAttr -ci true -sn "pull" -ln "pull" -min 0 -max 1 -at "double";
	addAttr -ci true -sn "stiffness" -ln "stiffness" -min 0 -max 1 -at "double";
	setAttr -k off -cb on ".v";
	setAttr ".ove" yes;
	setAttr ".ovc" 6;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90.000560494326749 -89.999996347381668 0 ;
	setAttr -l on ".ra";
	setAttr ".ei" 17;
	setAttr ".radi" 8;
	setAttr -l on ".jo" -type "double3" -89.99999999996426 -0.0005604943267384266 -90.000003652618318 ;
	setAttr -l on ".jo";
	setAttr ".lk" 1;
	setAttr -cb on ".pull";
	setAttr -cb on ".stiffness";
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_Hips" -p "Character1_Ctrl_Reference";
	rename -uid "99308032-411A-7663-5712-799757B72423";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -90 -90 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 90 0 90 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_LeftUpLeg" -p "Character1_Ctrl_Hips";
	rename -uid "0BB469EB-43B4-3D37-60EA-D6BC7138A384";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 8.9100008010864258 -6.2700042724609375 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90 -89.999999999999986 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -90 0 -89.999999999999986 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_LeftLeg" -p "Character1_Ctrl_LeftUpLeg";
	rename -uid "50719E15-4502-38D1-989A-E19E660613E0";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 0 -44.878639221191406 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90 -90 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -90 0 -90 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_LeftFoot" -p "Character1_Ctrl_LeftLeg";
	rename -uid "99BDAEE6-4D3A-43BE-A3E1-EB815F9E7C8E";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 0 -40.700960159301765 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 154.200858241437 -89.999965822788084 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -90.00007070166123 -64.200858241415929 -89.999921470981704 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_LeftToeBase" -p "Character1_Ctrl_LeftFoot";
	rename -uid "2480C0ED-4263-5E01-0776-A9892A252FCC";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr -l on ".t" -type "double3" 8.58306884765625e-06 -6.2623171806335449 12.954720497131348 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -180 -89.999999999999986 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -180 -89.999999999999986 0 ;
	setAttr -l on ".jo";
	setAttr ".radi" 0;
	setAttr ".lk" 0;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_RightUpLeg" -p "Character1_Ctrl_Hips";
	rename -uid "E1A5CC0D-42E7-48A1-0DC1-CC88895F3542";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" -8.9100008010864258 -6.2700042724609375 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90.000560494326749 -89.999996347381668 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -89.99999999996426 -0.0005604943267384266 -90.000003652618318 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_RightLeg" -p "Character1_Ctrl_RightUpLeg";
	rename -uid "90A1E176-426D-DA59-67E2-13A99AB8705F";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" -2.86102294921875e-06 -44.878639221191406 0.00043902400648221374 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90 -89.999998657488334 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -90.000000000000014 0 -89.999998657488348 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_RightFoot" -p "Character1_Ctrl_RightLeg";
	rename -uid "BA7161A8-4756-72EF-549A-B1842B51E829";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 9.5367431640625e-07 -40.700960159301758 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -25.799092755428251 -89.995678489082195 180 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -89.991060164130957 -64.20090690744297 -90.009929557987491 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_RightToeBase" -p "Character1_Ctrl_RightFoot";
	rename -uid "43D707B3-4130-DC6D-608D-AA929FAE0470";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr -l on ".t" -type "double3" -0.0010852813720703125 -6.2623171806335449 12.954748773539905 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -180 -89.999999999999986 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -180 -89.999999999999986 0 ;
	setAttr -l on ".jo";
	setAttr ".radi" 0;
	setAttr ".lk" 0;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_Spine" -p "Character1_Ctrl_Hips";
	rename -uid "591BA783-4ACD-4A96-BEFF-FC8A28793F3F";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 0 7 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -90 -90 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 90 0 90 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_Spine1" -p "Character1_Ctrl_Spine";
	rename -uid "F6593B91-48CE-1CB2-2967-AFA03E1E33C2";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 0 18.999999999999986 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -90 -90 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 90 0 90 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_LeftShoulder" -p "Character1_Ctrl_Spine1";
	rename -uid "8813A458-460B-2A20-ABDA-99A58E3F237F";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 7.0000004768371582 20.588546752929688 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 0 0 -0.00073486449242535516 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 0 0 0.00073486449242535516 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_LeftArm" -p "Character1_Ctrl_LeftShoulder";
	rename -uid "15469CEA-4E97-5313-A807-27AA6BEF8145";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 10.707250118255615 0.0001373291015625 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_LeftForeArm" -p "Character1_Ctrl_LeftArm";
	rename -uid "186B7135-4B5D-DE12-3BC7-30965AC1D86E";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 27.30546760559082 -2.8421709430404007e-14 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_LeftHand" -p "Character1_Ctrl_LeftForeArm";
	rename -uid "B2833FDA-4600-8C96-17D0-0AACE7D86953";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 26.6971435546875 -2.8421709430404007e-14 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_RightShoulder" -p "Character1_Ctrl_Spine1";
	rename -uid "8E17D125-49EE-6775-5F48-34AADE6C91FC";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" -6.9999995231628418 20.588546752929688 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 0 0 0.0022862395884207069 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 0 0 -0.0022862395884207069 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_RightArm" -p "Character1_Ctrl_RightShoulder";
	rename -uid "EC087995-427E-1494-BC21-7AB7790D8C96";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" -10.707275867462158 0.00042724609375 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_RightForeArm" -p "Character1_Ctrl_RightArm";
	rename -uid "5D7B7814-4720-0B4A-F819-9CA80DF4C02F";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" -27.305599212646488 0 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 89.999999999999986 0 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" -89.999999999999986 0 0 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_RightHand" -p "Character1_Ctrl_RightForeArm";
	rename -uid "39587DDD-4E0F-DE28-9D88-21AC7470DA5D";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" -26.696987152099588 -2.8421709430404007e-14 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" 90.000000000000014 0 180 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 90.000000000000014 0 180 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_Neck" -p "Character1_Ctrl_Spine1";
	rename -uid "E5C7ACBB-4C61-41BD-116A-22848AD464C0";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 0 19 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -90 -90 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 90 0 90 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode hikFKJoint -n "Character1_Ctrl_Head" -p "Character1_Ctrl_Neck";
	rename -uid "D0887901-4262-491F-04D7-DA97DE2A270D";
	addAttr -s false -ci true -sn "ch" -ln "ControlSet" -at "message";
	setAttr -k off -cb on ".v";
	setAttr ".uoc" 1;
	setAttr ".oc" 1;
	setAttr ".ovc" 25;
	setAttr -l on ".t" -type "double3" 0 20 0 ;
	setAttr -l on ".t";
	setAttr -k off ".tx";
	setAttr -k off ".ty";
	setAttr -k off ".tz";
	setAttr -l on ".s";
	setAttr -k off ".sx";
	setAttr -k off ".sy";
	setAttr -k off ".sz";
	setAttr -l on ".ra" -type "double3" -90 -90 0 ;
	setAttr -l on ".ra";
	setAttr -l on ".jo" -type "double3" 90 0 90 ;
	setAttr -l on ".jo";
	setAttr ".radi" 4;
instanceable -a 0;
createNode lightLinker -s -n "lightLinker1";
	rename -uid "FDD9889D-434E-3BCF-2C56-C59BFF67B0B1";
	setAttr -s 2 ".lnk";
	setAttr -s 2 ".slnk";
createNode shapeEditorManager -n "shapeEditorManager";
	rename -uid "DC2CF3C6-45F8-BD78-27F1-55A71AD7387A";
createNode poseInterpolatorManager -n "poseInterpolatorManager";
	rename -uid "522F7655-4ACE-2FB3-E440-EEB665DF86DB";
createNode displayLayerManager -n "layerManager";
	rename -uid "294ED969-4E31-E329-7577-FF90E7F50480";
createNode displayLayer -n "defaultLayer";
	rename -uid "19D09D7C-4D59-2CD4-5EC4-6CB463042F23";
createNode renderLayerManager -n "renderLayerManager";
	rename -uid "1E24CFAA-43C5-7C75-5523-1D92DEEB7F6B";
createNode renderLayer -n "defaultRenderLayer";
	rename -uid "B69E7135-41C4-41DC-58A6-83B85C64D885";
	setAttr ".g" yes;
createNode HIKCharacterNode -n "Character1";
	rename -uid "197CF4EA-4A43-6109-9DFC-FCB723D0D478";
	setAttr ".OutputCharacterDefinition" -type "HIKCharacter" ;
	setAttr ".InputCharacterizationLock" yes;
	setAttr ".ReferenceMinRLimitx" -45;
	setAttr ".ReferenceMinRLimity" -45;
	setAttr ".ReferenceMinRLimitz" -45;
	setAttr ".ReferenceMaxRLimitx" 45;
	setAttr ".ReferenceMaxRLimity" 45;
	setAttr ".ReferenceMaxRLimitz" 45;
	setAttr ".HipsTy" 100;
	setAttr ".HipsMinRLimitx" -45;
	setAttr ".HipsMinRLimity" -45;
	setAttr ".HipsMinRLimitz" -45;
	setAttr ".HipsMaxRLimitx" 45;
	setAttr ".HipsMaxRLimity" 45;
	setAttr ".HipsMaxRLimitz" 45;
	setAttr ".LeftUpLegTx" 8.9100008010000007;
	setAttr ".LeftUpLegTy" 93.729999539999994;
	setAttr ".LeftUpLegMinRLimitx" -45;
	setAttr ".LeftUpLegMinRLimity" -45;
	setAttr ".LeftUpLegMinRLimitz" -45;
	setAttr ".LeftUpLegMaxRLimitx" 45;
	setAttr ".LeftUpLegMaxRLimity" 45;
	setAttr ".LeftUpLegMaxRLimitz" 45;
	setAttr ".LeftLegTx" 8.9100008010000007;
	setAttr ".LeftLegTy" 48.851354600000001;
	setAttr ".LeftLegMinRLimitx" -45;
	setAttr ".LeftLegMinRLimity" -45;
	setAttr ".LeftLegMinRLimitz" -45;
	setAttr ".LeftLegMaxRLimitx" 45;
	setAttr ".LeftLegMaxRLimity" 45;
	setAttr ".LeftLegMaxRLimitz" 45;
	setAttr ".LeftFootTx" 8.9100008010000007;
	setAttr ".LeftFootTy" 8.1503963469999974;
	setAttr ".LeftFootMinRLimitx" -45;
	setAttr ".LeftFootMinRLimity" -45;
	setAttr ".LeftFootMinRLimitz" -45;
	setAttr ".LeftFootMaxRLimitx" 45;
	setAttr ".LeftFootMaxRLimity" 45;
	setAttr ".LeftFootMaxRLimitz" 45;
	setAttr ".RightUpLegTx" -8.9100008010000007;
	setAttr ".RightUpLegTy" 93.729999539999994;
	setAttr ".RightUpLegMinRLimitx" -45;
	setAttr ".RightUpLegMinRLimity" -45;
	setAttr ".RightUpLegMinRLimitz" -45;
	setAttr ".RightUpLegMaxRLimitx" 45;
	setAttr ".RightUpLegMaxRLimity" 45;
	setAttr ".RightUpLegMaxRLimitz" 45;
	setAttr ".RightLegTx" -8.9100035169999998;
	setAttr ".RightLegTy" 48.851354600000001;
	setAttr ".RightLegTz" 0.00043902399999999999;
	setAttr ".RightLegMinRLimitx" -45;
	setAttr ".RightLegMinRLimity" -45;
	setAttr ".RightLegMinRLimitz" -45;
	setAttr ".RightLegMaxRLimitx" 45;
	setAttr ".RightLegMaxRLimity" 45;
	setAttr ".RightLegMaxRLimitz" 45;
	setAttr ".RightFootTx" -8.9100025980000002;
	setAttr ".RightFootTy" 8.1503963509999977;
	setAttr ".RightFootTz" 0.00043902399999999999;
	setAttr ".RightFootMinRLimitx" -45;
	setAttr ".RightFootMinRLimity" -45;
	setAttr ".RightFootMinRLimitz" -45;
	setAttr ".RightFootMaxRLimitx" 45;
	setAttr ".RightFootMaxRLimity" 45;
	setAttr ".RightFootMaxRLimitz" 45;
	setAttr ".SpineTy" 107;
	setAttr ".SpineMinRLimitx" -45;
	setAttr ".SpineMinRLimity" -45;
	setAttr ".SpineMinRLimitz" -45;
	setAttr ".SpineMaxRLimitx" 45;
	setAttr ".SpineMaxRLimity" 45;
	setAttr ".SpineMaxRLimitz" 45;
	setAttr ".LeftArmTx" 17.707251070000005;
	setAttr ".LeftArmTy" 146.58868419999996;
	setAttr ".LeftArmRz" -0.00073528200000000084;
	setAttr ".LeftArmJointOrientz" -0.00073528200000000073;
	setAttr ".LeftArmMinRLimitx" -45;
	setAttr ".LeftArmMinRLimity" -45;
	setAttr ".LeftArmMinRLimitz" -45;
	setAttr ".LeftArmMaxRLimitx" 45;
	setAttr ".LeftArmMaxRLimity" 45;
	setAttr ".LeftArmMaxRLimitz" 45;
	setAttr ".LeftForeArmTx" 45.012716769999997;
	setAttr ".LeftForeArmTy" 146.58868419999999;
	setAttr ".LeftForeArmRz" 0.0044116920000000026;
	setAttr ".LeftForeArmJointOrientz" 0.0051469740000000029;
	setAttr ".LeftForeArmMinRLimitx" -45;
	setAttr ".LeftForeArmMinRLimity" -45;
	setAttr ".LeftForeArmMinRLimitz" -45;
	setAttr ".LeftForeArmMaxRLimitx" 45;
	setAttr ".LeftForeArmMaxRLimity" 45;
	setAttr ".LeftForeArmMaxRLimitz" 45;
	setAttr ".LeftHandTx" 71.709864140000008;
	setAttr ".LeftHandTy" 146.58868420000002;
	setAttr ".LeftHandRz" -0.011029230000000011;
	setAttr ".LeftHandJointOrientz" -0.015440922000000015;
	setAttr ".LeftHandMinRLimitx" -45;
	setAttr ".LeftHandMinRLimity" -45;
	setAttr ".LeftHandMinRLimitz" -45;
	setAttr ".LeftHandMaxRLimitx" 45;
	setAttr ".LeftHandMaxRLimity" 45;
	setAttr ".LeftHandMaxRLimitz" 45;
	setAttr ".RightArmTx" -17.707274910000002;
	setAttr ".RightArmTy" 146.58898000000002;
	setAttr ".RightArmRz" 0.0023183610000000036;
	setAttr ".RightArmJointOrientz" 0.0023183610000000032;
	setAttr ".RightArmMinRLimitx" -45;
	setAttr ".RightArmMinRLimity" -45;
	setAttr ".RightArmMinRLimitz" -45;
	setAttr ".RightArmMaxRLimitx" 45;
	setAttr ".RightArmMaxRLimity" 45;
	setAttr ".RightArmMaxRLimitz" 45;
	setAttr ".RightForeArmTx" -45.012873159999998;
	setAttr ".RightForeArmTy" 146.58898;
	setAttr ".RightForeArmRz" -0.013910166000000015;
	setAttr ".RightForeArmJointOrientz" -0.01622852700000002;
	setAttr ".RightForeArmMinRLimitx" -45;
	setAttr ".RightForeArmMinRLimity" -45;
	setAttr ".RightForeArmMinRLimitz" -45;
	setAttr ".RightForeArmMaxRLimitx" 45;
	setAttr ".RightForeArmMaxRLimity" 45;
	setAttr ".RightForeArmMaxRLimitz" 45;
	setAttr ".RightHandTx" -71.709861270000005;
	setAttr ".RightHandTy" 146.58897870000001;
	setAttr ".RightHandRz" 0.034775415000000018;
	setAttr ".RightHandJointOrientz" 0.048685581000000019;
	setAttr ".RightHandMinRLimitx" -45;
	setAttr ".RightHandMinRLimity" -45;
	setAttr ".RightHandMinRLimitz" -45;
	setAttr ".RightHandMaxRLimitx" 45;
	setAttr ".RightHandMaxRLimity" 45;
	setAttr ".RightHandMaxRLimitz" 45;
	setAttr ".HeadTy" 165;
	setAttr ".HeadMinRLimitx" -45;
	setAttr ".HeadMinRLimity" -45;
	setAttr ".HeadMinRLimitz" -45;
	setAttr ".HeadMaxRLimitx" 45;
	setAttr ".HeadMaxRLimity" 45;
	setAttr ".HeadMaxRLimitz" 45;
	setAttr ".LeftToeBaseTx" 8.9100092279999998;
	setAttr ".LeftToeBaseTy" 1.8880791539999997;
	setAttr ".LeftToeBaseTz" 12.9547209;
	setAttr ".LeftToeBaseMinRLimitx" -45;
	setAttr ".LeftToeBaseMinRLimity" -45;
	setAttr ".LeftToeBaseMinRLimitz" -45;
	setAttr ".LeftToeBaseMaxRLimitx" 45;
	setAttr ".LeftToeBaseMaxRLimity" 45;
	setAttr ".LeftToeBaseMaxRLimitz" 45;
	setAttr ".RightToeBaseTx" -8.9110879790000013;
	setAttr ".RightToeBaseTy" 1.8880791709999984;
	setAttr ".RightToeBaseTz" 12.955188090000002;
	setAttr ".RightToeBaseRy" 0.0048003860000000002;
	setAttr ".RightToeBaseJointOrienty" 0.0048003860000000002;
	setAttr ".RightToeBaseMinRLimitx" -45;
	setAttr ".RightToeBaseMinRLimity" -45;
	setAttr ".RightToeBaseMinRLimitz" -45;
	setAttr ".RightToeBaseMaxRLimitx" 45;
	setAttr ".RightToeBaseMaxRLimity" 45;
	setAttr ".RightToeBaseMaxRLimitz" 45;
	setAttr ".LeftShoulderTx" 7.0000004770000004;
	setAttr ".LeftShoulderTy" 146.58854679999999;
	setAttr ".LeftShoulderMinRLimitx" -45;
	setAttr ".LeftShoulderMinRLimity" -45;
	setAttr ".LeftShoulderMinRLimitz" -45;
	setAttr ".LeftShoulderMaxRLimitx" 45;
	setAttr ".LeftShoulderMaxRLimity" 45;
	setAttr ".LeftShoulderMaxRLimitz" 45;
	setAttr ".RightShoulderTx" -6.9999995229999996;
	setAttr ".RightShoulderTy" 146.58854679999999;
	setAttr ".RightShoulderMinRLimitx" -45;
	setAttr ".RightShoulderMinRLimity" -45;
	setAttr ".RightShoulderMinRLimitz" -45;
	setAttr ".RightShoulderMaxRLimitx" 45;
	setAttr ".RightShoulderMaxRLimity" 45;
	setAttr ".RightShoulderMaxRLimitz" 45;
	setAttr ".NeckTy" 145;
	setAttr ".NeckMinRLimitx" -45;
	setAttr ".NeckMinRLimity" -45;
	setAttr ".NeckMinRLimitz" -45;
	setAttr ".NeckMaxRLimitx" 45;
	setAttr ".NeckMaxRLimity" 45;
	setAttr ".NeckMaxRLimitz" 45;
	setAttr ".LeftFingerBaseTx" 80.519743439999999;
	setAttr ".LeftFingerBaseTy" 147.08957459999999;
	setAttr ".LeftFingerBaseTz" 1.304684401;
	setAttr ".LeftFingerBaseRy" -0.0035633340000000005;
	setAttr ".RightFingerBaseTx" -80.519626680000002;
	setAttr ".RightFingerBaseTy" 147.0898718;
	setAttr ".RightFingerBaseTz" 1.305458317;
	setAttr ".RightFingerBaseRy" -2.0000646359999998;
	setAttr ".Spine1Ty" 126;
	setAttr ".Spine1MinRLimitx" -45;
	setAttr ".Spine1MinRLimity" -45;
	setAttr ".Spine1MinRLimitz" -45;
	setAttr ".Spine1MaxRLimitx" 45;
	setAttr ".Spine1MaxRLimity" 45;
	setAttr ".Spine1MaxRLimitz" 45;
	setAttr ".Spine2Ty" 132.33333333333334;
	setAttr ".Spine2MinRLimitx" -45;
	setAttr ".Spine2MinRLimity" -45;
	setAttr ".Spine2MinRLimitz" -45;
	setAttr ".Spine2MaxRLimitx" 45;
	setAttr ".Spine2MaxRLimity" 45;
	setAttr ".Spine2MaxRLimitz" 45;
	setAttr ".Spine3Ty" 119;
	setAttr ".Spine4Ty" 123;
	setAttr ".Spine5Ty" 127;
	setAttr ".Spine6Ty" 131;
	setAttr ".Spine7Ty" 135;
	setAttr ".Spine8Ty" 139;
	setAttr ".Spine9Ty" 143;
	setAttr ".Neck1Ty" 147;
	setAttr ".Neck2Ty" 149;
	setAttr ".Neck3Ty" 151;
	setAttr ".Neck4Ty" 153;
	setAttr ".Neck5Ty" 155;
	setAttr ".Neck6Ty" 157;
	setAttr ".Neck7Ty" 159;
	setAttr ".Neck8Ty" 161;
	setAttr ".Neck9Ty" 163;
	setAttr ".LeftUpLegRollTx" 8.9100008010000007;
	setAttr ".LeftUpLegRollTy" 71.290677070000001;
	setAttr ".LeftLegRollTx" 8.9100008010000007;
	setAttr ".LeftLegRollTy" 28.500875473499999;
	setAttr ".RightUpLegRollTx" -8.9100021590000011;
	setAttr ".RightUpLegRollTy" 71.290677070000001;
	setAttr ".RightUpLegRollTz" 0.00021951199999999999;
	setAttr ".RightLegRollTx" -8.9100030574999991;
	setAttr ".RightLegRollTy" 28.500875475499999;
	setAttr ".RightLegRollTz" 0.00043902399999999999;
	setAttr ".LeftArmRollTx" 31.359983920000001;
	setAttr ".LeftArmRollTy" 146.58868419999999;
	setAttr ".LeftForeArmRollTx" 58.361290455000002;
	setAttr ".LeftForeArmRollTy" 146.58868419999999;
	setAttr ".RightArmRollTx" -31.360074035;
	setAttr ".RightArmRollTy" 146.58898;
	setAttr ".RightForeArmRollTx" -58.361367215000001;
	setAttr ".RightForeArmRollTy" 146.58897935000002;
	setAttr ".HipsTranslationTy" 100;
	setAttr ".LeftHandThumb1Tx" 76.058620989999994;
	setAttr ".LeftHandThumb1Ty" 145.79018170000001;
	setAttr ".LeftHandThumb1Tz" 4.2824339670000002;
	setAttr ".LeftHandThumb1JointOrientz" 9.7062825972397362e-20;
	setAttr ".LeftHandThumb1MinRLimitx" -45;
	setAttr ".LeftHandThumb1MinRLimity" -45;
	setAttr ".LeftHandThumb1MinRLimitz" -45;
	setAttr ".LeftHandThumb1MaxRLimitx" 45;
	setAttr ".LeftHandThumb1MaxRLimity" 45;
	setAttr ".LeftHandThumb1MaxRLimitz" 45;
	setAttr ".LeftHandThumb2Tx" 78.571210930000007;
	setAttr ".LeftHandThumb2Ty" 145.25408229999999;
	setAttr ".LeftHandThumb2Tz" 4.9898882909999998;
	setAttr ".LeftHandThumb2JointOrientz" 9.7062825972397362e-20;
	setAttr ".LeftHandThumb2MinRLimitx" -45;
	setAttr ".LeftHandThumb2MinRLimity" -45;
	setAttr ".LeftHandThumb2MinRLimitz" -45;
	setAttr ".LeftHandThumb2MaxRLimitx" 45;
	setAttr ".LeftHandThumb2MaxRLimity" 45;
	setAttr ".LeftHandThumb2MaxRLimitz" 45;
	setAttr ".LeftHandThumb3Tx" 81.114351339999985;
	setAttr ".LeftHandThumb3Ty" 145.25406910000001;
	setAttr ".LeftHandThumb3Tz" 4.989897633;
	setAttr ".LeftHandThumb3JointOrientz" 0.00029786200000000019;
	setAttr ".LeftHandThumb3MinRLimitx" -45;
	setAttr ".LeftHandThumb3MinRLimity" -45;
	setAttr ".LeftHandThumb3MinRLimitz" -45;
	setAttr ".LeftHandThumb3MaxRLimitx" 45;
	setAttr ".LeftHandThumb3MaxRLimity" 45;
	setAttr ".LeftHandThumb3MaxRLimitz" 45;
	setAttr ".LeftHandThumb4Tx" 83.781097480000028;
	setAttr ".LeftHandThumb4Ty" 145.254072;
	setAttr ".LeftHandThumb4Tz" 4.9898894219999983;
	setAttr ".LeftHandThumb4JointOrientz" -0.00059572400000000028;
	setAttr ".LeftHandThumb4MinRLimitx" -45;
	setAttr ".LeftHandThumb4MinRLimity" -45;
	setAttr ".LeftHandThumb4MinRLimitz" -45;
	setAttr ".LeftHandThumb4MaxRLimitx" 45;
	setAttr ".LeftHandThumb4MaxRLimity" 45;
	setAttr ".LeftHandThumb4MaxRLimitz" 45;
	setAttr ".LeftHandIndex1Tx" 80.531840860000003;
	setAttr ".LeftHandIndex1Ty" 146.7884134;
	setAttr ".LeftHandIndex1Tz" 3.4716694160000001;
	setAttr ".LeftHandIndex1JointOrientz" 9.7062825972397362e-20;
	setAttr ".LeftHandIndex1MinRLimitx" -45;
	setAttr ".LeftHandIndex1MinRLimity" -45;
	setAttr ".LeftHandIndex1MinRLimitz" -45;
	setAttr ".LeftHandIndex1MaxRLimitx" 45;
	setAttr ".LeftHandIndex1MaxRLimity" 45;
	setAttr ".LeftHandIndex1MaxRLimitz" 45;
	setAttr ".LeftHandIndex2Tx" 84.75459545999999;
	setAttr ".LeftHandIndex2Ty" 146.7883913;
	setAttr ".LeftHandIndex2Tz" 3.6188684349999996;
	setAttr ".LeftHandIndex2JointOrientx" 1.0453217981918744e-05;
	setAttr ".LeftHandIndex2JointOrienty" 1.9999999849726942;
	setAttr ".LeftHandIndex2JointOrientz" 0.00029952346159721211;
	setAttr ".LeftHandIndex2MinRLimitx" -45;
	setAttr ".LeftHandIndex2MinRLimity" -45;
	setAttr ".LeftHandIndex2MinRLimitz" -45;
	setAttr ".LeftHandIndex2MaxRLimitx" 45;
	setAttr ".LeftHandIndex2MaxRLimity" 45;
	setAttr ".LeftHandIndex2MaxRLimitz" 45;
	setAttr ".LeftHandIndex3Tx" 87.406920910000011;
	setAttr ".LeftHandIndex3Ty" 146.7883775;
	setAttr ".LeftHandIndex3Tz" 3.711324415;
	setAttr ".LeftHandIndex3JointOrientx" 1.0453217981918733e-05;
	setAttr ".LeftHandIndex3JointOrienty" 1.9999999849726937;
	setAttr ".LeftHandIndex3JointOrientz" 0.000299523461597212;
	setAttr ".LeftHandIndex3MinRLimitx" -45;
	setAttr ".LeftHandIndex3MinRLimity" -45;
	setAttr ".LeftHandIndex3MinRLimitz" -45;
	setAttr ".LeftHandIndex3MaxRLimitx" 45;
	setAttr ".LeftHandIndex3MaxRLimity" 45;
	setAttr ".LeftHandIndex3MaxRLimitz" 45;
	setAttr ".LeftHandIndex4Tx" 89.363955140000016;
	setAttr ".LeftHandIndex4Ty" 146.7883673;
	setAttr ".LeftHandIndex4Tz" 3.7795433149999997;
	setAttr ".LeftHandIndex4JointOrientx" 1.0453217981918734e-05;
	setAttr ".LeftHandIndex4JointOrienty" 1.9999999849726937;
	setAttr ".LeftHandIndex4JointOrientz" 0.000299523461597212;
	setAttr ".LeftHandIndex4MinRLimitx" -45;
	setAttr ".LeftHandIndex4MinRLimity" -45;
	setAttr ".LeftHandIndex4MinRLimitz" -45;
	setAttr ".LeftHandIndex4MaxRLimitx" 45;
	setAttr ".LeftHandIndex4MaxRLimity" 45;
	setAttr ".LeftHandIndex4MaxRLimitz" 45;
	setAttr ".LeftHandMiddle1Tx" 80.51974349999999;
	setAttr ".LeftHandMiddle1Ty" 147.08957470000001;
	setAttr ".LeftHandMiddle1Tz" 1.3046843809999999;
	setAttr ".LeftHandMiddle1JointOrientz" 0.0029411280000000016;
	setAttr ".LeftHandMiddle1MinRLimitx" -45;
	setAttr ".LeftHandMiddle1MinRLimity" -45;
	setAttr ".LeftHandMiddle1MinRLimitz" -45;
	setAttr ".LeftHandMiddle1MaxRLimitx" 45;
	setAttr ".LeftHandMiddle1MaxRLimity" 45;
	setAttr ".LeftHandMiddle1MaxRLimitz" 45;
	setAttr ".LeftHandMiddle2Tx" 85.382995180000023;
	setAttr ".LeftHandMiddle2Ty" 147.08957469999999;
	setAttr ".LeftHandMiddle2Tz" 1.3049868360000001;
	setAttr ".LeftHandMiddle2JointOrienty" 0.0035633340000000044;
	setAttr ".LeftHandMiddle2JointOrientz" -0.0007352820000000004;
	setAttr ".LeftHandMiddle2MinRLimitx" -45;
	setAttr ".LeftHandMiddle2MinRLimity" -45;
	setAttr ".LeftHandMiddle2MinRLimitz" -45;
	setAttr ".LeftHandMiddle2MaxRLimitx" 45;
	setAttr ".LeftHandMiddle2MaxRLimity" 45;
	setAttr ".LeftHandMiddle2MaxRLimitz" 45;
	setAttr ".LeftHandMiddle3Tx" 88.148231790000054;
	setAttr ".LeftHandMiddle3Ty" 147.08957469999999;
	setAttr ".LeftHandMiddle3Tz" 1.305158619;
	setAttr ".LeftHandMiddle3JointOrienty" -0.010690002000000009;
	setAttr ".LeftHandMiddle3JointOrientz" 1.1053203131447234e-27;
	setAttr ".LeftHandMiddle3MinRLimitx" -45;
	setAttr ".LeftHandMiddle3MinRLimity" -45;
	setAttr ".LeftHandMiddle3MinRLimitz" -45;
	setAttr ".LeftHandMiddle3MaxRLimitx" 45;
	setAttr ".LeftHandMiddle3MaxRLimity" 45;
	setAttr ".LeftHandMiddle3MaxRLimitz" 45;
	setAttr ".LeftHandMiddle4Tx" 90.153863950000002;
	setAttr ".LeftHandMiddle4Ty" 147.08957470000001;
	setAttr ".LeftHandMiddle4Tz" 1.3052822150000003;
	setAttr ".LeftHandMiddle4JointOrienty" 0.010690002000000007;
	setAttr ".LeftHandMiddle4MinRLimitx" -45;
	setAttr ".LeftHandMiddle4MinRLimity" -45;
	setAttr ".LeftHandMiddle4MinRLimitz" -45;
	setAttr ".LeftHandMiddle4MaxRLimitx" 45;
	setAttr ".LeftHandMiddle4MaxRLimity" 45;
	setAttr ".LeftHandMiddle4MaxRLimitz" 45;
	setAttr ".LeftHandRing1Tx" 80.603623929999998;
	setAttr ".LeftHandRing1Ty" 146.96860380000001;
	setAttr ".LeftHandRing1Tz" -0.79315890899999997;
	setAttr ".LeftHandRing1JointOrientz" -9.7062825972397362e-20;
	setAttr ".LeftHandRing1MinRLimitx" -45;
	setAttr ".LeftHandRing1MinRLimity" -45;
	setAttr ".LeftHandRing1MinRLimitz" -45;
	setAttr ".LeftHandRing1MaxRLimitx" 45;
	setAttr ".LeftHandRing1MaxRLimity" 45;
	setAttr ".LeftHandRing1MaxRLimitz" 45;
	setAttr ".LeftHandRing2Tx" 85.141382759999985;
	setAttr ".LeftHandRing2Ty" 146.96860380000001;
	setAttr ".LeftHandRing2Tz" -0.79315882000000004;
	setAttr ".LeftHandRing2JointOrienty" 0.003563528999999998;
	setAttr ".LeftHandRing2JointOrientz" -9.7062825972397362e-20;
	setAttr ".LeftHandRing2MinRLimitx" -45;
	setAttr ".LeftHandRing2MinRLimity" -45;
	setAttr ".LeftHandRing2MinRLimitz" -45;
	setAttr ".LeftHandRing2MaxRLimitx" 45;
	setAttr ".LeftHandRing2MaxRLimity" 45;
	setAttr ".LeftHandRing2MaxRLimitz" 45;
	setAttr ".LeftHandRing3Tx" 87.445908619999997;
	setAttr ".LeftHandRing3Ty" 146.96860380000001;
	setAttr ".LeftHandRing3Tz" -0.79315893699999995;
	setAttr ".LeftHandRing3JointOrientx" 6.0368529391003189e-24;
	setAttr ".LeftHandRing3JointOrienty" 1.5530052155583578e-18;
	setAttr ".LeftHandRing3JointOrientz" -9.7062825784665379e-20;
	setAttr ".LeftHandRing3MinRLimitx" -45;
	setAttr ".LeftHandRing3MinRLimity" -45;
	setAttr ".LeftHandRing3MinRLimitz" -45;
	setAttr ".LeftHandRing3MaxRLimitx" 45;
	setAttr ".LeftHandRing3MaxRLimity" 45;
	setAttr ".LeftHandRing3MaxRLimitz" 45;
	setAttr ".LeftHandRing4Tx" 89.369255979999991;
	setAttr ".LeftHandRing4Ty" 146.96860380000001;
	setAttr ".LeftHandRing4Tz" -0.79315975400000005;
	setAttr ".LeftHandRing4JointOrientx" 6.0368529391003189e-24;
	setAttr ".LeftHandRing4JointOrienty" 1.5530052155583578e-18;
	setAttr ".LeftHandRing4JointOrientz" -9.7062825784665379e-20;
	setAttr ".LeftHandRing4MinRLimitx" -45;
	setAttr ".LeftHandRing4MinRLimity" -45;
	setAttr ".LeftHandRing4MinRLimitz" -45;
	setAttr ".LeftHandRing4MaxRLimitx" 45;
	setAttr ".LeftHandRing4MaxRLimity" 45;
	setAttr ".LeftHandRing4MaxRLimitz" 45;
	setAttr ".LeftHandPinky1Tx" 80.592138829999996;
	setAttr ".LeftHandPinky1Ty" 146.27565720000001;
	setAttr ".LeftHandPinky1Tz" -2.4903564650000001;
	setAttr ".LeftHandPinky1JointOrientz" 0.0007352820000000004;
	setAttr ".LeftHandPinky1MinRLimitx" -45;
	setAttr ".LeftHandPinky1MinRLimity" -45;
	setAttr ".LeftHandPinky1MinRLimitz" -45;
	setAttr ".LeftHandPinky1MaxRLimitx" 45;
	setAttr ".LeftHandPinky1MaxRLimity" 45;
	setAttr ".LeftHandPinky1MaxRLimitz" 45;
	setAttr ".LeftHandPinky2Tx" 83.636238160000005;
	setAttr ".LeftHandPinky2Ty" 146.27569780000002;
	setAttr ".LeftHandPinky2Tz" -2.4903564650000001;
	setAttr ".LeftHandPinky2JointOrientz" -0.00076302599999999933;
	setAttr ".LeftHandPinky2MinRLimitx" -45;
	setAttr ".LeftHandPinky2MinRLimity" -45;
	setAttr ".LeftHandPinky2MinRLimitz" -45;
	setAttr ".LeftHandPinky2MaxRLimitx" 45;
	setAttr ".LeftHandPinky2MaxRLimity" 45;
	setAttr ".LeftHandPinky2MaxRLimitz" 45;
	setAttr ".LeftHandPinky3Tx" 85.610739649999971;
	setAttr ".LeftHandPinky3Ty" 146.27572409999988;
	setAttr ".LeftHandPinky3Tz" -2.4903566079999999;
	setAttr ".LeftHandPinky3JointOrientz" 0.0015260519999999984;
	setAttr ".LeftHandPinky3MinRLimitx" -45;
	setAttr ".LeftHandPinky3MinRLimity" -45;
	setAttr ".LeftHandPinky3MinRLimitz" -45;
	setAttr ".LeftHandPinky3MaxRLimitx" 45;
	setAttr ".LeftHandPinky3MaxRLimity" 45;
	setAttr ".LeftHandPinky3MaxRLimitz" 45;
	setAttr ".LeftHandPinky4Tx" 87.277354299999999;
	setAttr ".LeftHandPinky4Ty" 146.27574630000001;
	setAttr ".LeftHandPinky4Tz" -2.4903558170000002;
	setAttr ".LeftHandPinky4JointOrientz" -0.00076302599999999933;
	setAttr ".LeftHandPinky4MinRLimitx" -45;
	setAttr ".LeftHandPinky4MinRLimity" -45;
	setAttr ".LeftHandPinky4MinRLimitz" -45;
	setAttr ".LeftHandPinky4MaxRLimitx" 45;
	setAttr ".LeftHandPinky4MaxRLimity" 45;
	setAttr ".LeftHandPinky4MaxRLimitz" 45;
	setAttr ".LeftHandExtraFinger1Tx" 80.592138829999996;
	setAttr ".LeftHandExtraFinger1Ty" 146.7884134;
	setAttr ".LeftHandExtraFinger1Tz" -4.4903564649999996;
	setAttr ".LeftHandExtraFinger1Ry" -1.9999999850000001;
	setAttr ".LeftHandExtraFinger1Rz" -0.00029934100000000001;
	setAttr ".LeftHandExtraFinger2Tx" 82.636238160000005;
	setAttr ".LeftHandExtraFinger2Ty" 146.7883913;
	setAttr ".LeftHandExtraFinger2Tz" -4.4903564649999996;
	setAttr ".LeftHandExtraFinger2Ry" -1.9999999850000001;
	setAttr ".LeftHandExtraFinger2Rz" -0.00029934100000000001;
	setAttr ".LeftHandExtraFinger3Tx" 84.610739649999999;
	setAttr ".LeftHandExtraFinger3Ty" 146.7883775;
	setAttr ".LeftHandExtraFinger3Tz" -4.4903566079999999;
	setAttr ".LeftHandExtraFinger3Ry" -1.9999999850000001;
	setAttr ".LeftHandExtraFinger3Rz" -0.00029934100000000001;
	setAttr ".LeftHandExtraFinger4Tx" 86.277354299999999;
	setAttr ".LeftHandExtraFinger4Ty" 146.7883673;
	setAttr ".LeftHandExtraFinger4Tz" -4.4903558170000002;
	setAttr ".LeftHandExtraFinger4Ry" -1.9999999850000001;
	setAttr ".LeftHandExtraFinger4Rz" -0.00029934100000000001;
	setAttr ".RightHandThumb1Tx" -76.058242059999998;
	setAttr ".RightHandThumb1Ty" 145.7904806;
	setAttr ".RightHandThumb1Tz" 4.2828147379999999;
	setAttr ".RightHandThumb1JointOrientz" -3.8825130388958945e-19;
	setAttr ".RightHandThumb1MinRLimitx" -45;
	setAttr ".RightHandThumb1MinRLimity" -45;
	setAttr ".RightHandThumb1MinRLimitz" -45;
	setAttr ".RightHandThumb1MaxRLimitx" 45;
	setAttr ".RightHandThumb1MaxRLimity" 45;
	setAttr ".RightHandThumb1MaxRLimitz" 45;
	setAttr ".RightHandThumb2Tx" -78.570769569999996;
	setAttr ".RightHandThumb2Ty" 145.25438170000001;
	setAttr ".RightHandThumb2Tz" 4.9904913879999997;
	setAttr ".RightHandThumb2JointOrientz" -3.8825130388958945e-19;
	setAttr ".RightHandThumb2MinRLimitx" -45;
	setAttr ".RightHandThumb2MinRLimity" -45;
	setAttr ".RightHandThumb2MinRLimitz" -45;
	setAttr ".RightHandThumb2MaxRLimitx" 45;
	setAttr ".RightHandThumb2MaxRLimity" 45;
	setAttr ".RightHandThumb2MaxRLimitz" 45;
	setAttr ".RightHandThumb3Tx" -81.112358929999985;
	setAttr ".RightHandThumb3Ty" 145.25440850000001;
	setAttr ".RightHandThumb3Tz" 5.0793117030000001;
	setAttr ".RightHandThumb3JointOrientz" 0.00060208599999999918;
	setAttr ".RightHandThumb3MinRLimitx" -45;
	setAttr ".RightHandThumb3MinRLimity" -45;
	setAttr ".RightHandThumb3MinRLimitz" -45;
	setAttr ".RightHandThumb3MaxRLimitx" 45;
	setAttr ".RightHandThumb3MaxRLimity" 45;
	setAttr ".RightHandThumb3MaxRLimitz" 45;
	setAttr ".RightHandThumb4Tx" -83.777478690000024;
	setAttr ".RightHandThumb4Ty" 145.25442679999998;
	setAttr ".RightHandThumb4Tz" 5.1724490200000011;
	setAttr ".RightHandThumb4JointOrientz" -0.00081267799999999875;
	setAttr ".RightHandThumb4MinRLimitx" -45;
	setAttr ".RightHandThumb4MinRLimity" -45;
	setAttr ".RightHandThumb4MinRLimitz" -45;
	setAttr ".RightHandThumb4MaxRLimitx" 45;
	setAttr ".RightHandThumb4MaxRLimity" 45;
	setAttr ".RightHandThumb4MaxRLimitz" 45;
	setAttr ".RightHandIndex1Tx" -80.531533929999995;
	setAttr ".RightHandIndex1Ty" 146.78871240000001;
	setAttr ".RightHandIndex1Tz" 3.4724442959999999;
	setAttr ".RightHandIndex1JointOrientz" -3.8825130388958945e-19;
	setAttr ".RightHandIndex1MinRLimitx" -45;
	setAttr ".RightHandIndex1MinRLimity" -45;
	setAttr ".RightHandIndex1MinRLimitz" -45;
	setAttr ".RightHandIndex1MaxRLimitx" 45;
	setAttr ".RightHandIndex1MaxRLimity" 45;
	setAttr ".RightHandIndex1MaxRLimitz" 45;
	setAttr ".RightHandIndex2Tx" -84.754284150000004;
	setAttr ".RightHandIndex2Ty" 146.7887121;
	setAttr ".RightHandIndex2Tz" 3.3250925079999996;
	setAttr ".RightHandIndex2JointOrientx" -1.355847296196041e-20;
	setAttr ".RightHandIndex2JointOrienty" 2.0000646579999999;
	setAttr ".RightHandIndex2JointOrientz" -3.8848797556813322e-19;
	setAttr ".RightHandIndex2MinRLimitx" -45;
	setAttr ".RightHandIndex2MinRLimity" -45;
	setAttr ".RightHandIndex2MinRLimitz" -45;
	setAttr ".RightHandIndex2MaxRLimitx" 45;
	setAttr ".RightHandIndex2MaxRLimity" 45;
	setAttr ".RightHandIndex2MaxRLimitz" 45;
	setAttr ".RightHandIndex3Tx" -87.406606950000011;
	setAttr ".RightHandIndex3Ty" 146.78871179999996;
	setAttr ".RightHandIndex3Tz" 3.232540366999999;
	setAttr ".RightHandIndex3JointOrientx" -1.3558472812700803e-20;
	setAttr ".RightHandIndex3JointOrienty" 2.0000646359999998;
	setAttr ".RightHandIndex3JointOrientz" -3.8848797556292402e-19;
	setAttr ".RightHandIndex3MinRLimitx" -45;
	setAttr ".RightHandIndex3MinRLimity" -45;
	setAttr ".RightHandIndex3MinRLimitz" -45;
	setAttr ".RightHandIndex3MaxRLimitx" 45;
	setAttr ".RightHandIndex3MaxRLimity" 45;
	setAttr ".RightHandIndex3MaxRLimitz" 45;
	setAttr ".RightHandIndex4Tx" -89.363639170000013;
	setAttr ".RightHandIndex4Ty" 146.78871169999996;
	setAttr ".RightHandIndex4Tz" 3.164250215;
	setAttr ".RightHandIndex4JointOrientx" -1.3558472812700803e-20;
	setAttr ".RightHandIndex4JointOrienty" 2.0000646359999998;
	setAttr ".RightHandIndex4JointOrientz" -3.8848797556292402e-19;
	setAttr ".RightHandIndex4MinRLimitx" -45;
	setAttr ".RightHandIndex4MinRLimity" -45;
	setAttr ".RightHandIndex4MinRLimitz" -45;
	setAttr ".RightHandIndex4MaxRLimitx" 45;
	setAttr ".RightHandIndex4MaxRLimity" 45;
	setAttr ".RightHandIndex4MaxRLimitz" 45;
	setAttr ".RightHandMiddle1Tx" -80.51962730000001;
	setAttr ".RightHandMiddle1Ty" 147.08987179999997;
	setAttr ".RightHandMiddle1Tz" 1.305458427;
	setAttr ".RightHandMiddle1JointOrientz" -0.0092734440000000126;
	setAttr ".RightHandMiddle1MinRLimitx" -45;
	setAttr ".RightHandMiddle1MinRLimity" -45;
	setAttr ".RightHandMiddle1MinRLimitz" -45;
	setAttr ".RightHandMiddle1MaxRLimitx" 45;
	setAttr ".RightHandMiddle1MaxRLimity" 45;
	setAttr ".RightHandMiddle1MaxRLimitz" 45;
	setAttr ".RightHandMiddle2Tx" -85.379921789999997;
	setAttr ".RightHandMiddle2Ty" 147.08987139999999;
	setAttr ".RightHandMiddle2Tz" 1.1358596750000001;
	setAttr ".RightHandMiddle2JointOrienty" 2.0000646579999999;
	setAttr ".RightHandMiddle2JointOrientz" 0.002318361000000001;
	setAttr ".RightHandMiddle2MinRLimitx" -45;
	setAttr ".RightHandMiddle2MinRLimity" -45;
	setAttr ".RightHandMiddle2MinRLimitz" -45;
	setAttr ".RightHandMiddle2MaxRLimitx" 45;
	setAttr ".RightHandMiddle2MaxRLimity" 45;
	setAttr ".RightHandMiddle2MaxRLimitz" 45;
	setAttr ".RightHandMiddle3Tx" -88.143476890000017;
	setAttr ".RightHandMiddle3Ty" 147.08987119999989;
	setAttr ".RightHandMiddle3Tz" 1.0394261130000013;
	setAttr ".RightHandMiddle3JointOrientx" -1.3624856181967945e-20;
	setAttr ".RightHandMiddle3JointOrienty" -6.0001939739999983;
	setAttr ".RightHandMiddle3JointOrientz" 3.8952655968102367e-19;
	setAttr ".RightHandMiddle3MinRLimitx" -45;
	setAttr ".RightHandMiddle3MinRLimity" -45;
	setAttr ".RightHandMiddle3MinRLimitz" -45;
	setAttr ".RightHandMiddle3MaxRLimitx" 45;
	setAttr ".RightHandMiddle3MaxRLimity" 45;
	setAttr ".RightHandMiddle3MaxRLimitz" 45;
	setAttr ".RightHandMiddle4Tx" -90.147889570000004;
	setAttr ".RightHandMiddle4Ty" 147.08987099999993;
	setAttr ".RightHandMiddle4Tz" 0.96948263800000023;
	setAttr ".RightHandMiddle4JointOrientx" 2.7233111502208861e-20;
	setAttr ".RightHandMiddle4JointOrienty" 6.0001939739999974;
	setAttr ".RightHandMiddle4JointOrientz" 3.9039003952657287e-19;
	setAttr ".RightHandMiddle4MinRLimitx" -45;
	setAttr ".RightHandMiddle4MinRLimity" -45;
	setAttr ".RightHandMiddle4MinRLimitz" -45;
	setAttr ".RightHandMiddle4MaxRLimitx" 45;
	setAttr ".RightHandMiddle4MaxRLimity" 45;
	setAttr ".RightHandMiddle4MaxRLimitz" 45;
	setAttr ".RightHandRing1Tx" -80.603693699999994;
	setAttr ".RightHandRing1Ty" 146.968899;
	setAttr ".RightHandRing1Tz" -0.79237675600000002;
	setAttr ".RightHandRing1JointOrientz" 3.8825130388958945e-19;
	setAttr ".RightHandRing1MinRLimitx" -45;
	setAttr ".RightHandRing1MinRLimity" -45;
	setAttr ".RightHandRing1MinRLimitz" -45;
	setAttr ".RightHandRing1MaxRLimitx" 45;
	setAttr ".RightHandRing1MaxRLimity" 45;
	setAttr ".RightHandRing1MaxRLimitz" 45;
	setAttr ".RightHandRing2Tx" -85.138693310000008;
	setAttr ".RightHandRing2Ty" 146.96889859999996;
	setAttr ".RightHandRing2Tz" -0.95062442800000047;
	setAttr ".RightHandRing2JointOrienty" 2.0000646579999999;
	setAttr ".RightHandRing2JointOrientz" 3.8825130388958945e-19;
	setAttr ".RightHandRing2MinRLimitx" -45;
	setAttr ".RightHandRing2MinRLimity" -45;
	setAttr ".RightHandRing2MinRLimitz" -45;
	setAttr ".RightHandRing2MaxRLimitx" 45;
	setAttr ".RightHandRing2MaxRLimity" 45;
	setAttr ".RightHandRing2MaxRLimitz" 45;
	setAttr ".RightHandRing3Tx" -87.441817880000016;
	setAttr ".RightHandRing3Ty" 146.9688984;
	setAttr ".RightHandRing3Tz" -1.0309913800000001;
	setAttr ".RightHandRing3JointOrientx" -1.3550212972575395e-20;
	setAttr ".RightHandRing3JointOrienty" -2.2000000099710292e-08;
	setAttr ".RightHandRing3JointOrientz" 3.880147763995615e-19;
	setAttr ".RightHandRing3MinRLimitx" -45;
	setAttr ".RightHandRing3MinRLimity" -45;
	setAttr ".RightHandRing3MinRLimitz" -45;
	setAttr ".RightHandRing3MaxRLimitx" 45;
	setAttr ".RightHandRing3MaxRLimity" 45;
	setAttr ".RightHandRing3MaxRLimitz" 45;
	setAttr ".RightHandRing4Tx" -89.363995800000026;
	setAttr ".RightHandRing4Ty" 146.96889830000001;
	setAttr ".RightHandRing4Tz" -1.0980652959999995;
	setAttr ".RightHandRing4JointOrientx" -1.3550212972575395e-20;
	setAttr ".RightHandRing4JointOrienty" -2.2000000099710292e-08;
	setAttr ".RightHandRing4JointOrientz" 3.880147763995615e-19;
	setAttr ".RightHandRing4MinRLimitx" -45;
	setAttr ".RightHandRing4MinRLimity" -45;
	setAttr ".RightHandRing4MinRLimitz" -45;
	setAttr ".RightHandRing4MaxRLimitx" 45;
	setAttr ".RightHandRing4MaxRLimity" 45;
	setAttr ".RightHandRing4MaxRLimitz" 45;
	setAttr ".RightHandPinky1Tx" -80.592357370000016;
	setAttr ".RightHandPinky1Ty" 146.2759509;
	setAttr ".RightHandPinky1Tz" -2.4895741939999998;
	setAttr ".RightHandPinky1JointOrientz" -0.0023183610000000027;
	setAttr ".RightHandPinky1MinRLimitx" -45;
	setAttr ".RightHandPinky1MinRLimity" -45;
	setAttr ".RightHandPinky1MinRLimitz" -45;
	setAttr ".RightHandPinky1MaxRLimitx" 45;
	setAttr ".RightHandPinky1MaxRLimity" 45;
	setAttr ".RightHandPinky1MaxRLimitz" 45;
	setAttr ".RightHandPinky2Tx" -83.638299989999993;
	setAttr ".RightHandPinky2Ty" 146.27588489999999;
	setAttr ".RightHandPinky2Tz" -2.595861595000001;
	setAttr ".RightHandPinky2JointOrientx" -4.3345585314366439e-05;
	setAttr ".RightHandPinky2JointOrienty" 2.0000646575304972;
	setAttr ".RightHandPinky2JointOrientz" -0.0012419716244709295;
	setAttr ".RightHandPinky2MinRLimitx" -45;
	setAttr ".RightHandPinky2MinRLimity" -45;
	setAttr ".RightHandPinky2MinRLimitz" -45;
	setAttr ".RightHandPinky2MaxRLimitx" 45;
	setAttr ".RightHandPinky2MaxRLimity" 45;
	setAttr ".RightHandPinky2MaxRLimitz" 45;
	setAttr ".RightHandPinky3Tx" -85.613997130000072;
	setAttr ".RightHandPinky3Ty" 146.27584210000003;
	setAttr ".RightHandPinky3Tz" -2.6648030450000002;
	setAttr ".RightHandPinky3JointOrientx" -4.3424966520628488e-05;
	setAttr ".RightHandPinky3JointOrienty" -4.0001293155299251;
	setAttr ".RightHandPinky3JointOrientz" 0.0024847031067816044;
	setAttr ".RightHandPinky3MinRLimitx" -45;
	setAttr ".RightHandPinky3MinRLimity" -45;
	setAttr ".RightHandPinky3MinRLimitz" -45;
	setAttr ".RightHandPinky3MaxRLimitx" 45;
	setAttr ".RightHandPinky3MaxRLimity" 45;
	setAttr ".RightHandPinky3MaxRLimitz" 45;
	setAttr ".RightHandPinky4Tx" -87.281620980000042;
	setAttr ".RightHandPinky4Ty" 146.27580589999999;
	setAttr ".RightHandPinky4Tz" -2.7229943640000003;
	setAttr ".RightHandPinky4JointOrientx" -4.3345585314366493e-05;
	setAttr ".RightHandPinky4JointOrienty" 2.0000646575304981;
	setAttr ".RightHandPinky4JointOrientz" -0.0012419716244709291;
	setAttr ".RightHandPinky4MinRLimitx" -45;
	setAttr ".RightHandPinky4MinRLimity" -45;
	setAttr ".RightHandPinky4MinRLimitz" -45;
	setAttr ".RightHandPinky4MaxRLimitx" 45;
	setAttr ".RightHandPinky4MaxRLimity" 45;
	setAttr ".RightHandPinky4MaxRLimitz" 45;
	setAttr ".RightHandExtraFinger1Tx" -80.592357370000002;
	setAttr ".RightHandExtraFinger1Ty" 146.78871240000001;
	setAttr ".RightHandExtraFinger1Tz" -4.4895741940000002;
	setAttr ".RightHandExtraFinger1Ry" -2.0000646579999999;
	setAttr ".RightHandExtraFinger2Tx" -82.638299989999993;
	setAttr ".RightHandExtraFinger2Ty" 146.7887121;
	setAttr ".RightHandExtraFinger2Tz" -4.5958615949999997;
	setAttr ".RightHandExtraFinger2Ry" -2.0000646359999998;
	setAttr ".RightHandExtraFinger3Tx" -84.613997130000001;
	setAttr ".RightHandExtraFinger3Ty" 146.78871179999999;
	setAttr ".RightHandExtraFinger3Tz" -4.6648030450000002;
	setAttr ".RightHandExtraFinger3Ry" -2.0000646359999998;
	setAttr ".RightHandExtraFinger4Tx" -86.28162098;
	setAttr ".RightHandExtraFinger4Ty" 146.78871169999999;
	setAttr ".RightHandExtraFinger4Tz" -4.7229943639999998;
	setAttr ".RightHandExtraFinger4Ry" -2.0000646359999998;
	setAttr ".LeftFootThumb1Tx" 6.18422217;
	setAttr ".LeftFootThumb1Ty" 4.9992492679999998;
	setAttr ".LeftFootThumb1Tz" 1.930123209;
	setAttr ".LeftFootThumb2Tx" 4.551409713;
	setAttr ".LeftFootThumb2Ty" 2.6643834059999998;
	setAttr ".LeftFootThumb2Tz" 3.591937658;
	setAttr ".LeftFootThumb3Tx" 3.4619466889999999;
	setAttr ".LeftFootThumb3Ty" 1.8880788850000001;
	setAttr ".LeftFootThumb3Tz" 6.4001420700000002;
	setAttr ".LeftFootThumb4Tx" 3.4619466999999999;
	setAttr ".LeftFootThumb4Ty" 1.8880788550000001;
	setAttr ".LeftFootThumb4Tz" 9.6971958839999992;
	setAttr ".LeftFootIndex1Tx" 7.1105199680000002;
	setAttr ".LeftFootIndex1Ty" 1.888079117;
	setAttr ".LeftFootIndex1Tz" 12.9547209;
	setAttr ".LeftFootIndex2Tx" 7.1105199749999999;
	setAttr ".LeftFootIndex2Ty" 1.8880790999999999;
	setAttr ".LeftFootIndex2Tz" 14.82972745;
	setAttr ".LeftFootIndex3Tx" 7.1105199810000004;
	setAttr ".LeftFootIndex3Ty" 1.888079083;
	setAttr ".LeftFootIndex3Tz" 16.76314442;
	setAttr ".LeftFootIndex4Tx" 7.1105199880000001;
	setAttr ".LeftFootIndex4Ty" 1.8880790649999999;
	setAttr ".LeftFootIndex4Tz" 18.850666449999999;
	setAttr ".LeftFootMiddle1Tx" 8.9167242489999996;
	setAttr ".LeftFootMiddle1Ty" 1.888079163;
	setAttr ".LeftFootMiddle1Tz" 12.9547209;
	setAttr ".LeftFootMiddle2Tx" 8.9167242550000001;
	setAttr ".LeftFootMiddle2Ty" 1.888079147;
	setAttr ".LeftFootMiddle2Tz" 14.82860045;
	setAttr ".LeftFootMiddle3Tx" 8.9167242610000006;
	setAttr ".LeftFootMiddle3Ty" 1.888079131;
	setAttr ".LeftFootMiddle3Tz" 16.64971237;
	setAttr ".LeftFootMiddle4Tx" 8.9167242669999993;
	setAttr ".LeftFootMiddle4Ty" 1.8880791139999999;
	setAttr ".LeftFootMiddle4Tz" 18.565581959999999;
	setAttr ".LeftFootRing1Tx" 10.723903740000001;
	setAttr ".LeftFootRing1Ty" 1.888079211;
	setAttr ".LeftFootRing1Tz" 12.9547209;
	setAttr ".LeftFootRing2Tx" 10.723903740000001;
	setAttr ".LeftFootRing2Ty" 1.888079195;
	setAttr ".LeftFootRing2Tz" 14.71345226;
	setAttr ".LeftFootRing3Tx" 10.72390375;
	setAttr ".LeftFootRing3Ty" 1.8880791800000001;
	setAttr ".LeftFootRing3Tz" 16.472174209999999;
	setAttr ".LeftFootRing4Tx" 10.723903760000001;
	setAttr ".LeftFootRing4Ty" 1.8880791640000001;
	setAttr ".LeftFootRing4Tz" 18.27484922;
	setAttr ".LeftFootPinky1Tx" 12.52979668;
	setAttr ".LeftFootPinky1Ty" 1.888079257;
	setAttr ".LeftFootPinky1Tz" 12.9547209;
	setAttr ".LeftFootPinky2Tx" 12.52979669;
	setAttr ".LeftFootPinky2Ty" 1.8880792420000001;
	setAttr ".LeftFootPinky2Tz" 14.5796458;
	setAttr ".LeftFootPinky3Tx" 12.52979669;
	setAttr ".LeftFootPinky3Ty" 1.8880792289999999;
	setAttr ".LeftFootPinky3Tz" 16.143599309999999;
	setAttr ".LeftFootPinky4Tx" 12.5297967;
	setAttr ".LeftFootPinky4Ty" 1.8880792129999999;
	setAttr ".LeftFootPinky4Tz" 17.861196199999998;
	setAttr ".LeftFootExtraFinger1Tx" 5.0860939849999998;
	setAttr ".LeftFootExtraFinger1Ty" 1.888079254;
	setAttr ".LeftFootExtraFinger1Tz" 12.9547209;
	setAttr ".LeftFootExtraFinger2Tx" 5.0860939910000003;
	setAttr ".LeftFootExtraFinger2Ty" 1.888079236;
	setAttr ".LeftFootExtraFinger2Tz" 14.94401483;
	setAttr ".LeftFootExtraFinger3Tx" 5.0860939979999999;
	setAttr ".LeftFootExtraFinger3Ty" 1.8880792179999999;
	setAttr ".LeftFootExtraFinger3Tz" 16.99182682;
	setAttr ".LeftFootExtraFinger4Tx" 5.0860940049999996;
	setAttr ".LeftFootExtraFinger4Ty" 1.8880791990000001;
	setAttr ".LeftFootExtraFinger4Tz" 19.0793827;
	setAttr ".RightFootThumb1Tx" -6.180000014;
	setAttr ".RightFootThumb1Ty" 4.9992496019999999;
	setAttr ".RightFootThumb1Tz" 1.930123112;
	setAttr ".RightFootThumb2Tx" -4.5499999820000001;
	setAttr ".RightFootThumb2Ty" 2.6643838419999999;
	setAttr ".RightFootThumb2Tz" 3.5919375690000002;
	setAttr ".RightFootThumb3Tx" -3.4599999860000001;
	setAttr ".RightFootThumb3Ty" 1.888079335;
	setAttr ".RightFootThumb3Tz" 6.4001419850000003;
	setAttr ".RightFootThumb4Tx" -3.4599999860000001;
	setAttr ".RightFootThumb4Ty" 1.8880793090000001;
	setAttr ".RightFootThumb4Tz" 9.6971957989999993;
	setAttr ".RightFootIndex1Tx" -7.1099999839999999;
	setAttr ".RightFootIndex1Ty" 1.888079262;
	setAttr ".RightFootIndex1Tz" 12.95472064;
	setAttr ".RightFootIndex2Tx" -7.1099999839999999;
	setAttr ".RightFootIndex2Ty" 1.8880792479999999;
	setAttr ".RightFootIndex2Tz" 14.82972719;
	setAttr ".RightFootIndex3Tx" -7.1099999839999999;
	setAttr ".RightFootIndex3Ty" 1.8880792340000001;
	setAttr ".RightFootIndex3Tz" 16.76314416;
	setAttr ".RightFootIndex4Tx" -7.1099999839999999;
	setAttr ".RightFootIndex4Ty" 1.8880792179999999;
	setAttr ".RightFootIndex4Tz" 18.850666189999998;
	setAttr ".RightFootMiddle1Tx" -8.92;
	setAttr ".RightFootMiddle1Ty" 1.8880792049999999;
	setAttr ".RightFootMiddle1Tz" 12.954720630000001;
	setAttr ".RightFootMiddle2Tx" -8.92;
	setAttr ".RightFootMiddle2Ty" 1.8880791910000001;
	setAttr ".RightFootMiddle2Tz" 14.82860018;
	setAttr ".RightFootMiddle3Tx" -8.92;
	setAttr ".RightFootMiddle3Ty" 1.8880791770000001;
	setAttr ".RightFootMiddle3Tz" 16.649712099999999;
	setAttr ".RightFootMiddle4Tx" -8.92;
	setAttr ".RightFootMiddle4Ty" 1.8880791619999999;
	setAttr ".RightFootMiddle4Tz" 18.565581689999998;
	setAttr ".RightFootRing1Tx" -10.72;
	setAttr ".RightFootRing1Ty" 1.8880791610000001;
	setAttr ".RightFootRing1Tz" 12.95472062;
	setAttr ".RightFootRing2Tx" -10.72;
	setAttr ".RightFootRing2Ty" 1.888079147;
	setAttr ".RightFootRing2Tz" 14.713451989999999;
	setAttr ".RightFootRing3Tx" -10.72;
	setAttr ".RightFootRing3Ty" 1.888079134;
	setAttr ".RightFootRing3Tz" 16.472173940000001;
	setAttr ".RightFootRing4Tx" -10.72;
	setAttr ".RightFootRing4Ty" 1.88807912;
	setAttr ".RightFootRing4Tz" 18.274848949999999;
	setAttr ".RightFootPinky1Tx" -12.530000060000001;
	setAttr ".RightFootPinky1Ty" 1.8880791029999999;
	setAttr ".RightFootPinky1Tz" 12.95472062;
	setAttr ".RightFootPinky2Tx" -12.530000060000001;
	setAttr ".RightFootPinky2Ty" 1.888079091;
	setAttr ".RightFootPinky2Tz" 14.57964552;
	setAttr ".RightFootPinky3Tx" -12.530000060000001;
	setAttr ".RightFootPinky3Ty" 1.8880790789999999;
	setAttr ".RightFootPinky3Tz" 16.143599040000002;
	setAttr ".RightFootPinky4Tx" -12.530000060000001;
	setAttr ".RightFootPinky4Ty" 1.888079066;
	setAttr ".RightFootPinky4Tz" 17.86119592;
	setAttr ".RightFootExtraFinger1Tx" -5.0900000030000001;
	setAttr ".RightFootExtraFinger1Ty" 1.8880791260000001;
	setAttr ".RightFootExtraFinger1Tz" 12.95472064;
	setAttr ".RightFootExtraFinger2Tx" -5.0900000030000001;
	setAttr ".RightFootExtraFinger2Ty" 1.8880791109999999;
	setAttr ".RightFootExtraFinger2Tz" 14.944014579999999;
	setAttr ".RightFootExtraFinger3Tx" -5.0900000030000001;
	setAttr ".RightFootExtraFinger3Ty" 1.888079096;
	setAttr ".RightFootExtraFinger3Tz" 16.99182656;
	setAttr ".RightFootExtraFinger4Tx" -5.0900000030000001;
	setAttr ".RightFootExtraFinger4Ty" 1.88807908;
	setAttr ".RightFootExtraFinger4Tz" 19.079382450000001;
	setAttr ".LeftInHandThumbTx" 71.709864199999998;
	setAttr ".LeftInHandThumbTy" 146.58868419999999;
	setAttr ".LeftInHandIndexTx" 71.709864199999998;
	setAttr ".LeftInHandIndexTy" 146.58868419999999;
	setAttr ".LeftInHandMiddleTx" 71.709864199999998;
	setAttr ".LeftInHandMiddleTy" 146.58868419999999;
	setAttr ".LeftInHandRingTx" 71.709864199999998;
	setAttr ".LeftInHandRingTy" 146.58868419999999;
	setAttr ".LeftInHandPinkyTx" 71.709864199999998;
	setAttr ".LeftInHandPinkyTy" 146.58868419999999;
	setAttr ".LeftInHandExtraFingerTx" 71.709864199999998;
	setAttr ".LeftInHandExtraFingerTy" 146.58868419999999;
	setAttr ".RightInHandThumbTx" -71.709861489999994;
	setAttr ".RightInHandThumbTy" 146.58897870000001;
	setAttr ".RightInHandIndexTx" -71.709861489999994;
	setAttr ".RightInHandIndexTy" 146.58897870000001;
	setAttr ".RightInHandMiddleTx" -71.709861489999994;
	setAttr ".RightInHandMiddleTy" 146.58897870000001;
	setAttr ".RightInHandRingTx" -71.709861489999994;
	setAttr ".RightInHandRingTy" 146.58897870000001;
	setAttr ".RightInHandPinkyTx" -71.709861489999994;
	setAttr ".RightInHandPinkyTy" 146.58897870000001;
	setAttr ".RightInHandExtraFingerTx" -71.709861489999994;
	setAttr ".RightInHandExtraFingerTy" 146.58897870000001;
	setAttr ".LeftInFootThumbTx" 8.9100008010000007;
	setAttr ".LeftInFootThumbTy" 8.15039625;
	setAttr ".LeftInFootIndexTx" 8.9100008010000007;
	setAttr ".LeftInFootIndexTy" 8.1503963469999992;
	setAttr ".LeftInFootMiddleTx" 8.9100008010000007;
	setAttr ".LeftInFootMiddleTy" 8.1503963469999992;
	setAttr ".LeftInFootRingTx" 8.9100008010000007;
	setAttr ".LeftInFootRingTy" 8.1503963469999992;
	setAttr ".LeftInFootPinkyTx" 8.9100008010000007;
	setAttr ".LeftInFootPinkyTy" 8.1503963469999992;
	setAttr ".LeftInFootExtraFingerTx" 8.9100008010000007;
	setAttr ".LeftInFootExtraFingerTy" 8.1503963469999992;
	setAttr ".RightInFootThumbTx" -8.9100025980000002;
	setAttr ".RightInFootThumbTy" 8.1503963929999994;
	setAttr ".RightInFootThumbTz" 0.00043882099999999999;
	setAttr ".RightInFootIndexTx" -8.9100026190000001;
	setAttr ".RightInFootIndexTy" 8.1503963939999995;
	setAttr ".RightInFootIndexTz" 0.00043882099999999999;
	setAttr ".RightInFootMiddleTx" -8.9100026190000001;
	setAttr ".RightInFootMiddleTy" 8.1503963939999995;
	setAttr ".RightInFootMiddleTz" 0.00043882099999999999;
	setAttr ".RightInFootRingTx" -8.9100026190000001;
	setAttr ".RightInFootRingTy" 8.1503963939999995;
	setAttr ".RightInFootRingTz" 0.00043882099999999999;
	setAttr ".RightInFootPinkyTx" -8.9100026190000001;
	setAttr ".RightInFootPinkyTy" 8.1503963939999995;
	setAttr ".RightInFootPinkyTz" 0.00043882099999999999;
	setAttr ".RightInFootExtraFingerTx" -8.9100026190000001;
	setAttr ".RightInFootExtraFingerTy" 8.1503963939999995;
	setAttr ".RightInFootExtraFingerTz" 0.00043882099999999999;
	setAttr ".LeftShoulderExtraTx" 12.353625535000001;
	setAttr ".LeftShoulderExtraTy" 146.58868419999999;
	setAttr ".RightShoulderExtraTx" -12.353637216499999;
	setAttr ".RightShoulderExtraTy" 146.58898;
createNode HIKProperty2State -n "HIKproperties1";
	rename -uid "1C6F1300-4C9E-9C27-4D4D-B59501229A3F";
	setAttr ".OutputPropertySetState" -type "HIKPropertySetState" ;
	setAttr ".lkr" 0.60000002384185791;
	setAttr ".rkr" 0.60000002384185791;
	setAttr ".FootBottomToAnkle" 8.1503963469999974;
	setAttr ".FootBackToAnkle" 6.4773604499999999;
	setAttr ".FootMiddleToAnkle" 12.9547209;
	setAttr ".FootFrontToMiddle" 6.4773604499999999;
	setAttr ".FootInToAnkle" 6.4773604499999999;
	setAttr ".FootOutToAnkle" 6.4773604499999999;
	setAttr ".HandBottomToWrist" 3.4231841277199999;
	setAttr ".HandBackToWrist" 0.01;
	setAttr ".HandMiddleToWrist" 8.5501157939999999;
	setAttr ".HandFrontToMiddle" 8.5501157939999999;
	setAttr ".HandInToWrist" 8.5501157939999999;
	setAttr ".HandOutToWrist" 8.5501157939999999;
	setAttr ".LeftHandThumbTip" 1.0697450399124999;
	setAttr ".LeftHandIndexTip" 1.0697450399124999;
	setAttr ".LeftHandMiddleTip" 1.0697450399124999;
	setAttr ".LeftHandRingTip" 1.0697450399124999;
	setAttr ".LeftHandPinkyTip" 1.0697450399124999;
	setAttr ".LeftHandExtraFingerTip" 1.0697450399124999;
	setAttr ".RightHandThumbTip" 1.0697450399124999;
	setAttr ".RightHandIndexTip" 1.0697450399124999;
	setAttr ".RightHandMiddleTip" 1.0697450399124999;
	setAttr ".RightHandRingTip" 1.0697450399124999;
	setAttr ".RightHandPinkyTip" 1.0697450399124999;
	setAttr ".RightHandExtraFingerTip" 1.0697450399124999;
	setAttr ".LeftFootThumbTip" 1.0697450399124999;
	setAttr ".LeftFootIndexTip" 1.0697450399124999;
	setAttr ".LeftFootMiddleTip" 1.0697450399124999;
	setAttr ".LeftFootRingTip" 1.0697450399124999;
	setAttr ".LeftFootPinkyTip" 1.0697450399124999;
	setAttr ".LeftFootExtraFingerTip" 1.0697450399124999;
	setAttr ".RightFootThumbTip" 1.0697450399124999;
	setAttr ".RightFootIndexTip" 1.0697450399124999;
	setAttr ".RightFootMiddleTip" 1.0697450399124999;
	setAttr ".RightFootRingTip" 1.0697450399124999;
	setAttr ".RightFootPinkyTip" 1.0697450399124999;
	setAttr ".RightFootExtraFingerTip" 1.0697450399124999;
	setAttr ".LeftUpLegRollEx" 1;
	setAttr ".LeftLegRollEx" 1;
	setAttr ".RightUpLegRollEx" 1;
	setAttr ".RightLegRollEx" 1;
	setAttr ".LeftArmRollEx" 1;
	setAttr ".LeftForeArmRollEx" 1;
	setAttr ".RightArmRollEx" 1;
	setAttr ".RightForeArmRollEx" 1;
	setAttr ".ParamLeafLeftUpLegRoll1" 0;
	setAttr ".ParamLeafLeftLegRoll1" 0;
	setAttr ".ParamLeafRightUpLegRoll1" 0;
	setAttr ".ParamLeafRightLegRoll1" 0;
	setAttr ".ParamLeafLeftArmRoll1" 0;
	setAttr ".ParamLeafLeftForeArmRoll1" 0;
	setAttr ".ParamLeafRightArmRoll1" 0;
	setAttr ".ParamLeafRightForeArmRoll1" 0;
	setAttr ".ParamLeafLeftUpLegRoll2" 0;
	setAttr ".ParamLeafLeftLegRoll2" 0;
	setAttr ".ParamLeafRightUpLegRoll2" 0;
	setAttr ".ParamLeafRightLegRoll2" 0;
	setAttr ".ParamLeafLeftArmRoll2" 0;
	setAttr ".ParamLeafLeftForeArmRoll2" 0;
	setAttr ".ParamLeafRightArmRoll2" 0;
	setAttr ".ParamLeafRightForeArmRoll2" 0;
	setAttr ".ParamLeafLeftUpLegRoll3" 0;
	setAttr ".ParamLeafLeftLegRoll3" 0;
	setAttr ".ParamLeafRightUpLegRoll3" 0;
	setAttr ".ParamLeafRightLegRoll3" 0;
	setAttr ".ParamLeafLeftArmRoll3" 0;
	setAttr ".ParamLeafLeftForeArmRoll3" 0;
	setAttr ".ParamLeafRightArmRoll3" 0;
	setAttr ".ParamLeafRightForeArmRoll3" 0;
	setAttr ".ParamLeafLeftUpLegRoll4" 0;
	setAttr ".ParamLeafLeftLegRoll4" 0;
	setAttr ".ParamLeafRightUpLegRoll4" 0;
	setAttr ".ParamLeafRightLegRoll4" 0;
	setAttr ".ParamLeafLeftArmRoll4" 0;
	setAttr ".ParamLeafLeftForeArmRoll4" 0;
	setAttr ".ParamLeafRightArmRoll4" 0;
	setAttr ".ParamLeafRightForeArmRoll4" 0;
	setAttr ".ParamLeafLeftUpLegRoll5" 0;
	setAttr ".ParamLeafLeftLegRoll5" 0;
	setAttr ".ParamLeafRightUpLegRoll5" 0;
	setAttr ".ParamLeafRightLegRoll5" 0;
	setAttr ".ParamLeafLeftArmRoll5" 0;
	setAttr ".ParamLeafLeftForeArmRoll5" 0;
	setAttr ".ParamLeafRightArmRoll5" 0;
	setAttr ".ParamLeafRightForeArmRoll5" 0;
createNode HIKSkeletonGeneratorNode -n "HIKSkeletonGeneratorNode1";
	rename -uid "66CE682E-407D-F65C-47BE-AD9EF21AC502";
	setAttr ".ihi" 0;
	setAttr ".SpineCount" 2;
	setAttr ".WantToeBase" yes;
	setAttr ".HipsTy" 100;
	setAttr ".LeftUpLegTx" 8.9100008010000007;
	setAttr ".LeftUpLegTy" 93.729999539999994;
	setAttr ".LeftLegTx" 8.9100008010000007;
	setAttr ".LeftLegTy" 48.851354600000001;
	setAttr ".LeftFootTx" 8.9100008010000007;
	setAttr ".LeftFootTy" 8.1503963469999974;
	setAttr ".RightUpLegTx" -8.9100008010000007;
	setAttr ".RightUpLegTy" 93.729999539999994;
	setAttr ".RightLegTx" -8.9100035169999998;
	setAttr ".RightLegTy" 48.851354600000001;
	setAttr ".RightLegTz" 0.00043902399999999999;
	setAttr ".RightFootTx" -8.9100025980000002;
	setAttr ".RightFootTy" 8.1503963509999977;
	setAttr ".RightFootTz" 0.00043902399999999999;
	setAttr ".SpineTy" 107;
	setAttr ".LeftArmTx" 17.707251070000005;
	setAttr ".LeftArmTy" 146.58868419999996;
	setAttr ".LeftForeArmTx" 45.012716769999997;
	setAttr ".LeftForeArmTy" 146.58868419999999;
	setAttr ".LeftHandTx" 71.709864140000008;
	setAttr ".LeftHandTy" 146.58868420000002;
	setAttr ".RightArmTx" -17.707274910000002;
	setAttr ".RightArmTy" 146.58898000000002;
	setAttr ".RightForeArmTx" -45.012873159999998;
	setAttr ".RightForeArmTy" 146.58898;
	setAttr ".RightHandTx" -71.709861270000005;
	setAttr ".RightHandTy" 146.58897870000004;
	setAttr ".HeadTy" 165;
	setAttr ".LeftToeBaseTx" 8.9100092279999998;
	setAttr ".LeftToeBaseTy" 1.8880791539999997;
	setAttr ".LeftToeBaseTz" 12.9547209;
	setAttr ".RightToeBaseTx" -8.9110879790000013;
	setAttr ".RightToeBaseTy" 1.8880791709999984;
	setAttr ".RightToeBaseTz" 12.955188090000002;
	setAttr ".LeftShoulderTx" 7.0000004770000004;
	setAttr ".LeftShoulderTy" 146.58854679999999;
	setAttr ".RightShoulderTx" -6.9999995229999996;
	setAttr ".RightShoulderTy" 146.58854679999999;
	setAttr ".NeckTy" 145;
	setAttr ".LeftFingerBaseTx" 80.519743439999999;
	setAttr ".LeftFingerBaseTy" 147.08957459999999;
	setAttr ".LeftFingerBaseTz" 1.304684401;
	setAttr ".LeftFingerBaseRy" -0.0035633340000000005;
	setAttr ".RightFingerBaseTx" -80.519626680000002;
	setAttr ".RightFingerBaseTy" 147.0898718;
	setAttr ".RightFingerBaseTz" 1.305458317;
	setAttr ".RightFingerBaseRy" -2.0000646359999998;
	setAttr ".Spine1Ty" 119.66666666666667;
	setAttr ".Spine2Ty" 132.33333333333334;
	setAttr ".Spine3Ty" 119;
	setAttr ".Spine4Ty" 123;
	setAttr ".Spine5Ty" 127;
	setAttr ".Spine6Ty" 131;
	setAttr ".Spine7Ty" 135;
	setAttr ".Spine8Ty" 139;
	setAttr ".Spine9Ty" 143;
	setAttr ".Neck1Ty" 147;
	setAttr ".Neck2Ty" 149;
	setAttr ".Neck3Ty" 151;
	setAttr ".Neck4Ty" 153;
	setAttr ".Neck5Ty" 155;
	setAttr ".Neck6Ty" 157;
	setAttr ".Neck7Ty" 159;
	setAttr ".Neck8Ty" 161;
	setAttr ".Neck9Ty" 163;
	setAttr ".LeftUpLegRollTx" 8.9100008010000007;
	setAttr ".LeftUpLegRollTy" 71.290677070000001;
	setAttr ".LeftLegRollTx" 8.9100008010000007;
	setAttr ".LeftLegRollTy" 28.500875473499999;
	setAttr ".RightUpLegRollTx" -8.9100021590000011;
	setAttr ".RightUpLegRollTy" 71.290677070000001;
	setAttr ".RightUpLegRollTz" 0.00021951199999999999;
	setAttr ".RightLegRollTx" -8.9100030574999991;
	setAttr ".RightLegRollTy" 28.500875475499999;
	setAttr ".RightLegRollTz" 0.00043902399999999999;
	setAttr ".LeftArmRollTx" 31.359983920000001;
	setAttr ".LeftArmRollTy" 146.58868419999999;
	setAttr ".LeftForeArmRollTx" 58.361290455000002;
	setAttr ".LeftForeArmRollTy" 146.58868419999999;
	setAttr ".RightArmRollTx" -31.360074035;
	setAttr ".RightArmRollTy" 146.58898;
	setAttr ".RightForeArmRollTx" -58.361367215000001;
	setAttr ".RightForeArmRollTy" 146.58897935000002;
	setAttr ".HipsTranslationTy" 100;
	setAttr ".LeftHandThumb1Tx" 76.058620989999994;
	setAttr ".LeftHandThumb1Ty" 145.79018170000001;
	setAttr ".LeftHandThumb1Tz" 4.2824339670000002;
	setAttr ".LeftHandThumb2Tx" 78.571210930000007;
	setAttr ".LeftHandThumb2Ty" 145.25408229999999;
	setAttr ".LeftHandThumb2Tz" 4.9898882909999998;
	setAttr ".LeftHandThumb3Tx" 81.114351339999985;
	setAttr ".LeftHandThumb3Ty" 145.25406910000001;
	setAttr ".LeftHandThumb3Tz" 4.989897633;
	setAttr ".LeftHandThumb4Tx" 83.781097480000028;
	setAttr ".LeftHandThumb4Ty" 145.254072;
	setAttr ".LeftHandThumb4Tz" 4.9898894219999983;
	setAttr ".LeftHandIndex1Tx" 80.531840860000003;
	setAttr ".LeftHandIndex1Ty" 146.7884134;
	setAttr ".LeftHandIndex1Tz" 3.4716694160000001;
	setAttr ".LeftHandIndex2Tx" 84.75459545999999;
	setAttr ".LeftHandIndex2Ty" 146.7883913;
	setAttr ".LeftHandIndex2Tz" 3.6188684349999996;
	setAttr ".LeftHandIndex3Tx" 87.406920910000011;
	setAttr ".LeftHandIndex3Ty" 146.7883775;
	setAttr ".LeftHandIndex3Tz" 3.711324415;
	setAttr ".LeftHandIndex4Tx" 89.363955140000016;
	setAttr ".LeftHandIndex4Ty" 146.7883673;
	setAttr ".LeftHandIndex4Tz" 3.7795433149999997;
	setAttr ".LeftHandMiddle1Tx" 80.51974349999999;
	setAttr ".LeftHandMiddle1Ty" 147.08957470000001;
	setAttr ".LeftHandMiddle1Tz" 1.3046843809999999;
	setAttr ".LeftHandMiddle2Tx" 85.382995180000023;
	setAttr ".LeftHandMiddle2Ty" 147.08957469999999;
	setAttr ".LeftHandMiddle2Tz" 1.3049868360000001;
	setAttr ".LeftHandMiddle3Tx" 88.148231790000054;
	setAttr ".LeftHandMiddle3Ty" 147.08957469999999;
	setAttr ".LeftHandMiddle3Tz" 1.305158619;
	setAttr ".LeftHandMiddle4Tx" 90.153863950000002;
	setAttr ".LeftHandMiddle4Ty" 147.08957470000001;
	setAttr ".LeftHandMiddle4Tz" 1.3052822150000003;
	setAttr ".LeftHandRing1Tx" 80.603623929999998;
	setAttr ".LeftHandRing1Ty" 146.96860380000001;
	setAttr ".LeftHandRing1Tz" -0.79315890899999997;
	setAttr ".LeftHandRing2Tx" 85.141382759999985;
	setAttr ".LeftHandRing2Ty" 146.96860380000001;
	setAttr ".LeftHandRing2Tz" -0.79315882000000004;
	setAttr ".LeftHandRing3Tx" 87.445908619999997;
	setAttr ".LeftHandRing3Ty" 146.96860380000001;
	setAttr ".LeftHandRing3Tz" -0.79315893699999995;
	setAttr ".LeftHandRing4Tx" 89.369255979999991;
	setAttr ".LeftHandRing4Ty" 146.96860380000001;
	setAttr ".LeftHandRing4Tz" -0.79315975400000005;
	setAttr ".LeftHandPinky1Tx" 80.592138829999996;
	setAttr ".LeftHandPinky1Ty" 146.27565720000001;
	setAttr ".LeftHandPinky1Tz" -2.4903564650000001;
	setAttr ".LeftHandPinky2Tx" 83.636238160000005;
	setAttr ".LeftHandPinky2Ty" 146.27569780000002;
	setAttr ".LeftHandPinky2Tz" -2.4903564650000001;
	setAttr ".LeftHandPinky3Tx" 85.610739649999971;
	setAttr ".LeftHandPinky3Ty" 146.27572409999988;
	setAttr ".LeftHandPinky3Tz" -2.4903566079999999;
	setAttr ".LeftHandPinky4Tx" 87.277354299999999;
	setAttr ".LeftHandPinky4Ty" 146.27574630000001;
	setAttr ".LeftHandPinky4Tz" -2.4903558170000002;
	setAttr ".LeftHandExtraFinger1Tx" 80.592138829999996;
	setAttr ".LeftHandExtraFinger1Ty" 146.7884134;
	setAttr ".LeftHandExtraFinger1Tz" -4.4903564649999996;
	setAttr ".LeftHandExtraFinger1Ry" -1.9999999850000001;
	setAttr ".LeftHandExtraFinger1Rz" -0.00029934100000000001;
	setAttr ".LeftHandExtraFinger2Tx" 82.636238160000005;
	setAttr ".LeftHandExtraFinger2Ty" 146.7883913;
	setAttr ".LeftHandExtraFinger2Tz" -4.4903564649999996;
	setAttr ".LeftHandExtraFinger2Ry" -1.9999999850000001;
	setAttr ".LeftHandExtraFinger2Rz" -0.00029934100000000001;
	setAttr ".LeftHandExtraFinger3Tx" 84.610739649999999;
	setAttr ".LeftHandExtraFinger3Ty" 146.7883775;
	setAttr ".LeftHandExtraFinger3Tz" -4.4903566079999999;
	setAttr ".LeftHandExtraFinger3Ry" -1.9999999850000001;
	setAttr ".LeftHandExtraFinger3Rz" -0.00029934100000000001;
	setAttr ".LeftHandExtraFinger4Tx" 86.277354299999999;
	setAttr ".LeftHandExtraFinger4Ty" 146.7883673;
	setAttr ".LeftHandExtraFinger4Tz" -4.4903558170000002;
	setAttr ".LeftHandExtraFinger4Ry" -1.9999999850000001;
	setAttr ".LeftHandExtraFinger4Rz" -0.00029934100000000001;
	setAttr ".RightHandThumb1Tx" -76.058242059999998;
	setAttr ".RightHandThumb1Ty" 145.7904806;
	setAttr ".RightHandThumb1Tz" 4.2828147379999999;
	setAttr ".RightHandThumb2Tx" -78.570769569999996;
	setAttr ".RightHandThumb2Ty" 145.25438170000001;
	setAttr ".RightHandThumb2Tz" 4.9904913879999997;
	setAttr ".RightHandThumb3Tx" -81.112358929999985;
	setAttr ".RightHandThumb3Ty" 145.25440850000001;
	setAttr ".RightHandThumb3Tz" 5.0793117030000001;
	setAttr ".RightHandThumb4Tx" -83.777478690000024;
	setAttr ".RightHandThumb4Ty" 145.25442679999998;
	setAttr ".RightHandThumb4Tz" 5.1724490200000011;
	setAttr ".RightHandIndex1Tx" -80.531533929999995;
	setAttr ".RightHandIndex1Ty" 146.78871240000001;
	setAttr ".RightHandIndex1Tz" 3.4724442959999999;
	setAttr ".RightHandIndex2Tx" -84.754284150000004;
	setAttr ".RightHandIndex2Ty" 146.7887121;
	setAttr ".RightHandIndex2Tz" 3.3250925079999996;
	setAttr ".RightHandIndex3Tx" -87.406606950000011;
	setAttr ".RightHandIndex3Ty" 146.78871179999996;
	setAttr ".RightHandIndex3Tz" 3.232540366999999;
	setAttr ".RightHandIndex4Tx" -89.363639170000013;
	setAttr ".RightHandIndex4Ty" 146.78871169999996;
	setAttr ".RightHandIndex4Tz" 3.164250215;
	setAttr ".RightHandMiddle1Tx" -80.51962730000001;
	setAttr ".RightHandMiddle1Ty" 147.08987179999997;
	setAttr ".RightHandMiddle1Tz" 1.305458427;
	setAttr ".RightHandMiddle2Tx" -85.379921789999997;
	setAttr ".RightHandMiddle2Ty" 147.08987139999999;
	setAttr ".RightHandMiddle2Tz" 1.1358596750000001;
	setAttr ".RightHandMiddle3Tx" -88.143476890000017;
	setAttr ".RightHandMiddle3Ty" 147.08987119999989;
	setAttr ".RightHandMiddle3Tz" 1.0394261130000013;
	setAttr ".RightHandMiddle4Tx" -90.147889570000004;
	setAttr ".RightHandMiddle4Ty" 147.08987099999993;
	setAttr ".RightHandMiddle4Tz" 0.96948263800000023;
	setAttr ".RightHandRing1Tx" -80.603693699999994;
	setAttr ".RightHandRing1Ty" 146.968899;
	setAttr ".RightHandRing1Tz" -0.79237675600000002;
	setAttr ".RightHandRing2Tx" -85.138693310000008;
	setAttr ".RightHandRing2Ty" 146.96889859999996;
	setAttr ".RightHandRing2Tz" -0.95062442800000047;
	setAttr ".RightHandRing3Tx" -87.441817880000016;
	setAttr ".RightHandRing3Ty" 146.9688984;
	setAttr ".RightHandRing3Tz" -1.0309913800000001;
	setAttr ".RightHandRing4Tx" -89.363995800000026;
	setAttr ".RightHandRing4Ty" 146.96889830000001;
	setAttr ".RightHandRing4Tz" -1.0980652959999995;
	setAttr ".RightHandPinky1Tx" -80.592357370000016;
	setAttr ".RightHandPinky1Ty" 146.2759509;
	setAttr ".RightHandPinky1Tz" -2.4895741939999998;
	setAttr ".RightHandPinky2Tx" -83.638299989999993;
	setAttr ".RightHandPinky2Ty" 146.27588489999999;
	setAttr ".RightHandPinky2Tz" -2.595861595000001;
	setAttr ".RightHandPinky3Tx" -85.613997130000072;
	setAttr ".RightHandPinky3Ty" 146.27584210000003;
	setAttr ".RightHandPinky3Tz" -2.6648030450000002;
	setAttr ".RightHandPinky4Tx" -87.281620980000042;
	setAttr ".RightHandPinky4Ty" 146.27580589999999;
	setAttr ".RightHandPinky4Tz" -2.7229943640000003;
	setAttr ".RightHandExtraFinger1Tx" -80.592357370000002;
	setAttr ".RightHandExtraFinger1Ty" 146.78871240000001;
	setAttr ".RightHandExtraFinger1Tz" -4.4895741940000002;
	setAttr ".RightHandExtraFinger1Ry" -2.0000646579999999;
	setAttr ".RightHandExtraFinger2Tx" -82.638299989999993;
	setAttr ".RightHandExtraFinger2Ty" 146.7887121;
	setAttr ".RightHandExtraFinger2Tz" -4.5958615949999997;
	setAttr ".RightHandExtraFinger2Ry" -2.0000646359999998;
	setAttr ".RightHandExtraFinger3Tx" -84.613997130000001;
	setAttr ".RightHandExtraFinger3Ty" 146.78871179999999;
	setAttr ".RightHandExtraFinger3Tz" -4.6648030450000002;
	setAttr ".RightHandExtraFinger3Ry" -2.0000646359999998;
	setAttr ".RightHandExtraFinger4Tx" -86.28162098;
	setAttr ".RightHandExtraFinger4Ty" 146.78871169999999;
	setAttr ".RightHandExtraFinger4Tz" -4.7229943639999998;
	setAttr ".RightHandExtraFinger4Ry" -2.0000646359999998;
	setAttr ".LeftFootThumb1Tx" 6.18422217;
	setAttr ".LeftFootThumb1Ty" 4.9992492679999998;
	setAttr ".LeftFootThumb1Tz" 1.930123209;
	setAttr ".LeftFootThumb2Tx" 4.551409713;
	setAttr ".LeftFootThumb2Ty" 2.6643834059999998;
	setAttr ".LeftFootThumb2Tz" 3.591937658;
	setAttr ".LeftFootThumb3Tx" 3.4619466889999999;
	setAttr ".LeftFootThumb3Ty" 1.8880788850000001;
	setAttr ".LeftFootThumb3Tz" 6.4001420700000002;
	setAttr ".LeftFootThumb4Tx" 3.4619466999999999;
	setAttr ".LeftFootThumb4Ty" 1.8880788550000001;
	setAttr ".LeftFootThumb4Tz" 9.6971958839999992;
	setAttr ".LeftFootIndex1Tx" 7.1105199680000002;
	setAttr ".LeftFootIndex1Ty" 1.888079117;
	setAttr ".LeftFootIndex1Tz" 12.9547209;
	setAttr ".LeftFootIndex2Tx" 7.1105199749999999;
	setAttr ".LeftFootIndex2Ty" 1.8880790999999999;
	setAttr ".LeftFootIndex2Tz" 14.82972745;
	setAttr ".LeftFootIndex3Tx" 7.1105199810000004;
	setAttr ".LeftFootIndex3Ty" 1.888079083;
	setAttr ".LeftFootIndex3Tz" 16.76314442;
	setAttr ".LeftFootIndex4Tx" 7.1105199880000001;
	setAttr ".LeftFootIndex4Ty" 1.8880790649999999;
	setAttr ".LeftFootIndex4Tz" 18.850666449999999;
	setAttr ".LeftFootMiddle1Tx" 8.9167242489999996;
	setAttr ".LeftFootMiddle1Ty" 1.888079163;
	setAttr ".LeftFootMiddle1Tz" 12.9547209;
	setAttr ".LeftFootMiddle2Tx" 8.9167242550000001;
	setAttr ".LeftFootMiddle2Ty" 1.888079147;
	setAttr ".LeftFootMiddle2Tz" 14.82860045;
	setAttr ".LeftFootMiddle3Tx" 8.9167242610000006;
	setAttr ".LeftFootMiddle3Ty" 1.888079131;
	setAttr ".LeftFootMiddle3Tz" 16.64971237;
	setAttr ".LeftFootMiddle4Tx" 8.9167242669999993;
	setAttr ".LeftFootMiddle4Ty" 1.8880791139999999;
	setAttr ".LeftFootMiddle4Tz" 18.565581959999999;
	setAttr ".LeftFootRing1Tx" 10.723903740000001;
	setAttr ".LeftFootRing1Ty" 1.888079211;
	setAttr ".LeftFootRing1Tz" 12.9547209;
	setAttr ".LeftFootRing2Tx" 10.723903740000001;
	setAttr ".LeftFootRing2Ty" 1.888079195;
	setAttr ".LeftFootRing2Tz" 14.71345226;
	setAttr ".LeftFootRing3Tx" 10.72390375;
	setAttr ".LeftFootRing3Ty" 1.8880791800000001;
	setAttr ".LeftFootRing3Tz" 16.472174209999999;
	setAttr ".LeftFootRing4Tx" 10.723903760000001;
	setAttr ".LeftFootRing4Ty" 1.8880791640000001;
	setAttr ".LeftFootRing4Tz" 18.27484922;
	setAttr ".LeftFootPinky1Tx" 12.52979668;
	setAttr ".LeftFootPinky1Ty" 1.888079257;
	setAttr ".LeftFootPinky1Tz" 12.9547209;
	setAttr ".LeftFootPinky2Tx" 12.52979669;
	setAttr ".LeftFootPinky2Ty" 1.8880792420000001;
	setAttr ".LeftFootPinky2Tz" 14.5796458;
	setAttr ".LeftFootPinky3Tx" 12.52979669;
	setAttr ".LeftFootPinky3Ty" 1.8880792289999999;
	setAttr ".LeftFootPinky3Tz" 16.143599309999999;
	setAttr ".LeftFootPinky4Tx" 12.5297967;
	setAttr ".LeftFootPinky4Ty" 1.8880792129999999;
	setAttr ".LeftFootPinky4Tz" 17.861196199999998;
	setAttr ".LeftFootExtraFinger1Tx" 5.0860939849999998;
	setAttr ".LeftFootExtraFinger1Ty" 1.888079254;
	setAttr ".LeftFootExtraFinger1Tz" 12.9547209;
	setAttr ".LeftFootExtraFinger2Tx" 5.0860939910000003;
	setAttr ".LeftFootExtraFinger2Ty" 1.888079236;
	setAttr ".LeftFootExtraFinger2Tz" 14.94401483;
	setAttr ".LeftFootExtraFinger3Tx" 5.0860939979999999;
	setAttr ".LeftFootExtraFinger3Ty" 1.8880792179999999;
	setAttr ".LeftFootExtraFinger3Tz" 16.99182682;
	setAttr ".LeftFootExtraFinger4Tx" 5.0860940049999996;
	setAttr ".LeftFootExtraFinger4Ty" 1.8880791990000001;
	setAttr ".LeftFootExtraFinger4Tz" 19.0793827;
	setAttr ".RightFootThumb1Tx" -6.180000014;
	setAttr ".RightFootThumb1Ty" 4.9992496019999999;
	setAttr ".RightFootThumb1Tz" 1.930123112;
	setAttr ".RightFootThumb2Tx" -4.5499999820000001;
	setAttr ".RightFootThumb2Ty" 2.6643838419999999;
	setAttr ".RightFootThumb2Tz" 3.5919375690000002;
	setAttr ".RightFootThumb3Tx" -3.4599999860000001;
	setAttr ".RightFootThumb3Ty" 1.888079335;
	setAttr ".RightFootThumb3Tz" 6.4001419850000003;
	setAttr ".RightFootThumb4Tx" -3.4599999860000001;
	setAttr ".RightFootThumb4Ty" 1.8880793090000001;
	setAttr ".RightFootThumb4Tz" 9.6971957989999993;
	setAttr ".RightFootIndex1Tx" -7.1099999839999999;
	setAttr ".RightFootIndex1Ty" 1.888079262;
	setAttr ".RightFootIndex1Tz" 12.95472064;
	setAttr ".RightFootIndex2Tx" -7.1099999839999999;
	setAttr ".RightFootIndex2Ty" 1.8880792479999999;
	setAttr ".RightFootIndex2Tz" 14.82972719;
	setAttr ".RightFootIndex3Tx" -7.1099999839999999;
	setAttr ".RightFootIndex3Ty" 1.8880792340000001;
	setAttr ".RightFootIndex3Tz" 16.76314416;
	setAttr ".RightFootIndex4Tx" -7.1099999839999999;
	setAttr ".RightFootIndex4Ty" 1.8880792179999999;
	setAttr ".RightFootIndex4Tz" 18.850666189999998;
	setAttr ".RightFootMiddle1Tx" -8.92;
	setAttr ".RightFootMiddle1Ty" 1.8880792049999999;
	setAttr ".RightFootMiddle1Tz" 12.954720630000001;
	setAttr ".RightFootMiddle2Tx" -8.92;
	setAttr ".RightFootMiddle2Ty" 1.8880791910000001;
	setAttr ".RightFootMiddle2Tz" 14.82860018;
	setAttr ".RightFootMiddle3Tx" -8.92;
	setAttr ".RightFootMiddle3Ty" 1.8880791770000001;
	setAttr ".RightFootMiddle3Tz" 16.649712099999999;
	setAttr ".RightFootMiddle4Tx" -8.92;
	setAttr ".RightFootMiddle4Ty" 1.8880791619999999;
	setAttr ".RightFootMiddle4Tz" 18.565581689999998;
	setAttr ".RightFootRing1Tx" -10.72;
	setAttr ".RightFootRing1Ty" 1.8880791610000001;
	setAttr ".RightFootRing1Tz" 12.95472062;
	setAttr ".RightFootRing2Tx" -10.72;
	setAttr ".RightFootRing2Ty" 1.888079147;
	setAttr ".RightFootRing2Tz" 14.713451989999999;
	setAttr ".RightFootRing3Tx" -10.72;
	setAttr ".RightFootRing3Ty" 1.888079134;
	setAttr ".RightFootRing3Tz" 16.472173940000001;
	setAttr ".RightFootRing4Tx" -10.72;
	setAttr ".RightFootRing4Ty" 1.88807912;
	setAttr ".RightFootRing4Tz" 18.274848949999999;
	setAttr ".RightFootPinky1Tx" -12.530000060000001;
	setAttr ".RightFootPinky1Ty" 1.8880791029999999;
	setAttr ".RightFootPinky1Tz" 12.95472062;
	setAttr ".RightFootPinky2Tx" -12.530000060000001;
	setAttr ".RightFootPinky2Ty" 1.888079091;
	setAttr ".RightFootPinky2Tz" 14.57964552;
	setAttr ".RightFootPinky3Tx" -12.530000060000001;
	setAttr ".RightFootPinky3Ty" 1.8880790789999999;
	setAttr ".RightFootPinky3Tz" 16.143599040000002;
	setAttr ".RightFootPinky4Tx" -12.530000060000001;
	setAttr ".RightFootPinky4Ty" 1.888079066;
	setAttr ".RightFootPinky4Tz" 17.86119592;
	setAttr ".RightFootExtraFinger1Tx" -5.0900000030000001;
	setAttr ".RightFootExtraFinger1Ty" 1.8880791260000001;
	setAttr ".RightFootExtraFinger1Tz" 12.95472064;
	setAttr ".RightFootExtraFinger2Tx" -5.0900000030000001;
	setAttr ".RightFootExtraFinger2Ty" 1.8880791109999999;
	setAttr ".RightFootExtraFinger2Tz" 14.944014579999999;
	setAttr ".RightFootExtraFinger3Tx" -5.0900000030000001;
	setAttr ".RightFootExtraFinger3Ty" 1.888079096;
	setAttr ".RightFootExtraFinger3Tz" 16.99182656;
	setAttr ".RightFootExtraFinger4Tx" -5.0900000030000001;
	setAttr ".RightFootExtraFinger4Ty" 1.88807908;
	setAttr ".RightFootExtraFinger4Tz" 19.079382450000001;
	setAttr ".LeftInHandThumbTx" 71.709864199999998;
	setAttr ".LeftInHandThumbTy" 146.58868419999999;
	setAttr ".LeftInHandIndexTx" 71.709864199999998;
	setAttr ".LeftInHandIndexTy" 146.58868419999999;
	setAttr ".LeftInHandMiddleTx" 71.709864199999998;
	setAttr ".LeftInHandMiddleTy" 146.58868419999999;
	setAttr ".LeftInHandRingTx" 71.709864199999998;
	setAttr ".LeftInHandRingTy" 146.58868419999999;
	setAttr ".LeftInHandPinkyTx" 71.709864199999998;
	setAttr ".LeftInHandPinkyTy" 146.58868419999999;
	setAttr ".LeftInHandExtraFingerTx" 71.709864199999998;
	setAttr ".LeftInHandExtraFingerTy" 146.58868419999999;
	setAttr ".RightInHandThumbTx" -71.709861489999994;
	setAttr ".RightInHandThumbTy" 146.58897870000001;
	setAttr ".RightInHandIndexTx" -71.709861489999994;
	setAttr ".RightInHandIndexTy" 146.58897870000001;
	setAttr ".RightInHandMiddleTx" -71.709861489999994;
	setAttr ".RightInHandMiddleTy" 146.58897870000001;
	setAttr ".RightInHandRingTx" -71.709861489999994;
	setAttr ".RightInHandRingTy" 146.58897870000001;
	setAttr ".RightInHandPinkyTx" -71.709861489999994;
	setAttr ".RightInHandPinkyTy" 146.58897870000001;
	setAttr ".RightInHandExtraFingerTx" -71.709861489999994;
	setAttr ".RightInHandExtraFingerTy" 146.58897870000001;
	setAttr ".LeftInFootThumbTx" 8.9100008010000007;
	setAttr ".LeftInFootThumbTy" 8.15039625;
	setAttr ".LeftInFootIndexTx" 8.9100008010000007;
	setAttr ".LeftInFootIndexTy" 8.1503963469999992;
	setAttr ".LeftInFootMiddleTx" 8.9100008010000007;
	setAttr ".LeftInFootMiddleTy" 8.1503963469999992;
	setAttr ".LeftInFootRingTx" 8.9100008010000007;
	setAttr ".LeftInFootRingTy" 8.1503963469999992;
	setAttr ".LeftInFootPinkyTx" 8.9100008010000007;
	setAttr ".LeftInFootPinkyTy" 8.1503963469999992;
	setAttr ".LeftInFootExtraFingerTx" 8.9100008010000007;
	setAttr ".LeftInFootExtraFingerTy" 8.1503963469999992;
	setAttr ".RightInFootThumbTx" -8.9100025980000002;
	setAttr ".RightInFootThumbTy" 8.1503963929999994;
	setAttr ".RightInFootThumbTz" 0.00043882099999999999;
	setAttr ".RightInFootIndexTx" -8.9100026190000001;
	setAttr ".RightInFootIndexTy" 8.1503963939999995;
	setAttr ".RightInFootIndexTz" 0.00043882099999999999;
	setAttr ".RightInFootMiddleTx" -8.9100026190000001;
	setAttr ".RightInFootMiddleTy" 8.1503963939999995;
	setAttr ".RightInFootMiddleTz" 0.00043882099999999999;
	setAttr ".RightInFootRingTx" -8.9100026190000001;
	setAttr ".RightInFootRingTy" 8.1503963939999995;
	setAttr ".RightInFootRingTz" 0.00043882099999999999;
	setAttr ".RightInFootPinkyTx" -8.9100026190000001;
	setAttr ".RightInFootPinkyTy" 8.1503963939999995;
	setAttr ".RightInFootPinkyTz" 0.00043882099999999999;
	setAttr ".RightInFootExtraFingerTx" -8.9100026190000001;
	setAttr ".RightInFootExtraFingerTy" 8.1503963939999995;
	setAttr ".RightInFootExtraFingerTz" 0.00043882099999999999;
	setAttr ".LeftShoulderExtraTx" 12.353625535000001;
	setAttr ".LeftShoulderExtraTy" 146.58868419999999;
	setAttr ".RightShoulderExtraTx" -12.353637216499999;
	setAttr ".RightShoulderExtraTy" 146.58898;
createNode HIKSolverNode -n "HIKSolverNode1";
	rename -uid "D6F2DC5B-4D63-E4BD-813E-9FB0842AF032";
	setAttr ".ihi" 0;
	setAttr ".OutputCharacterState" -type "HIKCharacterState" ;
	setAttr ".decs" -type "HIKCharacterState" ;
createNode HIKState2SK -n "HIKState2SK1";
	rename -uid "5283B984-4DC8-C576-25AE-03A97DFAC5D5";
	setAttr ".ihi" 0;
	setAttr ".HipsTx" 0.20443600416183472;
	setAttr ".HipsTy" 99.727279663085938;
	setAttr ".HipsTz" 0.035582758486270905;
	setAttr ".HipsRx" 0.32594660566872097;
	setAttr ".HipsRy" 0.32314729920141999;
	setAttr ".HipsRz" -1.8669106907388355;
	setAttr ".LeftUpLegTx" 8.9099947759637157;
	setAttr ".LeftUpLegTy" -6.2700025011681646;
	setAttr ".LeftUpLegTz" -3.4113687541470483e-08;
	setAttr ".LeftUpLegRx" -6.6013110846772038;
	setAttr ".LeftUpLegRy" 0.0060987529112359502;
	setAttr ".LeftUpLegRz" 1.8701772212058219;
	setAttr ".LeftLegTx" 6.2543772791912033e-06;
	setAttr ".LeftLegTy" -44.878687443570783;
	setAttr ".LeftLegTz" 4.923673466805667e-05;
	setAttr ".LeftLegRx" 13.104829766436239;
	setAttr ".LeftLegRy" -0.18616985251435331;
	setAttr ".LeftLegRz" -0.043753741578566402;
	setAttr ".LeftFootTx" 3.003629640119243e-06;
	setAttr ".LeftFootTy" -40.701010254940023;
	setAttr ".LeftFootTz" 1.4781365792471135e-06;
	setAttr ".LeftFootRx" -6.839738545607025;
	setAttr ".LeftFootRy" -0.12532151309532552;
	setAttr ".LeftFootRz" 0.035050545658765767;
	setAttr ".RightUpLegTx" -8.9100062050908893;
	setAttr ".RightUpLegTy" -6.2700045205611872;
	setAttr ".RightUpLegTz" -1.6526275126160783e-08;
	setAttr ".RightUpLegRx" -0.30289827123514335;
	setAttr ".RightUpLegRy" 0.0049010777476429018;
	setAttr ".RightUpLegRz" 1.8638152869799907;
	setAttr ".RightLegTx" -3.2805901462040765e-07;
	setAttr ".RightLegTy" -44.878684865772925;
	setAttr ".RightLegTz" 0.0003318814956336999;
	setAttr ".RightLegRx" 0.00024772033285974296;
	setAttr ".RightLegRy" -0.19034526141539906;
	setAttr ".RightFootTx" 2.1186186966559717e-05;
	setAttr ".RightFootTy" -40.700961517222964;
	setAttr ".RightFootTz" -5.2540094143509186e-06;
	setAttr ".RightFootRx" -0.033640386228668724;
	setAttr ".RightFootRy" -0.12692908730996924;
	setAttr ".RightFootRz" 0.0032545288949050429;
	setAttr ".SpineTx" 1.4792199047874988e-06;
	setAttr ".SpineTy" 6.9999986098556803;
	setAttr ".SpineTz" 1.0371196013103656e-08;
	setAttr ".SpineRx" 0.089990971678127585;
	setAttr ".SpineRy" 0.086168208407755076;
	setAttr ".SpineRz" -0.76598493767344866;
	setAttr ".LeftArmTx" 10.707255890228788;
	setAttr ".LeftArmTy" 0.00014404473105855686;
	setAttr ".LeftArmTz" -5.6811988446980877e-08;
	setAttr ".LeftArmRz" -67.007059172759057;
	setAttr ".LeftForeArmTx" 27.305472198323699;
	setAttr ".LeftForeArmTy" 0.00035300094997126052;
	setAttr ".LeftForeArmTz" -1.6312952957342475e-05;
	setAttr ".LeftForeArmRx" -0.0011120693793961545;
	setAttr ".LeftForeArmRy" -14.419505764382759;
	setAttr ".LeftForeArmRz" 0.00013390017196842499;
	setAttr ".LeftHandTx" 26.697143492685001;
	setAttr ".LeftHandTy" -0.0020511023226745806;
	setAttr ".LeftHandTz" -7.4169569366233645e-06;
	setAttr ".LeftHandRy" 0.00012208988877853927;
	setAttr ".RightArmTx" -10.707271493262056;
	setAttr ".RightArmTy" 0.00042214655117334132;
	setAttr ".RightArmTz" 7.4521397053217697e-07;
	setAttr ".RightArmRx" -63.233974185451032;
	setAttr ".RightArmRy" -10.632093164056799;
	setAttr ".RightArmRz" -35.80846100303205;
	setAttr ".RightForeArmTx" -27.305600897838673;
	setAttr ".RightForeArmTy" 0.00059067366095355567;
	setAttr ".RightForeArmTz" -0.00026927884767502519;
	setAttr ".RightForeArmRx" 0.21539336871314332;
	setAttr ".RightForeArmRy" 93.708163867075683;
	setAttr ".RightForeArmRz" 0.22898638410787578;
	setAttr ".RightHandTx" -26.696987595605222;
	setAttr ".RightHandTy" -0.0064862378668468779;
	setAttr ".RightHandTz" -2.4169579546651221e-06;
	setAttr ".RightHandRx" -6.0915423746208419e-05;
	setAttr ".RightHandRy" -0.00015876631333404997;
	setAttr ".HeadTx" 1.1528807698724108e-05;
	setAttr ".HeadTy" 20.000152759567499;
	setAttr ".HeadTz" 1.0560642138557341e-07;
	setAttr ".LeftToeBaseTx" 8.5791759119047128e-06;
	setAttr ".LeftToeBaseTy" -6.2623175667142448;
	setAttr ".LeftToeBaseTz" 12.954719833662613;
	setAttr ".RightToeBaseTx" -0.0010853061028850419;
	setAttr ".RightToeBaseTy" -6.2623176454056573;
	setAttr ".RightToeBaseTz" 12.954748323429468;
	setAttr ".LeftShoulderTx" 7.0000043185489815;
	setAttr ".LeftShoulderTy" 20.588553084696031;
	setAttr ".LeftShoulderTz" 1.879149289507609e-07;
	setAttr ".LeftShoulderRz" -6.063231177892618;
	setAttr ".RightShoulderTx" -7.0000020564187686;
	setAttr ".RightShoulderTy" 20.588560722386717;
	setAttr ".RightShoulderTz" 1.6441129790933928e-07;
	setAttr ".RightShoulderRx" 0.22104186785902577;
	setAttr ".RightShoulderRy" 6.3822194059729451;
	setAttr ".RightShoulderRz" -23.572143854109111;
	setAttr ".NeckTx" 1.5739690194749301e-05;
	setAttr ".NeckTy" 19.000009357790219;
	setAttr ".NeckTz" 3.0406823916528936e-06;
	setAttr ".NeckRx" -6.6550781139813455e-05;
	setAttr ".NeckRz" 0.00037650920255578537;
	setAttr ".Spine1Tx" -1.1078116912699443e-07;
	setAttr ".Spine1Ty" 19.000008289553364;
	setAttr ".Spine1Tz" -2.9810299784216454e-09;
	setAttr ".Spine1Rx" 0.78695500894798698;
	setAttr ".Spine1Ry" 0.82637442222849733;
	setAttr ".Spine1Rz" -5.1465071729586862;
createNode HIKControlSetNode -n "Character1_ControlRig";
	rename -uid "A36638BD-48C9-CCF8-12AD-01B4E87952E4";
	setAttr ".ihi" 0;
createNode keyingGroup -n "Character1_FullBodyKG";
	rename -uid "26B3F4C4-4757-1B22-72C2-F88D7FD74534";
	setAttr ".ihi" 0;
	setAttr -s 11 ".dnsm";
	setAttr -s 39 ".act";
	setAttr ".cat" -type "string" "FullBody";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_HipsBPKG";
	rename -uid "93D193EB-4C10-1FB5-A07D-7A93E4F58A74";
	setAttr ".ihi" 0;
	setAttr -s 12 ".dnsm";
	setAttr -s 2 ".act";
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_ChestBPKG";
	rename -uid "28B52DCA-414A-91AD-B7CB-6F83AB3ABC41";
	setAttr ".ihi" 0;
	setAttr -s 18 ".dnsm";
	setAttr -s 4 ".act";
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_LeftArmBPKG";
	rename -uid "02FB0F71-4FDE-3341-6627-9C83E00F7986";
	setAttr ".ihi" 0;
	setAttr -s 30 ".dnsm";
	setAttr -s 7 ".act";
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_RightArmBPKG";
	rename -uid "0800EBE7-46DB-7B44-2E27-F0A9AD6048A2";
	setAttr ".ihi" 0;
	setAttr -s 30 ".dnsm";
	setAttr -s 7 ".act";
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_LeftLegBPKG";
	rename -uid "E598AF59-4003-4DFD-F397-52A609C9BBC5";
	setAttr ".ihi" 0;
	setAttr -s 36 ".dnsm";
	setAttr -s 8 ".act";
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_RightLegBPKG";
	rename -uid "A203F9CD-4A99-F37D-B6F2-8785C1428BCF";
	setAttr ".ihi" 0;
	setAttr -s 36 ".dnsm";
	setAttr -s 8 ".act";
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_HeadBPKG";
	rename -uid "FBAB6AE3-4782-7AF5-04F9-6D920987270E";
	setAttr ".ihi" 0;
	setAttr -s 12 ".dnsm";
	setAttr -s 3 ".act";
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_LeftHandBPKG";
	rename -uid "176B326E-458A-8B77-82F9-C08AE2CEBC91";
	setAttr ".ihi" 0;
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_RightHandBPKG";
	rename -uid "C5347790-4C95-4628-3AFD-A9AD6743D017";
	setAttr ".ihi" 0;
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_LeftFootBPKG";
	rename -uid "1531D555-42FC-577C-0383-8289096F2C01";
	setAttr ".ihi" 0;
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode keyingGroup -n "Character1_RightFootBPKG";
	rename -uid "A9430468-4171-04DC-6003-389708407373";
	setAttr ".ihi" 0;
	setAttr ".cat" -type "string" "BodyPart";
	setAttr ".mr" yes;
createNode HIKFK2State -n "HIKFK2State1";
	rename -uid "B9B89DCE-4958-512F-A617-B29C21E66B7B";
	setAttr ".ihi" 0;
	setAttr ".OutputCharacterState" -type "HIKCharacterState" ;
createNode HIKEffector2State -n "HIKEffector2State1";
	rename -uid "A4F32435-4A6C-FDF5-E3FE-9C88A4379693";
	setAttr ".ihi" 0;
	setAttr ".EFF" -type "HIKEffectorState" ;
	setAttr ".EFFNA" -type "HIKEffectorState" ;
createNode HIKPinning2State -n "HIKPinning2State1";
	rename -uid "104CAACF-46FC-BF22-4276-38B554B1F865";
	setAttr ".ihi" 0;
	setAttr ".OutputEffectorState" -type "HIKEffectorState" ;
	setAttr ".OutputEffectorStateNoAux" -type "HIKEffectorState" ;
createNode HIKState2FK -n "HIKState2FK1";
	rename -uid "53914358-42E1-82E5-7ACA-0F9F8FAE727F";
	setAttr ".ihi" 0;
	setAttr ".HipsGX" -type "matrix" 0.99945330619812012 -0.032577455043792725 -0.0056399544700980186 0
		 0.032609514892101288 0.99945199489593506 0.0056887203827500343 0 0.0054515395313501358 -0.0058695264160633087 0.99996793270111084 0
		 0.20443600416183472 99.727279663085938 0.035582758486270905 1;
	setAttr ".LeftUpLegGX" -type "matrix" 0.9999845027923584 5.7592435041442513e-05 -0.0055577387101948261 0
		 -0.00066374859306961298 0.99402773380279541 -0.1091252863407135 0 0.0055182618089020252 0.10912728309631348 0.99401241540908813 0
		 8.9050979614257813 93.170448303222656 -0.050337530672550201 1;
	setAttr ".LeftLegGX" -type "matrix" 0.99999767541885376 -0.00034690590109676123 -0.0022445598151534796 0
		 0.00061174610164016485 0.99288338422775269 0.11909127980470657 0 0.0021872720681130886 -0.11909234523773193 0.99288100004196167 0
		 8.9348926544189453 48.559791564941406 4.8471112251281738 1;
	setAttr ".LeftFootGX" -type "matrix" 1 8.7311470553519399e-11 -2.58296467547936e-10 0
		 -8.7311484431307207e-11 1 -2.9802318834981634e-08 0 2.58296467547936e-10 2.9802318834981634e-08 1 0
		 8.9099969863891602 8.1484451293945313 -2.1457672119140625e-05 1;
	setAttr ".RightUpLegGX" -type "matrix" 0.99998492002487183 -5.3565054258797318e-05 -0.0055374894291162491 0
		 5.679253808921203e-05 1.0000001192092896 0.00058268720749765635 0 0.0055374568328261375 -0.00058299279771745205 0.9999847412109375 0
		 -8.9051609039306641 93.7509765625 0.050166469067335129 1;
	setAttr ".RightLegGX" -type "matrix" 0.99999779462814331 -5.4951004130998626e-05 -0.0022153637837618589 0
		 5.6251581554533914e-05 1.0000001192092896 0.00058701378293335438 0 0.0022153311874717474 -0.00058713695034384727 0.99999761581420898 0
		 -8.9077081680297852 48.872299194335938 0.024348119273781776 1;
	setAttr ".RightFootGX" -type "matrix" 1 3.6379796744534509e-12 -1.9072565748956549e-09 0
		 -3.637977939729975e-12 1 9.3132257461547852e-10 0 1.9072565748956549e-09 -9.3132257461547852e-10 1 0
		 -8.909998893737793 8.1713447570800781 0.00045092403888702393 1;
	setAttr ".SpineGX" -type "matrix" 0.99891895055770874 -0.045926909893751144 -0.0072193657979369164 0
		 0.04597872868180275 0.99891680479049683 0.0071833808906376362 0 0.0068816337734460831 -0.0075075509957969189 0.99994838237762451 0
		 0.43270403146743774 106.72344207763672 0.075403794646263123 1;
	setAttr ".LeftArmGX" -type "matrix" 0.15865366160869598 -0.9869961142539978 -0.025841446593403816 0
		 0.98714554309844971 0.15908083319664001 -0.015397544950246811 0 0.019308190792798996 -0.023066394031047821 0.99954766035079956 0
		 21.427143096923828 142.59028625488281 0.21290352940559387 1;
	setAttr ".LeftForeArmGX" -type "matrix" 0.15846386551856995 -0.96164810657501221 0.22388020157814026 0
		 0.98714566230773926 0.15908072888851166 -0.015397652983665466 0 -0.020807862281799316 0.22344230115413666 0.9744952917098999 0
		 25.759256362915039 115.639892578125 -0.49270784854888916 1;
	setAttr ".LeftHandGX" -type "matrix" 0.15846318006515503 -0.96164870262145996 0.22387814521789551 0
		 0.98714578151702881 0.15907998383045197 -0.015397652983665466 0 -0.020807377994060516 0.22344028949737549 0.97449576854705811 0
		 29.989791870117188 89.966636657714844 5.484245777130127 1;
	setAttr ".RightArmGX" -type "matrix" 0.39563053846359253 -0.9161878228187561 0.063843242824077606 0
		 0.37773165106773376 0.098961517214775085 -0.92061138153076172 0 0.83713501691818237 0.38833773136138916 0.38522538542747498 0
		 -11.894692420959473 152.55023193359375 2.277195930480957 1;
	setAttr ".RightForeArmGX" -type "matrix" -0.8609694242477417 -0.32827121019363403 -0.38854807615280151 0
		 0.37773633003234863 0.098949134349822998 -0.92061084508895874 0 0.34065651893615723 -0.93938654661178589 0.038807809352874756 0
		 -22.698047637939453 177.567138671875 0.5342862606048584 1;
	setAttr ".RightHandGX" -type "matrix" -0.86096811294555664 -0.32827380299568176 -0.38854888081550598 0
		 0.37773680686950684 0.098950497806072235 -0.92061060667037964 0 0.34065932035446167 -0.93938559293746948 0.03880816325545311 0
		 0.28724098205566406 186.33099365234375 10.907354354858398 1;
	setAttr ".HeadGX" -type "matrix" 0.9905659556388855 -0.13521847128868103 -0.022255534306168556 0
		 0.13567058742046356 0.99054741859436035 0.020236028358340263 0 0.019308872520923615 -0.023064540699124336 0.99954760074615479 0
		 6.597625732421875 164.3343505859375 1.0011181831359863 1;
	setAttr ".LeftToeBaseGX" -type "matrix" 1 8.7311470553519399e-11 -2.58296467547936e-10 0
		 -8.7311484431307207e-11 1 -2.9802318834981634e-08 0 2.58296467547936e-10 2.9802318834981634e-08 1 0
		 8.9100055694580078 1.8861279487609863 12.95469856262207 1;
	setAttr ".RightToeBaseGX" -type "matrix" 1 3.6379796744534509e-12 -1.9072565748956549e-09 0
		 -3.6379777228895405e-12 1 9.3132257461547852e-10 0 1.9072565748956549e-09 -9.3132257461547852e-10 1 0
		 -8.9110841751098633 1.909027099609375 12.955199241638184 1;
	setAttr ".LeftShoulderGX" -type "matrix" 0.97069263458251953 -0.23909591138362885 -0.024268578737974167 0
		 0.2395474761724472 0.97072196006774902 0.01777307316660881 0 0.019308574497699738 -0.023065667599439621 0.99954748153686523 0
		 11.03365421295166 145.15020751953125 0.47275090217590332 1;
	setAttr ".RightShoulderGX" -type "matrix" 0.8462148904800415 -0.51427727937698364 -0.13942497968673706 0
		 0.52092248201370239 0.85349774360656738 0.013468310236930847 0 0.11207246780395508 -0.08402668684720993 0.99014103412628174 0
		 -2.8342602252960205 147.04336547851563 0.78432846069335938 1;
	setAttr ".NeckGX" -type "matrix" 0.9905659556388855 -0.13521847128868103 -0.022255534306168556 0
		 0.13567058742046356 0.99054741859436035 0.020236028358340263 0 0.019308872520923615 -0.023064540699124336 0.99954760074615479 0
		 3.8841819763183594 144.52325439453125 0.59639471769332886 1;
	setAttr ".Spine1GX" -type "matrix" 0.99056506156921387 -0.13522498309612274 -0.022255523130297661 0
		 0.13567711412906647 0.99054652452468872 0.020237043499946594 0 0.019308576360344887 -0.023065671324729919 0.99954754114151001 0
		 1.3062999248504639 125.70286560058594 0.21188805997371674 1;
createNode HIKState2FK -n "HIKState2FK2";
	rename -uid "233E76CC-43F1-787A-7631-B59B2DEF44DD";
	setAttr ".ihi" 0;
	setAttr ".HipsGX" -type "matrix" 0.99945330619812012 -0.032577455043792725 -0.0056399544700980186 0
		 0.032609514892101288 0.99945199489593506 0.0056887203827500343 0 0.0054515395313501358 -0.0058695264160633087 0.99996793270111084 0
		 0.20443600416183472 99.727279663085938 0.035582758486270905 1;
	setAttr ".LeftUpLegGX" -type "matrix" 0.9999845027923584 5.7592435041442513e-05 -0.0055577387101948261 0
		 -0.00066374859306961298 0.99402773380279541 -0.1091252863407135 0 0.0055182618089020252 0.10912728309631348 0.99401241540908813 0
		 8.9050979614257813 93.170448303222656 -0.050337530672550201 1;
	setAttr ".LeftLegGX" -type "matrix" 0.99999767541885376 -0.00034690590109676123 -0.0022445598151534796 0
		 0.00061174610164016485 0.99288338422775269 0.11909127980470657 0 0.0021872720681130886 -0.11909234523773193 0.99288100004196167 0
		 8.9348926544189453 48.559791564941406 4.8471112251281738 1;
	setAttr ".LeftFootGX" -type "matrix" 1 8.7311470553519399e-11 -2.58296467547936e-10 0
		 -8.7311484431307207e-11 1 -2.9802318834981634e-08 0 2.58296467547936e-10 2.9802318834981634e-08 1 0
		 8.9099969863891602 8.1484451293945313 -2.1457672119140625e-05 1;
	setAttr ".RightUpLegGX" -type "matrix" 0.99998492002487183 -5.3565054258797318e-05 -0.0055374894291162491 0
		 5.679253808921203e-05 1.0000001192092896 0.00058268720749765635 0 0.0055374568328261375 -0.00058299279771745205 0.9999847412109375 0
		 -8.9051609039306641 93.7509765625 0.050166469067335129 1;
	setAttr ".RightLegGX" -type "matrix" 0.99999779462814331 -5.4951004130998626e-05 -0.0022153637837618589 0
		 5.6251581554533914e-05 1.0000001192092896 0.00058701378293335438 0 0.0022153311874717474 -0.00058713695034384727 0.99999761581420898 0
		 -8.9077081680297852 48.872299194335938 0.024348119273781776 1;
	setAttr ".RightFootGX" -type "matrix" 1 3.6379796744534509e-12 -1.9072565748956549e-09 0
		 -3.637977939729975e-12 1 9.3132257461547852e-10 0 1.9072565748956549e-09 -9.3132257461547852e-10 1 0
		 -8.909998893737793 8.1713447570800781 0.00045092403888702393 1;
	setAttr ".SpineGX" -type "matrix" 0.99891895055770874 -0.045926909893751144 -0.0072193657979369164 0
		 0.04597872868180275 0.99891680479049683 0.0071833808906376362 0 0.0068816337734460831 -0.0075075509957969189 0.99994838237762451 0
		 0.43270403146743774 106.72344207763672 0.075403794646263123 1;
	setAttr ".LeftArmGX" -type "matrix" 0.15865366160869598 -0.9869961142539978 -0.025841446593403816 0
		 0.98714554309844971 0.15908083319664001 -0.015397544950246811 0 0.019308190792798996 -0.023066394031047821 0.99954766035079956 0
		 21.427143096923828 142.59028625488281 0.21290352940559387 1;
	setAttr ".LeftForeArmGX" -type "matrix" 0.15846386551856995 -0.96164810657501221 0.22388020157814026 0
		 0.98714566230773926 0.15908072888851166 -0.015397652983665466 0 -0.020807862281799316 0.22344230115413666 0.9744952917098999 0
		 25.759256362915039 115.639892578125 -0.49270784854888916 1;
	setAttr ".LeftHandGX" -type "matrix" 0.15846318006515503 -0.96164870262145996 0.22387814521789551 0
		 0.98714578151702881 0.15907998383045197 -0.015397652983665466 0 -0.020807377994060516 0.22344028949737549 0.97449576854705811 0
		 29.989791870117188 89.966636657714844 5.484245777130127 1;
	setAttr ".RightArmGX" -type "matrix" 0.39563053846359253 -0.9161878228187561 0.063843242824077606 0
		 0.37773165106773376 0.098961517214775085 -0.92061138153076172 0 0.83713501691818237 0.38833773136138916 0.38522538542747498 0
		 -11.894692420959473 152.55023193359375 2.277195930480957 1;
	setAttr ".RightForeArmGX" -type "matrix" -0.8609694242477417 -0.32827121019363403 -0.38854807615280151 0
		 0.37773633003234863 0.098949134349822998 -0.92061084508895874 0 0.34065651893615723 -0.93938654661178589 0.038807809352874756 0
		 -22.698047637939453 177.567138671875 0.5342862606048584 1;
	setAttr ".RightHandGX" -type "matrix" -0.86096811294555664 -0.32827380299568176 -0.38854888081550598 0
		 0.37773680686950684 0.098950497806072235 -0.92061060667037964 0 0.34065932035446167 -0.93938559293746948 0.03880816325545311 0
		 0.28724098205566406 186.33099365234375 10.907354354858398 1;
	setAttr ".HeadGX" -type "matrix" 0.9905659556388855 -0.13521847128868103 -0.022255534306168556 0
		 0.13567058742046356 0.99054741859436035 0.020236028358340263 0 0.019308872520923615 -0.023064540699124336 0.99954760074615479 0
		 6.597625732421875 164.3343505859375 1.0011181831359863 1;
	setAttr ".LeftToeBaseGX" -type "matrix" 1 8.7311470553519399e-11 -2.58296467547936e-10 0
		 -8.7311484431307207e-11 1 -2.9802318834981634e-08 0 2.58296467547936e-10 2.9802318834981634e-08 1 0
		 8.9100055694580078 1.8861279487609863 12.95469856262207 1;
	setAttr ".RightToeBaseGX" -type "matrix" 1 3.6379796744534509e-12 -1.9072565748956549e-09 0
		 -3.6379777228895405e-12 1 9.3132257461547852e-10 0 1.9072565748956549e-09 -9.3132257461547852e-10 1 0
		 -8.9110841751098633 1.909027099609375 12.955199241638184 1;
	setAttr ".LeftShoulderGX" -type "matrix" 0.97069263458251953 -0.23909591138362885 -0.024268578737974167 0
		 0.2395474761724472 0.97072196006774902 0.01777307316660881 0 0.019308574497699738 -0.023065667599439621 0.99954748153686523 0
		 11.03365421295166 145.15020751953125 0.47275090217590332 1;
	setAttr ".RightShoulderGX" -type "matrix" 0.8462148904800415 -0.51427727937698364 -0.13942497968673706 0
		 0.52092248201370239 0.85349774360656738 0.013468310236930847 0 0.11207246780395508 -0.08402668684720993 0.99014103412628174 0
		 -2.8342602252960205 147.04336547851563 0.78432846069335938 1;
	setAttr ".NeckGX" -type "matrix" 0.9905659556388855 -0.13521847128868103 -0.022255534306168556 0
		 0.13567058742046356 0.99054741859436035 0.020236028358340263 0 0.019308872520923615 -0.023064540699124336 0.99954760074615479 0
		 3.8841819763183594 144.52325439453125 0.59639471769332886 1;
	setAttr ".Spine1GX" -type "matrix" 0.99056506156921387 -0.13522498309612274 -0.022255523130297661 0
		 0.13567711412906647 0.99054652452468872 0.020237043499946594 0 0.019308576360344887 -0.023065671324729919 0.99954754114151001 0
		 1.3062999248504639 125.70286560058594 0.21188805997371674 1;
createNode HIKEffectorFromCharacter -n "HIKEffectorFromCharacter1";
	rename -uid "C1F755D6-40C5-ED3C-2401-A6B5ED2397CD";
	setAttr ".ihi" 0;
	setAttr ".OutputEffectorState" -type "HIKEffectorState" ;
createNode HIKEffectorFromCharacter -n "HIKEffectorFromCharacter2";
	rename -uid "D8D797A9-4F60-D42C-6FE1-DFB6654F17D8";
	setAttr ".ihi" 0;
	setAttr ".OutputEffectorState" -type "HIKEffectorState" ;
createNode HIKState2Effector -n "HIKState2Effector1";
	rename -uid "9C74DC95-4264-BF64-F030-BAB43A8EB227";
	setAttr ".ihi" 0;
	setAttr ".HipsEffectorGXM[0]" -type "matrix" 0.99945330619812012 -0.032577455043792725 -0.0056399544700980186 0
		 0.032609514892101288 0.99945199489593506 0.0056887203827500343 0 0.0054515395313501358 -0.0058695264160633087 0.99996793270111084 0
		 -3.147125244140625e-05 93.460708618164063 -8.5530802607536316e-05 1;
	setAttr ".LeftAnkleEffectorGXM[0]" -type "matrix" 1 8.7311470553519399e-11 -2.58296467547936e-10 0
		 -8.7311484431307207e-11 1 -2.9802318834981634e-08 0 2.58296467547936e-10 2.9802318834981634e-08 1 0
		 8.9099969863891602 8.1484451293945313 -2.1457672119140625e-05 1;
	setAttr ".RightAnkleEffectorGXM[0]" -type "matrix" 1 3.6379796744534509e-12 -1.9072565748956549e-09 0
		 -3.637977939729975e-12 1 9.3132257461547852e-10 0 1.9072565748956549e-09 -9.3132257461547852e-10 1 0
		 -8.909998893737793 8.1713447570800781 0.00045092403888702393 1;
	setAttr ".LeftWristEffectorGXM[0]" -type "matrix" 0.15846318006515503 -0.96164870262145996 0.22387814521789551 0
		 0.98714578151702881 0.15907998383045197 -0.015397652983665466 0 -0.020807377994060516 0.22344028949737549 0.97449576854705811 0
		 29.989791870117188 89.966636657714844 5.484245777130127 1;
	setAttr ".RightWristEffectorGXM[0]" -type "matrix" -0.86096811294555664 -0.32827380299568176 -0.38854888081550598 0
		 0.37773683667182922 0.098950505256652832 -0.92061066627502441 0 0.34065935015678406 -0.93938565254211426 0.038808166980743408 0
		 0.28724098205566406 186.33099365234375 10.907354354858398 1;
	setAttr ".LeftKneeEffectorGXM[0]" -type "matrix" 0.99999767541885376 -0.00034690590109676123 -0.0022445598151534796 0
		 0.00061174610164016485 0.99288338422775269 0.11909127980470657 0 0.0021872723009437323 -0.11909235268831253 0.99288105964660645 0
		 8.9348926544189453 48.559791564941406 4.8471112251281738 1;
	setAttr ".RightKneeEffectorGXM[0]" -type "matrix" 0.99999779462814331 -5.4951004130998626e-05 -0.0022153637837618589 0
		 5.6251581554533914e-05 1.0000001192092896 0.00058701378293335438 0 0.0022153311874717474 -0.00058713695034384727 0.99999761581420898 0
		 -8.9077081680297852 48.872299194335938 0.024348119273781776 1;
	setAttr ".LeftElbowEffectorGXM[0]" -type "matrix" 0.15846386551856995 -0.96164810657501221 0.22388020157814026 0
		 0.98714566230773926 0.15908072888851166 -0.015397652983665466 0 -0.020807862281799316 0.22344230115413666 0.9744952917098999 0
		 25.759256362915039 115.639892578125 -0.49270784854888916 1;
	setAttr ".RightElbowEffectorGXM[0]" -type "matrix" -0.8609694242477417 -0.32827121019363403 -0.38854807615280151 0
		 0.37773633003234863 0.098949134349822998 -0.92061084508895874 0 0.34065651893615723 -0.93938654661178589 0.038807809352874756 0
		 -22.698047637939453 177.567138671875 0.5342862606048584 1;
	setAttr ".ChestOriginEffectorGXM[0]" -type "matrix" 0.99891895055770874 -0.045926909893751144 -0.0072193657979369164 0
		 0.04597872868180275 0.99891680479049683 0.0071833808906376362 0 0.0068816337734460831 -0.0075075509957969189 0.99994838237762451 0
		 0.43270403146743774 106.72344207763672 0.075403794646263123 1;
	setAttr ".ChestEndEffectorGXM[0]" -type "matrix" 0.99056506156921387 -0.13522498309612274 -0.022255523130297661 0
		 0.13567711412906647 0.99054652452468872 0.020237043499946594 0 0.019308576360344887 -0.023065671324729919 0.99954754114151001 0
		 4.0996971130371094 146.09678649902344 0.62853968143463135 1;
	setAttr ".LeftFootEffectorGXM[0]" -type "matrix" 1 8.7311470553519399e-11 -2.58296467547936e-10 0
		 -8.7311484431307207e-11 1 -2.9802318834981634e-08 0 2.58296467547936e-10 2.9802318834981634e-08 1 0
		 8.9100055694580078 1.8861279487609863 12.95469856262207 1;
	setAttr ".RightFootEffectorGXM[0]" -type "matrix" 1 3.6379796744534509e-12 -1.9072565748956549e-09 0
		 -3.6379777228895405e-12 1 9.3132257461547852e-10 0 1.9072565748956549e-09 -9.3132257461547852e-10 1 0
		 -8.9110841751098633 1.909027099609375 12.955199241638184 1;
	setAttr ".LeftShoulderEffectorGXM[0]" -type "matrix" 0.15865367650985718 -0.98699617385864258 -0.025841448456048965 0
		 0.98714554309844971 0.15908083319664001 -0.015397544950246811 0 0.019308190792798996 -0.023066394031047821 0.99954766035079956 0
		 21.427143096923828 142.59028625488281 0.21290352940559387 1;
	setAttr ".RightShoulderEffectorGXM[0]" -type "matrix" 0.39563056826591492 -0.91618788242340088 0.063843250274658203 0
		 0.37773165106773376 0.098961517214775085 -0.92061138153076172 0 0.83713501691818237 0.38833773136138916 0.38522538542747498 0
		 -11.894692420959473 152.55023193359375 2.277195930480957 1;
	setAttr ".HeadEffectorGXM[0]" -type "matrix" 0.9905659556388855 -0.13521847128868103 -0.022255534306168556 0
		 0.13567060232162476 0.99054747819900513 0.020236030220985413 0 0.019308874383568764 -0.023064542561769485 0.99954766035079956 0
		 6.597625732421875 164.3343505859375 1.0011181831359863 1;
	setAttr ".LeftHipEffectorGXM[0]" -type "matrix" 0.9999845027923584 5.7592435041442513e-05 -0.0055577387101948261 0
		 -0.00066374859306961298 0.99402773380279541 -0.1091252863407135 0 0.0055182618089020252 0.10912728309631348 0.99401241540908813 0
		 8.9050979614257813 93.170448303222656 -0.050337530672550201 1;
	setAttr ".RightHipEffectorGXM[0]" -type "matrix" 0.99998492002487183 -5.3565054258797318e-05 -0.0055374894291162491 0
		 5.679253808921203e-05 1.0000001192092896 0.00058268720749765635 0 0.0055374568328261375 -0.00058299279771745205 0.9999847412109375 0
		 -8.9051609039306641 93.7509765625 0.050166469067335129 1;
createNode HIKState2Effector -n "HIKState2Effector2";
	rename -uid "8D207C6B-4283-4AC4-157F-A2A783A6A6B2";
	setAttr ".ihi" 0;
	setAttr ".HipsEffectorGXM[0]" -type "matrix" 0.99945330619812012 -0.032577455043792725 -0.0056399544700980186 0
		 0.032609514892101288 0.99945199489593506 0.0056887203827500343 0 0.0054515395313501358 -0.0058695264160633087 0.99996793270111084 0
		 -3.147125244140625e-05 93.460708618164063 -8.5530802607536316e-05 1;
	setAttr ".LeftAnkleEffectorGXM[0]" -type "matrix" 1 8.7311470553519399e-11 -2.58296467547936e-10 0
		 -8.7311484431307207e-11 1 -2.9802318834981634e-08 0 2.58296467547936e-10 2.9802318834981634e-08 1 0
		 8.9099969863891602 8.1484451293945313 -2.1457672119140625e-05 1;
	setAttr ".RightAnkleEffectorGXM[0]" -type "matrix" 1 3.6379796744534509e-12 -1.9072565748956549e-09 0
		 -3.637977939729975e-12 1 9.3132257461547852e-10 0 1.9072565748956549e-09 -9.3132257461547852e-10 1 0
		 -8.909998893737793 8.1713447570800781 0.00045092403888702393 1;
	setAttr ".LeftWristEffectorGXM[0]" -type "matrix" 0.15846318006515503 -0.96164870262145996 0.22387814521789551 0
		 0.98714578151702881 0.15907998383045197 -0.015397652983665466 0 -0.020807377994060516 0.22344028949737549 0.97449576854705811 0
		 29.989791870117188 89.966636657714844 5.484245777130127 1;
	setAttr ".RightWristEffectorGXM[0]" -type "matrix" -0.86096811294555664 -0.32827380299568176 -0.38854888081550598 0
		 0.37773683667182922 0.098950505256652832 -0.92061066627502441 0 0.34065935015678406 -0.93938565254211426 0.038808166980743408 0
		 0.28724098205566406 186.33099365234375 10.907354354858398 1;
	setAttr ".LeftKneeEffectorGXM[0]" -type "matrix" 0.99999767541885376 -0.00034690590109676123 -0.0022445598151534796 0
		 0.00061174610164016485 0.99288338422775269 0.11909127980470657 0 0.0021872723009437323 -0.11909235268831253 0.99288105964660645 0
		 8.9348926544189453 48.559791564941406 4.8471112251281738 1;
	setAttr ".RightKneeEffectorGXM[0]" -type "matrix" 0.99999779462814331 -5.4951004130998626e-05 -0.0022153637837618589 0
		 5.6251581554533914e-05 1.0000001192092896 0.00058701378293335438 0 0.0022153311874717474 -0.00058713695034384727 0.99999761581420898 0
		 -8.9077081680297852 48.872299194335938 0.024348119273781776 1;
	setAttr ".LeftElbowEffectorGXM[0]" -type "matrix" 0.15846386551856995 -0.96164810657501221 0.22388020157814026 0
		 0.98714566230773926 0.15908072888851166 -0.015397652983665466 0 -0.020807862281799316 0.22344230115413666 0.9744952917098999 0
		 25.759256362915039 115.639892578125 -0.49270784854888916 1;
	setAttr ".RightElbowEffectorGXM[0]" -type "matrix" -0.8609694242477417 -0.32827121019363403 -0.38854807615280151 0
		 0.37773633003234863 0.098949134349822998 -0.92061084508895874 0 0.34065651893615723 -0.93938654661178589 0.038807809352874756 0
		 -22.698047637939453 177.567138671875 0.5342862606048584 1;
	setAttr ".ChestOriginEffectorGXM[0]" -type "matrix" 0.99891895055770874 -0.045926909893751144 -0.0072193657979369164 0
		 0.04597872868180275 0.99891680479049683 0.0071833808906376362 0 0.0068816337734460831 -0.0075075509957969189 0.99994838237762451 0
		 0.43270403146743774 106.72344207763672 0.075403794646263123 1;
	setAttr ".ChestEndEffectorGXM[0]" -type "matrix" 0.99056506156921387 -0.13522498309612274 -0.022255523130297661 0
		 0.13567711412906647 0.99054652452468872 0.020237043499946594 0 0.019308576360344887 -0.023065671324729919 0.99954754114151001 0
		 4.0996971130371094 146.09678649902344 0.62853968143463135 1;
	setAttr ".LeftFootEffectorGXM[0]" -type "matrix" 1 8.7311470553519399e-11 -2.58296467547936e-10 0
		 -8.7311484431307207e-11 1 -2.9802318834981634e-08 0 2.58296467547936e-10 2.9802318834981634e-08 1 0
		 8.9100055694580078 1.8861279487609863 12.95469856262207 1;
	setAttr ".RightFootEffectorGXM[0]" -type "matrix" 1 3.6379796744534509e-12 -1.9072565748956549e-09 0
		 -3.6379777228895405e-12 1 9.3132257461547852e-10 0 1.9072565748956549e-09 -9.3132257461547852e-10 1 0
		 -8.9110841751098633 1.909027099609375 12.955199241638184 1;
	setAttr ".LeftShoulderEffectorGXM[0]" -type "matrix" 0.15865367650985718 -0.98699617385864258 -0.025841448456048965 0
		 0.98714554309844971 0.15908083319664001 -0.015397544950246811 0 0.019308190792798996 -0.023066394031047821 0.99954766035079956 0
		 21.427143096923828 142.59028625488281 0.21290352940559387 1;
	setAttr ".RightShoulderEffectorGXM[0]" -type "matrix" 0.39563056826591492 -0.91618788242340088 0.063843250274658203 0
		 0.37773165106773376 0.098961517214775085 -0.92061138153076172 0 0.83713501691818237 0.38833773136138916 0.38522538542747498 0
		 -11.894692420959473 152.55023193359375 2.277195930480957 1;
	setAttr ".HeadEffectorGXM[0]" -type "matrix" 0.9905659556388855 -0.13521847128868103 -0.022255534306168556 0
		 0.13567060232162476 0.99054747819900513 0.020236030220985413 0 0.019308874383568764 -0.023064542561769485 0.99954766035079956 0
		 6.597625732421875 164.3343505859375 1.0011181831359863 1;
	setAttr ".LeftHipEffectorGXM[0]" -type "matrix" 0.9999845027923584 5.7592435041442513e-05 -0.0055577387101948261 0
		 -0.00066374859306961298 0.99402773380279541 -0.1091252863407135 0 0.0055182618089020252 0.10912728309631348 0.99401241540908813 0
		 8.9050979614257813 93.170448303222656 -0.050337530672550201 1;
	setAttr ".RightHipEffectorGXM[0]" -type "matrix" 0.99998492002487183 -5.3565054258797318e-05 -0.0055374894291162491 0
		 5.679253808921203e-05 1.0000001192092896 0.00058268720749765635 0 0.0055374568328261375 -0.00058299279771745205 0.9999847412109375 0
		 -8.9051609039306641 93.7509765625 0.050166469067335129 1;
createNode script -n "uiConfigurationScriptNode";
	rename -uid "473DA28C-45B9-D75F-D3B9-EC8C5945E89C";
	setAttr ".b" -type "string" (
		"// Maya Mel UI Configuration File.\n//\n//  This script is machine generated.  Edit at your own risk.\n//\n//\n\nglobal string $gMainPane;\nif (`paneLayout -exists $gMainPane`) {\n\n\tglobal int $gUseScenePanelConfig;\n\tint    $useSceneConfig = $gUseScenePanelConfig;\n\tint    $menusOkayInPanels = `optionVar -q allowMenusInPanels`;\tint    $nVisPanes = `paneLayout -q -nvp $gMainPane`;\n\tint    $nPanes = 0;\n\tstring $editorName;\n\tstring $panelName;\n\tstring $itemFilterName;\n\tstring $panelConfig;\n\n\t//\n\t//  get current state of the UI\n\t//\n\tsceneUIReplacement -update $gMainPane;\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Top View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Top View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"top\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n"
		+ "            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n"
		+ "            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n"
		+ "            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Side View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Side View\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"side\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n"
		+ "            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n"
		+ "            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Front View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Front View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"front\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n"
		+ "            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n"
		+ "            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 1\n            -height 1\n"
		+ "            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"modelPanel\" (localizedPanelLabel(\"Persp View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tmodelPanel -edit -l (localizedPanelLabel(\"Persp View\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        modelEditor -e \n            -camera \"persp\" \n            -useInteractiveMode 0\n            -displayLights \"default\" \n            -displayAppearance \"smoothShaded\" \n            -activeOnly 0\n            -ignorePanZoom 0\n            -wireframeOnShaded 0\n            -headsUpDisplay 1\n            -holdOuts 1\n            -selectionHiliteDisplay 1\n            -useDefaultMaterial 0\n            -bufferMode \"double\" \n            -twoSidedLighting 0\n            -backfaceCulling 0\n"
		+ "            -xray 0\n            -jointXray 0\n            -activeComponentsXray 0\n            -displayTextures 0\n            -smoothWireframe 0\n            -lineWidth 1\n            -textureAnisotropic 0\n            -textureHilight 1\n            -textureSampling 2\n            -textureDisplay \"modulate\" \n            -textureMaxSize 16384\n            -fogging 0\n            -fogSource \"fragment\" \n            -fogMode \"linear\" \n            -fogStart 0\n            -fogEnd 100\n            -fogDensity 0.1\n            -fogColor 0.5 0.5 0.5 1 \n            -depthOfFieldPreview 1\n            -maxConstantTransparency 1\n            -rendererName \"vp2Renderer\" \n            -objectFilterShowInHUD 1\n            -isFiltered 0\n            -colorResolution 256 256 \n            -bumpResolution 512 512 \n            -textureCompression 0\n            -transparencyAlgorithm \"frontAndBackCull\" \n            -transpInShadows 0\n            -cullingOverride \"none\" \n            -lowQualityLighting 0\n            -maximumNumHardwareLights 1\n            -occlusionCulling 0\n"
		+ "            -shadingModel 0\n            -useBaseRenderer 0\n            -useReducedRenderer 0\n            -smallObjectCulling 0\n            -smallObjectThreshold -1 \n            -interactiveDisableShadows 0\n            -interactiveBackFaceCull 0\n            -sortTransparent 1\n            -controllers 1\n            -nurbsCurves 1\n            -nurbsSurfaces 1\n            -polymeshes 1\n            -subdivSurfaces 1\n            -planes 1\n            -lights 1\n            -cameras 1\n            -controlVertices 1\n            -hulls 1\n            -grid 1\n            -imagePlane 1\n            -joints 1\n            -ikHandles 1\n            -deformers 1\n            -dynamics 1\n            -particleInstancers 1\n            -fluids 1\n            -hairSystems 1\n            -follicles 1\n            -nCloths 1\n            -nParticles 1\n            -nRigids 1\n            -dynamicConstraints 1\n            -locators 1\n            -manipulators 1\n            -pluginShapes 1\n            -dimensions 1\n            -handles 1\n            -pivots 1\n"
		+ "            -textures 1\n            -strokes 1\n            -motionTrails 1\n            -clipGhosts 1\n            -greasePencils 1\n            -shadows 0\n            -captureSequenceNumber -1\n            -width 819\n            -height 899\n            -sceneRenderFilter 0\n            $editorName;\n        modelEditor -e -viewSelected 0 $editorName;\n        modelEditor -e \n            -pluginObjects \"gpuCacheDisplayFilter\" 1 \n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"ToggledOutliner\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"ToggledOutliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -docTag \"isolOutln_fromSeln\" \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 1\n            -showReferenceMembers 1\n"
		+ "            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"defaultSetFilter\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n"
		+ "            -isSet 0\n            -isSetMember 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n            -renderFilterIndex 0\n            -selectionOrder \"chronological\" \n            -expandAttribute 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"outlinerPanel\" (localizedPanelLabel(\"Outliner\")) `;\n\tif (\"\" != $panelName) {\n"
		+ "\t\t$label = `panel -q -label $panelName`;\n\t\toutlinerPanel -edit -l (localizedPanelLabel(\"Outliner\")) -mbv $menusOkayInPanels  $panelName;\n\t\t$editorName = $panelName;\n        outlinerEditor -e \n            -showShapes 0\n            -showAssignedMaterials 0\n            -showTimeEditor 1\n            -showReferenceNodes 0\n            -showReferenceMembers 0\n            -showAttributes 0\n            -showConnected 0\n            -showAnimCurvesOnly 0\n            -showMuteInfo 0\n            -organizeByLayer 1\n            -organizeByClip 1\n            -showAnimLayerWeight 1\n            -autoExpandLayers 1\n            -autoExpand 0\n            -showDagOnly 1\n            -showAssets 1\n            -showContainedOnly 1\n            -showPublishedAsConnected 0\n            -showParentContainers 0\n            -showContainerContents 1\n            -ignoreDagHierarchy 0\n            -expandConnections 0\n            -showUpstreamCurves 1\n            -showUnitlessCurves 1\n            -showCompounds 1\n            -showLeafs 1\n            -showNumericAttrsOnly 0\n"
		+ "            -highlightActive 1\n            -autoSelectNewObjects 0\n            -doNotSelectNewObjects 0\n            -dropIsParent 1\n            -transmitFilters 0\n            -setFilter \"0\" \n            -showSetMembers 1\n            -allowMultiSelection 1\n            -alwaysToggleSelect 0\n            -directSelect 0\n            -displayMode \"DAG\" \n            -expandObjects 0\n            -setsIgnoreFilters 1\n            -containersIgnoreFilters 0\n            -editAttrName 0\n            -showAttrValues 0\n            -highlightSecondary 0\n            -showUVAttrsOnly 0\n            -showTextureNodesOnly 0\n            -attrAlphaOrder \"default\" \n            -animLayerFilterOptions \"allAffecting\" \n            -sortOrder \"none\" \n            -longNames 0\n            -niceNames 1\n            -showNamespace 1\n            -showPinIcons 0\n            -mapMotionTrails 0\n            -ignoreHiddenAttribute 0\n            -ignoreOutlinerColor 0\n            -renderFilterVisible 0\n            $editorName;\n\t\tif (!$useSceneConfig) {\n"
		+ "\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"graphEditor\" (localizedPanelLabel(\"Graph Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Graph Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 1\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n"
		+ "                -showParentContainers 1\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 1\n                -showCompounds 0\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 1\n                -doNotSelectNewObjects 0\n                -dropIsParent 1\n                -transmitFilters 1\n                -setFilter \"0\" \n                -showSetMembers 0\n                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n"
		+ "                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 1\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                -renderFilterVisible 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"GraphEd\");\n            animCurveEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 1\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 1\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -showResults \"off\" \n                -showBufferCurves \"off\" \n                -smoothness \"fine\" \n                -resultSamples 1.25\n                -resultScreenSamples 0\n                -resultUpdate \"delayed\" \n                -showUpstreamCurves 1\n"
		+ "                -showCurveNames 0\n                -showActiveCurveNames 0\n                -stackedCurves 0\n                -stackedCurvesMin -1\n                -stackedCurvesMax 1\n                -stackedCurvesSpace 0.2\n                -displayNormalized 0\n                -preSelectionHighlight 0\n                -constrainDrag 0\n                -classicMode 1\n                -valueLinesToggle 1\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dopeSheetPanel\" (localizedPanelLabel(\"Dope Sheet\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dope Sheet\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"OutlineEd\");\n            outlinerEditor -e \n                -showShapes 1\n                -showAssignedMaterials 0\n                -showTimeEditor 1\n                -showReferenceNodes 0\n                -showReferenceMembers 0\n"
		+ "                -showAttributes 1\n                -showConnected 1\n                -showAnimCurvesOnly 1\n                -showMuteInfo 0\n                -organizeByLayer 1\n                -organizeByClip 1\n                -showAnimLayerWeight 1\n                -autoExpandLayers 1\n                -autoExpand 0\n                -showDagOnly 0\n                -showAssets 1\n                -showContainedOnly 0\n                -showPublishedAsConnected 0\n                -showParentContainers 1\n                -showContainerContents 0\n                -ignoreDagHierarchy 0\n                -expandConnections 1\n                -showUpstreamCurves 1\n                -showUnitlessCurves 0\n                -showCompounds 1\n                -showLeafs 1\n                -showNumericAttrsOnly 1\n                -highlightActive 0\n                -autoSelectNewObjects 0\n                -doNotSelectNewObjects 1\n                -dropIsParent 1\n                -transmitFilters 0\n                -setFilter \"0\" \n                -showSetMembers 0\n"
		+ "                -allowMultiSelection 1\n                -alwaysToggleSelect 0\n                -directSelect 0\n                -displayMode \"DAG\" \n                -expandObjects 0\n                -setsIgnoreFilters 1\n                -containersIgnoreFilters 0\n                -editAttrName 0\n                -showAttrValues 0\n                -highlightSecondary 0\n                -showUVAttrsOnly 0\n                -showTextureNodesOnly 0\n                -attrAlphaOrder \"default\" \n                -animLayerFilterOptions \"allAffecting\" \n                -sortOrder \"none\" \n                -longNames 0\n                -niceNames 1\n                -showNamespace 1\n                -showPinIcons 0\n                -mapMotionTrails 1\n                -ignoreHiddenAttribute 0\n                -ignoreOutlinerColor 0\n                -renderFilterVisible 0\n                $editorName;\n\n\t\t\t$editorName = ($panelName+\"DopeSheetEd\");\n            dopeSheetEditor -e \n                -displayKeys 1\n                -displayTangents 0\n                -displayActiveKeys 0\n"
		+ "                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 0\n                -snapTime \"integer\" \n                -snapValue \"none\" \n                -outliner \"dopeSheetPanel1OutlineEd\" \n                -showSummary 1\n                -showScene 0\n                -hierarchyBelow 0\n                -showTicks 1\n                -selectionWindow 0 0 0 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"timeEditorPanel\" (localizedPanelLabel(\"Time Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Time Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"clipEditorPanel\" (localizedPanelLabel(\"Trax Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n"
		+ "\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Trax Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = clipEditorNameFromPanel($panelName);\n            clipEditor -e \n                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 0 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"sequenceEditorPanel\" (localizedPanelLabel(\"Camera Sequencer\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Camera Sequencer\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = sequenceEditorNameFromPanel($panelName);\n            clipEditor -e \n"
		+ "                -displayKeys 0\n                -displayTangents 0\n                -displayActiveKeys 0\n                -displayActiveKeyTangents 0\n                -displayInfinities 0\n                -displayValues 0\n                -autoFit 0\n                -snapTime \"none\" \n                -snapValue \"none\" \n                -initialized 0\n                -manageSequencer 1 \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperGraphPanel\" (localizedPanelLabel(\"Hypergraph Hierarchy\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypergraph Hierarchy\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"HyperGraphEd\");\n            hyperGraph -e \n                -graphLayoutStyle \"hierarchicalLayout\" \n                -orientation \"horiz\" \n                -mergeConnections 0\n                -zoom 1\n                -animateTransition 0\n"
		+ "                -showRelationships 1\n                -showShapes 0\n                -showDeformers 0\n                -showExpressions 0\n                -showConstraints 0\n                -showConnectionFromSelected 0\n                -showConnectionToSelected 0\n                -showConstraintLabels 0\n                -showUnderworld 0\n                -showInvisible 0\n                -transitionFrames 1\n                -opaqueContainers 0\n                -freeform 0\n                -imagePosition 0 0 \n                -imageScale 1\n                -imageEnabled 0\n                -graphType \"DAG\" \n                -heatMapDisplay 0\n                -updateSelection 1\n                -updateNodeAdded 1\n                -useDrawOverrideColor 0\n                -limitGraphTraversal -1\n                -range 0 0 \n                -iconSize \"smallIcons\" \n                -showCachedConnections 0\n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"hyperShadePanel\" (localizedPanelLabel(\"Hypershade\")) `;\n"
		+ "\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Hypershade\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"visorPanel\" (localizedPanelLabel(\"Visor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Visor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"nodeEditorPanel\" (localizedPanelLabel(\"Node Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Node Editor\")) -mbv $menusOkayInPanels  $panelName;\n\n\t\t\t$editorName = ($panelName+\"NodeEditorEd\");\n            nodeEditor -e \n                -allAttributes 0\n                -allNodes 0\n                -autoSizeNodes 1\n                -consistentNameSize 1\n"
		+ "                -createNodeCommand \"nodeEdCreateNodeCommand\" \n                -connectNodeOnCreation 0\n                -connectOnDrop 0\n                -highlightConnections 0\n                -copyConnectionsOnPaste 0\n                -defaultPinnedState 0\n                -additiveGraphingMode 0\n                -settingsChangedCallback \"nodeEdSyncControls\" \n                -traversalDepthLimit -1\n                -keyPressCommand \"nodeEdKeyPressCommand\" \n                -nodeTitleMode \"name\" \n                -gridSnap 0\n                -gridVisibility 1\n                -crosshairOnEdgeDragging 0\n                -popupMenuScript \"nodeEdBuildPanelMenus\" \n                -showNamespace 1\n                -showShapes 1\n                -showSGShapes 0\n                -showTransforms 1\n                -useAssets 1\n                -syncedSelection 1\n                -extendToShapes 1\n                -activeTab -1\n                -editorMode \"default\" \n                $editorName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"createNodePanel\" (localizedPanelLabel(\"Create Node\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Create Node\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"polyTexturePlacementPanel\" (localizedPanelLabel(\"UV Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"UV Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"renderWindowPanel\" (localizedPanelLabel(\"Render View\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Render View\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"shapePanel\" (localizedPanelLabel(\"Shape Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tshapePanel -edit -l (localizedPanelLabel(\"Shape Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextPanel \"posePanel\" (localizedPanelLabel(\"Pose Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tposePanel -edit -l (localizedPanelLabel(\"Pose Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynRelEdPanel\" (localizedPanelLabel(\"Dynamic Relationships\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Dynamic Relationships\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n"
		+ "\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"relationshipPanel\" (localizedPanelLabel(\"Relationship Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Relationship Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"referenceEditorPanel\" (localizedPanelLabel(\"Reference Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Reference Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"componentEditorPanel\" (localizedPanelLabel(\"Component Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Component Editor\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"dynPaintScriptedPanelType\" (localizedPanelLabel(\"Paint Effects\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Paint Effects\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"scriptEditorPanel\" (localizedPanelLabel(\"Script Editor\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Script Editor\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"profilerPanel\" (localizedPanelLabel(\"Profiler Tool\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Profiler Tool\")) -mbv $menusOkayInPanels  $panelName;\n"
		+ "\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\t$panelName = `sceneUIReplacement -getNextScriptedPanel \"contentBrowserPanel\" (localizedPanelLabel(\"Content Browser\")) `;\n\tif (\"\" != $panelName) {\n\t\t$label = `panel -q -label $panelName`;\n\t\tscriptedPanel -edit -l (localizedPanelLabel(\"Content Browser\")) -mbv $menusOkayInPanels  $panelName;\n\t\tif (!$useSceneConfig) {\n\t\t\tpanel -e -l $label $panelName;\n\t\t}\n\t}\n\n\n\tif ($useSceneConfig) {\n        string $configName = `getPanel -cwl (localizedPanelLabel(\"Current Layout\"))`;\n        if (\"\" != $configName) {\n\t\t\tpanelConfiguration -edit -label (localizedPanelLabel(\"Current Layout\")) \n\t\t\t\t-userCreated false\n\t\t\t\t-defaultImage \"vacantCell.xP:/\"\n\t\t\t\t-image \"\"\n\t\t\t\t-sc false\n\t\t\t\t-configString \"global string $gMainPane; paneLayout -e -cn \\\"single\\\" -ps 1 100 100 $gMainPane;\"\n\t\t\t\t-removeAllPanels\n\t\t\t\t-ap false\n\t\t\t\t\t(localizedPanelLabel(\"Persp View\")) \n\t\t\t\t\t\"modelPanel\"\n"
		+ "\t\t\t\t\t\"$panelName = `modelPanel -unParent -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels `;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 819\\n    -height 899\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t\t\"modelPanel -edit -l (localizedPanelLabel(\\\"Persp View\\\")) -mbv $menusOkayInPanels  $panelName;\\n$editorName = $panelName;\\nmodelEditor -e \\n    -cam `findStartUpCamera persp` \\n    -useInteractiveMode 0\\n    -displayLights \\\"default\\\" \\n    -displayAppearance \\\"smoothShaded\\\" \\n    -activeOnly 0\\n    -ignorePanZoom 0\\n    -wireframeOnShaded 0\\n    -headsUpDisplay 1\\n    -holdOuts 1\\n    -selectionHiliteDisplay 1\\n    -useDefaultMaterial 0\\n    -bufferMode \\\"double\\\" \\n    -twoSidedLighting 0\\n    -backfaceCulling 0\\n    -xray 0\\n    -jointXray 0\\n    -activeComponentsXray 0\\n    -displayTextures 0\\n    -smoothWireframe 0\\n    -lineWidth 1\\n    -textureAnisotropic 0\\n    -textureHilight 1\\n    -textureSampling 2\\n    -textureDisplay \\\"modulate\\\" \\n    -textureMaxSize 16384\\n    -fogging 0\\n    -fogSource \\\"fragment\\\" \\n    -fogMode \\\"linear\\\" \\n    -fogStart 0\\n    -fogEnd 100\\n    -fogDensity 0.1\\n    -fogColor 0.5 0.5 0.5 1 \\n    -depthOfFieldPreview 1\\n    -maxConstantTransparency 1\\n    -rendererName \\\"vp2Renderer\\\" \\n    -objectFilterShowInHUD 1\\n    -isFiltered 0\\n    -colorResolution 256 256 \\n    -bumpResolution 512 512 \\n    -textureCompression 0\\n    -transparencyAlgorithm \\\"frontAndBackCull\\\" \\n    -transpInShadows 0\\n    -cullingOverride \\\"none\\\" \\n    -lowQualityLighting 0\\n    -maximumNumHardwareLights 1\\n    -occlusionCulling 0\\n    -shadingModel 0\\n    -useBaseRenderer 0\\n    -useReducedRenderer 0\\n    -smallObjectCulling 0\\n    -smallObjectThreshold -1 \\n    -interactiveDisableShadows 0\\n    -interactiveBackFaceCull 0\\n    -sortTransparent 1\\n    -controllers 1\\n    -nurbsCurves 1\\n    -nurbsSurfaces 1\\n    -polymeshes 1\\n    -subdivSurfaces 1\\n    -planes 1\\n    -lights 1\\n    -cameras 1\\n    -controlVertices 1\\n    -hulls 1\\n    -grid 1\\n    -imagePlane 1\\n    -joints 1\\n    -ikHandles 1\\n    -deformers 1\\n    -dynamics 1\\n    -particleInstancers 1\\n    -fluids 1\\n    -hairSystems 1\\n    -follicles 1\\n    -nCloths 1\\n    -nParticles 1\\n    -nRigids 1\\n    -dynamicConstraints 1\\n    -locators 1\\n    -manipulators 1\\n    -pluginShapes 1\\n    -dimensions 1\\n    -handles 1\\n    -pivots 1\\n    -textures 1\\n    -strokes 1\\n    -motionTrails 1\\n    -clipGhosts 1\\n    -greasePencils 1\\n    -shadows 0\\n    -captureSequenceNumber -1\\n    -width 819\\n    -height 899\\n    -sceneRenderFilter 0\\n    $editorName;\\nmodelEditor -e -viewSelected 0 $editorName;\\nmodelEditor -e \\n    -pluginObjects \\\"gpuCacheDisplayFilter\\\" 1 \\n    $editorName\"\n"
		+ "\t\t\t\t$configName;\n\n            setNamedPanelLayout (localizedPanelLabel(\"Current Layout\"));\n        }\n\n        panelHistory -e -clear mainPanelHistory;\n        sceneUIReplacement -clear;\n\t}\n\n\ngrid -spacing 5 -size 12 -divisions 5 -displayAxes yes -displayGridLines yes -displayDivisionLines yes -displayPerspectiveLabels no -displayOrthographicLabels no -displayAxesBold yes -perspectiveLabelPosition axis -orthographicLabelPosition edge;\nviewManip -drawCompass 1 -compassAngle 0 -frontParameters \"\" -homeParameters \"\" -selectionLockParameters \"\";\n}\n");
	setAttr ".st" 3;
createNode script -n "sceneConfigurationScriptNode";
	rename -uid "A0E519DF-4E68-4812-B855-79B5930874CB";
	setAttr ".b" -type "string" "playbackOptions -min 0 -max 60 -ast 0 -aet 60 ";
	setAttr ".st" 6;
createNode animCurveTA -n "Character1_Ctrl_LeftShoulder_rotateX";
	rename -uid "C1BD025C-433E-2785-E4A5-7C8F6894210E";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftShoulder_rotateY";
	rename -uid "2A931882-453D-269A-D1A4-5D9634A7897E";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftShoulder_rotateZ";
	rename -uid "7ECFC528-450B-AFF8-D546-51A7B7EA4926";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -6.0632328076302686 9 -6.0632300546925091
		 19 -6.0632289232329599 30 -6.0632300546925091 41 -6.0632312202827947 52 -6.0632359766615087
		 60 -6.0632312202827947;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999999999845 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 -5.4669658232238444e-08 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999999999845 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 -5.4669658232238444e-08 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftArm_rotateZ";
	rename -uid "D168C26F-4C9B-90C5-13C8-A88683AEB35C";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 8.6784897129576276e-05 9 0.00016398776424815357
		 19 7.5076697973195826e-05 30 0.00016398776424815357 41 9.5674341196395362e-05 52 0.00011244008990229579
		 60 9.5674341196395362e-05;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftArm_rotateY";
	rename -uid "E4EA8444-462F-F7C5-F214-708EF60FA5B9";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 67.007070568045449 9 67.007041632290736
		 19 67.007035411454424 30 67.007041632290736 41 67.007054875673759 52 67.007040918132432
		 60 67.007054875673759;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999999989264 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 4.6324733685402012e-07 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999999989264 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 4.6324733685402012e-07 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftArm_rotateX";
	rename -uid "F0C46CC7-4861-1BE9-A0DE-1D9E52A6ABA7";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.00010841625234451325 9 0.0001782621100828622
		 19 9.2492415312734556e-05 30 0.0001782621100828622 41 0.00011609377855375715 52 0.00012955612775278718
		 60 0.00011609377855375715;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftForeArm_rotateZ";
	rename -uid "F5580962-4355-07EF-8BF4-14AA859A0055";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 14.419518906546188 9 14.419538739772896
		 19 14.419538806836529 30 14.419538739772896 41 14.41954182326382 52 14.419531724508916
		 60 14.41954182326382;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  0.99999999999998712 1 1 1 0.99999999999998712 
		1;
	setAttr -s 7 ".kiy[1:6]"  1.6145120723676034e-07 0 0 0 1.6145120723676034e-07 
		0;
	setAttr -s 7 ".kox[1:6]"  0.99999999999998712 1 1 1 0.99999999999998712 
		1;
	setAttr -s 7 ".koy[1:6]"  1.6145120723676034e-07 0 0 0 1.6145120723676034e-07 
		0;
createNode animCurveTA -n "Character1_Ctrl_LeftForeArm_rotateY";
	rename -uid "ED8B9B70-4FA7-2BD5-46F1-369357ECEF15";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -1.4124798605511682e-06 9 1.7406278669061106e-05
		 19 -4.1273260080889797e-05 30 1.7406278669061106e-05 41 -4.197811067947493e-06 52 6.7975172693548981e-05
		 60 -4.197811067947493e-06;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftForeArm_rotateX";
	rename -uid "21185BFB-40D5-74F3-1EE1-82824200AEBC";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -1.36294602878953e-05 9 2.554196752160617e-06
		 19 -2.7709932726609364e-06 30 2.554196752160617e-06 41 -7.5094912069962619e-06 52 7.6920287676428464e-06
		 60 -7.5094912069962619e-06;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftHand_rotateZ";
	rename -uid "C838EE86-4156-B1DA-52AC-848DB7285EEC";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -9.8581229555806462e-05 9 -8.475085498795538e-05
		 19 -0.00012378429371513337 30 -8.475085498795538e-05 41 -0.00012162928248312763 52 -9.9424233730925756e-05
		 60 -0.00012162928248312763;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftHand_rotateY";
	rename -uid "BE680FF8-4918-0C93-04C5-2AA2602513D4";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -6.7739834433131e-05 9 -1.7728672338312127e-05
		 19 -2.7207011074025078e-05 30 -1.7728672338312127e-05 41 -4.2387327975551712e-05
		 52 -2.5722268198247765e-05 60 -4.2387327975551712e-05;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftHand_rotateX";
	rename -uid "1E6E8E7B-44D9-1770-E7BD-539DACB99D6F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -7.2601074166358523e-06 9 -6.3635943413083489e-06
		 19 -1.2984552375931269e-05 30 -6.3635943413083489e-06 41 -9.6804865112673403e-06
		 52 -8.0527500115714985e-06 60 -9.6804865112673403e-06;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftWristEffector_rotateX";
	rename -uid "E61047B7-4AF8-3C5E-19C0-51B4C7EB7F44";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -54.55087449408645 9 -48.572137058940662
		 19 -54.550742470042167 30 -48.572137058940662 41 -54.550745599339912 52 -48.572033731353862
		 60 -54.550745599339912;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftWristEffector_rotateY";
	rename -uid "4AB876CE-46C6-2D85-34F3-5583C8553E91";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -74.080642638360942 9 -72.793949127612791
		 19 -74.080619647578033 30 -72.793949127612791 41 -74.080619556780022 52 -72.793920666233362
		 60 -74.080619556780022;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftWristEffector_rotateZ";
	rename -uid "4EA4BF9E-43D2-1276-CF1D-9F925FFE448D";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 54.70887812537471 9 49.026665411597669
		 19 54.70875401312361 30 49.026665411597669 41 54.708753398137645 52 49.026557444046588
		 60 54.708753398137645;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_LeftWristEffector_translateZ";
	rename -uid "526CE92A-4EDA-0DAF-1338-76A764EEE693";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 5.4842448234558105 9 5.4841170310974121
		 19 5.4842419624328613 30 5.4841170310974121 41 5.484245777130127 52 5.4841189384460449
		 60 5.484245777130127;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftWristEffector_translateY";
	rename -uid "1D47EEB8-41BE-2D7B-5DB5-5891CF07D7DC";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 89.966598510742188 9 91.05523681640625
		 19 89.966545104980469 30 91.05523681640625 41 89.966636657714844 52 91.05523681640625
		 60 89.966636657714844;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftWristEffector_translateX";
	rename -uid "6D1CEE40-46E9-F711-3739-86BA2644565A";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 29.989780426025391 9 31.295665740966797
		 19 29.989740371704102 30 31.295665740966797 41 29.989791870117188 52 31.295675277709961
		 60 29.989791870117188;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftElbowEffector_rotateX";
	rename -uid "350A2DF4-411A-8283-D81A-ED9DA9A7CDA5";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -54.550878154035281 9 -48.572265017600614
		 19 -54.550907422206663 30 -48.572265017600614 41 -54.550871661143397 52 -48.57217891745929
		 60 -54.550871661143397;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftElbowEffector_rotateY";
	rename -uid "3ABFA510-4DCB-FF30-65CD-94B302352225";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -74.080523522306265 9 -72.793873084769146
		 19 -74.080503703518602 30 -72.793873084769146 41 -74.080497290584233 52 -72.793829627847742
		 60 -74.080497290584233;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftElbowEffector_rotateZ";
	rename -uid "360A43BF-4C3D-F7E4-9634-0684D8551B7F";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 54.708889297770575 9 49.026806200651066
		 19 54.708938851426055 30 49.026806200651066 41 54.708894180392626 52 49.026717710522398
		 60 54.708894180392626;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_LeftElbowEffector_translateZ";
	rename -uid "F17F4B37-4D5A-C138-583E-C794179D71A9";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.49270623922348022 9 -0.47847342491149902
		 19 -0.49272361397743225 30 -0.47847342491149902 41 -0.49270784854888916 52 -0.47846633195877075
		 60 -0.49270784854888916;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftElbowEffector_translateY";
	rename -uid "284C82FF-46BB-80E7-63CC-429211515D50";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 115.63986968994141 9 116.55760192871094
		 19 115.63981628417969 30 116.55760192871094 41 115.639892578125 52 116.55759429931641
		 60 115.639892578125;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftElbowEffector_translateX";
	rename -uid "1D39D920-46B7-4EF5-6B3F-1685713BB271";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 25.759256362915039 9 26.117385864257813
		 19 25.759218215942383 30 26.117385864257813 41 25.759256362915039 52 26.117341995239258
		 60 25.759256362915039;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftShoulderEffector_rotateX";
	rename -uid "26B9E6F1-486E-1FF0-4927-068E4DFA2DD3";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 8.2502686689272977 9 6.7213312252309754
		 19 8.2502043354138124 30 6.7213312252309754 41 8.2502719828163169 52 6.7212244442394971
		 60 8.2502719828163169;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftShoulderEffector_rotateY";
	rename -uid "D172A88E-4172-C968-21A3-0EB21544E8F1";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 80.749914398956676 9 78.63348497659041
		 19 80.749874020121354 30 78.63348497659041 41 80.749893778616965 52 78.633488224467584
		 60 80.749893778616965;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftShoulderEffector_rotateZ";
	rename -uid "D3ADE6BC-4711-3B23-2F6B-FBB3C9B43D0E";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 9.2510727590531463 9 7.6973215277142515
		 19 9.2510103335299831 30 7.6973215277142515 41 9.2510759024661731 52 7.6972156793922304
		 60 9.2510759024661731;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_LeftShoulderEffector_translateZ";
	rename -uid "5467444C-435A-642F-D3A4-988C3276994F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.21290335059165955 9 0.24233266711235046
		 19 0.21290481090545654 30 0.24233266711235046 41 0.21290352940559387 52 0.24233081936836243
		 60 0.21290352940559387;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftShoulderEffector_translateY";
	rename -uid "23B9BAD6-46EF-3C2B-D277-F1B8546EE508";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 142.59028625488281 9 143.3275146484375
		 19 142.59022521972656 30 143.3275146484375 41 142.59028625488281 52 143.3275146484375
		 60 142.59028625488281;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftShoulderEffector_translateX";
	rename -uid "A85D708C-4123-664F-FEEF-23A27E966960";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 21.427146911621094 9 20.784385681152344
		 19 21.427108764648438 30 20.784385681152344 41 21.427143096923828 52 20.784355163574219
		 60 21.427143096923828;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Hips_rotateZ";
	rename -uid "F7B42796-4DA2-C7C2-BEC3-A9892DC229C3";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.32611483520531787 9 0.32611598299950884
		 19 0.3261154491741462 30 0.32611598299950884 41 0.32611486189869093 52 0.32611518218023572
		 60 0.32611486189869093;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Hips_rotateY";
	rename -uid "8F522AF8-47F2-AFF2-39F8-97B2C3BC3EAB";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -1.8687185723334963 9 -1.8686221572434834
		 19 -1.8686895589065626 30 -1.8686221572434834 41 -1.8687187858086063 52 -1.8686225828761309
		 60 -1.8687187858086063;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Hips_rotateX";
	rename -uid "60D5E67C-441F-AEDA-861C-77A6278B9B1B";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.31251796858429459 9 0.31251913773737083
		 19 0.3125174252768802 30 0.31251913773737083 41 0.31251796646101027 52 0.31251974829528423
		 60 0.31251796646101027;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_Hips_translateZ";
	rename -uid "E81CB711-405F-5574-4C9C-D78DFA811546";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.035582751035690308 9 0.035582683980464935
		 19 0.035582751035690308 30 0.035582683980464935 41 0.035582758486270905 52 0.035582523792982101
		 60 0.035582758486270905;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_Hips_translateY";
	rename -uid "0A998303-4317-6269-BA47-E7AA4052B751";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 99.727279663085938 9 99.727203369140625
		 19 99.727218627929688 30 99.727203369140625 41 99.727279663085938 52 99.727195739746094
		 60 99.727279663085938;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_Hips_translateX";
	rename -uid "665BE93E-452C-FB8F-5C43-6AB0C28345AD";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.20443885028362274 9 0.20432731509208679
		 19 0.20440228283405304 30 0.20432731509208679 41 0.20443600416183472 52 0.204290971159935
		 60 0.20443600416183472;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_HipsEffector_rotateX";
	rename -uid "EC93D079-4130-3B8D-1883-2C9FAE0AA538";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.3125179640081559 9 0.3125191373620384
		 19 0.31251742196946131 30 0.3125191373620384 41 0.31251796187534026 52 0.31251974790299453
		 60 0.31251796187534026;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_HipsEffector_rotateY";
	rename -uid "97FDD190-4E10-D931-4DC0-35B3D118E85B";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -1.8687185444956365 9 -1.868622154960365
		 19 -1.8686895387869422 30 -1.868622154960365 41 -1.868718757912762 52 -1.8686225804898677
		 60 -1.868718757912762;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_HipsEffector_rotateZ";
	rename -uid "E21382BA-4475-FFA2-0BD5-19A83D392578";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.32611483042333156 9 0.32611598260729296
		 19 0.32611544571793744 30 0.32611598260729296 41 0.32611485710674415 52 0.3261151817703018
		 60 0.32611485710674415;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_HipsEffector_translateZ";
	rename -uid "A1162E50-403D-2436-C039-D4B7E3BD9192";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -8.5532665252685547e-05 9 -8.5728242993354797e-05
		 19 -8.5599720478057861e-05 30 -8.5728242993354797e-05 41 -8.5530802607536316e-05
		 52 -8.5784122347831726e-05 60 -8.5530802607536316e-05;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_HipsEffector_translateY";
	rename -uid "FD781169-49CD-FD2F-8B6B-C7966C0BE526";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 93.460708618164063 9 93.46063232421875
		 19 93.460647583007813 30 93.46063232421875 41 93.460708618164063 52 93.46063232421875
		 60 93.460708618164063;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_HipsEffector_translateX";
	rename -uid "5A60F87F-44F7-1EA5-E86E-0E9F7A2167A9";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -2.765655517578125e-05 9 -0.00013113021850585938
		 19 -6.389617919921875e-05 30 -0.00013113021850585938 41 -3.147125244140625e-05 52 -0.00016832351684570313
		 60 -3.147125244140625e-05;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Spine_rotateZ";
	rename -uid "04EB56A3-4EEF-D6DE-C998-FAA8A056E745";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.089998622107243215 9 0.089999774976244173
		 19 0.089999585840101273 30 0.089999774976244173 41 0.089998914916357448 52 0.08999947076377468
		 60 0.089998914916357448;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Spine_rotateY";
	rename -uid "9DFBBE42-401D-0194-5C5C-A4A60B1A0213";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.7661210205605623 9 -0.76620656190789793
		 19 -0.76614746681370227 30 -0.76620656190789793 41 -0.76611932370451941 52 -0.76620315652300264
		 60 -0.76611932370451941;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Spine_rotateX";
	rename -uid "6EE8CE46-4A02-E515-3746-9688B44D0137";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.08496546267133509 9 0.084963416145665993
		 19 0.084963938234284692 30 0.084963416145665993 41 0.084964945521284668 52 0.084964550410451672
		 60 0.084964945521284668;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Spine1_rotateZ";
	rename -uid "010C28DD-4344-F687-DE96-B1A72A7142A0";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.7900719569835698 9 0.81824359218589349
		 19 0.79007142481783721 30 0.81824359218589349 41 0.79007187627125219 52 0.8182432743177338
		 60 0.79007187627125219;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Spine1_rotateY";
	rename -uid "80BBEBAB-4A94-9960-AA6E-A9B68F614AD1";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -5.1573694599125099 9 -3.0231769896543481
		 19 -5.1573701749683023 30 -3.0231769896543481 41 -5.157370095691455 52 -3.0231756983417264
		 60 -5.157370095691455;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Spine1_rotateX";
	rename -uid "8652AE45-4688-64A7-7D2B-1792D809FCBC";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.75542722920451399 9 0.75341608065864862
		 19 0.75542668823089831 30 0.75341608065864862 41 0.75542707861988723 52 0.75341578985693891
		 60 0.75542707861988723;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_ChestOriginEffector_rotateX";
	rename -uid "E0A8FBBF-48A3-35A5-40D2-1FA1A2CF6AC2";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.39470956610153474 9 0.39470881813898934
		 19 0.39470751829423761 30 0.39470881813898934 41 0.39470903663095974 52 0.39471057192537334
		 60 0.39470903663095974;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_ChestOriginEffector_rotateY";
	rename -uid "B92E1D50-4BEA-8BE4-50C7-E593BB6E70E7";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -2.635316982200369 9 -2.6353061209129498
		 19 -2.6353144205454768 30 -2.6353061209129498 41 -2.6353155012269771 52 -2.635303141938425
		 60 -2.6353155012269771;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_ChestOriginEffector_rotateZ";
	rename -uid "E3522700-4087-7E51-1FC1-98A86112CA88";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.41201627700714999 9 0.4120180939621591
		 19 0.41201771947986893 30 0.4120180939621591 41 0.41201660612630353 52 0.41201699913972006
		 60 0.41201660612630353;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_ChestOriginEffector_translateZ";
	rename -uid "7E6A234B-41FB-4953-F66E-BAACDBB28ABE";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.075404152274131775 9 0.075404174625873566
		 19 0.075404092669487 30 0.075404174625873566 41 0.075403794646263123 52 0.075403720140457153
		 60 0.075403794646263123;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_ChestOriginEffector_translateY";
	rename -uid "F9533E65-4088-5CD8-CED0-21AB8DEDD0E2";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 106.72344207763672 9 106.72336578369141
		 19 106.72338104248047 30 106.72336578369141 41 106.72344207763672 52 106.72335815429688
		 60 106.72344207763672;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_ChestOriginEffector_translateX";
	rename -uid "191FA337-41AF-F94A-4ED2-72969C3E8DC0";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.43270903825759888 9 0.43258491158485413
		 19 0.43266814947128296 30 0.43258491158485413 41 0.43270403146743774 52 0.43254959583282471
		 60 0.43270403146743774;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_ChestEndEffector_rotateX";
	rename -uid "B5198779-4FE3-F67E-F402-1BA86048AE3B";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 1.1166964130631565 9 1.1117956742474218
		 19 1.1166938698536155 30 1.1117956742474218 41 1.1166957539422273 52 1.111797202874319
		 60 1.1166957539422273;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_ChestEndEffector_rotateY";
	rename -uid "A84A8211-4A79-BC4E-4065-889EDEBCCD4F";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -7.7977768801728056 9 -5.6637919591007018
		 19 -7.7977750138807771 30 -5.6637919591007018 41 -7.7977760311573547 52 -5.6637877196657023
		 60 -7.7977760311573547;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_ChestEndEffector_rotateZ";
	rename -uid "BC802C19-49C9-2232-A49A-B699A1F2F0EC";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 1.1703999747286278 9 1.2121912867605786
		 19 1.1704010615990519 30 1.2121912867605786 41 1.1704002652516183 52 1.2121897879040489
		 60 1.1704002652516183;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_ChestEndEffector_translateZ";
	rename -uid "1202264D-4832-FB9C-E9CC-47A3BF55BD22";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.62853962182998657 9 0.64531654119491577
		 19 0.62854063510894775 30 0.64531654119491577 41 0.62853968143463135 52 0.64531517028808594
		 60 0.62853968143463135;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_ChestEndEffector_translateY";
	rename -uid "9A181A28-4082-1D6A-FB9C-6681E79F7D5D";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 146.09678649902344 9 146.18624877929688
		 19 146.09672546386719 30 146.18624877929688 41 146.09678649902344 52 146.18624877929688
		 60 146.09678649902344;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_ChestEndEffector_translateX";
	rename -uid "CDD470A0-4D3E-3FD9-8C12-48A804622998";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 4.0997028350830078 9 3.338080883026123
		 19 4.0996608734130859 30 3.338080883026123 41 4.0996971130371094 52 3.3380436897277832
		 60 4.0996971130371094;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightArm_rotateZ";
	rename -uid "44D1200B-4888-A75A-28CA-3C9DCD97058A";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 13.034538683850498 9 19.390093013522701
		 19 13.035751472034217 30 19.390093013522701 41 13.035561246070516 52 19.390088155950885
		 60 13.035561246070516;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightArm_rotateY";
	rename -uid "D06AD3DD-415C-7EB1-9456-15955075D104";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -35.09954135026873 9 -17.203533665323747
		 19 -35.100616103913566 30 -17.203533665323747 41 -35.100450024912284 52 -17.203540384029353
		 60 -35.100450024912284;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightArm_rotateX";
	rename -uid "C0BD3481-4288-7C42-5257-37A5B6D29F20";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -70.816259533156313 9 -73.654352493608442
		 19 -70.816961671798367 30 -73.654352493608442 41 -70.816862961862952 52 -73.654344965659675
		 60 -70.816862961862952;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightForeArm_rotateZ";
	rename -uid "B8269617-44E9-F4C7-EB8C-50B160A1E379";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 93.70870799092188 9 9.12879104710027 19 93.708013956058352
		 30 9.12879104710027 41 93.708134583701934 52 9.1287864108284698 60 93.708134583701934;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightForeArm_rotateY";
	rename -uid "937758E6-4F5A-B313-30CA-0987BF6637BE";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -8.3158753185997667e-05 9 0.0013329213262617756
		 19 1.9763653219267004e-05 30 0.0013329213262617756 41 -9.8799620383071087e-06 52 0.0013251915451967273
		 60 -9.8799620383071087e-06;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightForeArm_rotateX";
	rename -uid "3B16D059-464F-39E5-385C-13BA75DE2BBD";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.0018390278638669788 9 0.00019305089898887876
		 19 0.00056831559745739563 30 0.00019305089898887876 41 0.00075899932404171957 52 0.00020244368589988977
		 60 0.00075899932404171957;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightHand_rotateZ";
	rename -uid "4AF2FEBF-4A2C-B1D0-F5ED-DDB53ED9C415";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.00015938325917258021 9 -0.00016621454672806886
		 19 -0.00015076452054699224 30 -0.00016621454672806886 41 -0.00016335712866713306
		 52 -0.00015109895042663852 60 -0.00016335712866713306;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightHand_rotateY";
	rename -uid "43FA1971-4BB8-C95A-DD00-1B8CB7270662";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 4.5740218123990338e-05 9 7.1749114823335593e-05
		 19 5.4356270554860863e-05 30 7.1749114823335593e-05 41 5.6124208794727242e-05 52 4.5614438229242676e-05
		 60 5.6124208794727242e-05;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightHand_rotateX";
	rename -uid "1F9AEFF8-4B38-2EFF-ADC1-9294311342CD";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 3.431368796311613e-05 9 6.140479195450337e-05
		 19 7.6136355259697342e-05 30 6.140479195450337e-05 41 6.3547863133536466e-05 52 6.0249826904359674e-05
		 60 6.3547863133536466e-05;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  0.99999999999999378 1 1 1 0.99999999999999378 
		1;
	setAttr -s 7 ".kiy[1:6]"  1.1221094453617227e-07 0 0 0 1.1221094453617227e-07 
		0;
	setAttr -s 7 ".kox[1:6]"  0.99999999999999378 1 1 1 0.99999999999999378 
		1;
	setAttr -s 7 ".koy[1:6]"  1.1221094453617227e-07 0 0 0 1.1221094453617227e-07 
		0;
createNode animCurveTA -n "Character1_Ctrl_RightShoulder_rotateZ";
	rename -uid "7A241C84-4271-38C1-161F-FA8A3E0B3BD8";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -23.572160006391162 9 -23.572161133423499
		 19 -19.112289083154138 30 -23.572161133423499 41 -23.57215834129007 52 -15.711764304422854
		 60 -23.57215834129007;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightShoulder_rotateY";
	rename -uid "CF132415-4282-D0EF-2011-BD97870DC136";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 6.3822282894507598 9 6.3822311565744005
		 19 6.835588014039125 30 6.3822311565744005 41 6.3822286058056097 52 13.423951686708568
		 60 6.3822286058056097;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.9999999999999335 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 -3.6424893158508921e-07 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.9999999999999335 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 -3.6424893158508921e-07 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightShoulder_rotateX";
	rename -uid "46FD5828-423C-9FB0-F798-4EA305B62AC4";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.22078635245476325 9 0.22078667678692659
		 19 0.78214902409606823 30 0.22078667678692659 41 0.22078648669963424 52 12.595765866514784
		 60 0.22078648669963424;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999999999956 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 -2.7144401871833556e-08 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999999999956 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 -2.7144401871833556e-08 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightWristEffector_rotateX";
	rename -uid "FD7ABC5E-44E9-8D1E-C02A-A9BC270A8BEC";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -83.986918789256421 9 -101.39183397956042
		 19 -81.249908166085874 30 -101.39183397956042 41 -83.986903106084043 52 -125.11068303539274
		 60 -83.986903106084043;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightWristEffector_rotateY";
	rename -uid "792F0E0F-4842-5309-A9C0-7B986FE60977";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -19.164033506861266 9 -125.11814959056716
		 19 -22.811935976691867 30 -125.11814959056716 41 -19.164036473504908 52 -129.94943796064231
		 60 -19.164036473504908;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightWristEffector_rotateZ";
	rename -uid "15E0549E-4D20-E35A-9F0B-A49CE5C366FB";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 155.71066754770592 9 167.20984650061877
		 19 154.75304556942265 30 167.20984650061877 41 155.71067572603187 52 187.14227040121261
		 60 155.71067572603187;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_RightWristEffector_translateZ";
	rename -uid "EAA5E9AD-4191-C6A3-4090-BD8343A5EB97";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 10.907028198242188 9 -6.1516475677490234
		 19 11.450444221496582 30 -6.1516475677490234 41 10.907354354858398 52 5.7049078941345215
		 60 10.907354354858398;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightWristEffector_translateY";
	rename -uid "C9BC4A67-41DA-78E6-0CD3-93AF2A25749D";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 186.33114624023438 9 193.48507690429688
		 19 186.31105041503906 30 193.48507690429688 41 186.33099365234375 52 189.46595764160156
		 60 186.33099365234375;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightWristEffector_translateX";
	rename -uid "A207D27E-4070-AE6B-006B-55B1D58A3AB1";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.28760528564453125 9 -46.186050415039063
		 19 -2.7144088745117188 30 -46.186050415039063 41 0.28724098205566406 52 -50.466682434082031
		 60 0.28724098205566406;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightElbowEffector_rotateX";
	rename -uid "404173EF-4B84-7811-3B13-538D7538B906";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 83.986974283662519 9 101.39184143711256
		 19 81.250016288198609 30 101.39184143711256 41 83.986992412130093 52 125.11080171836882
		 60 83.986992412130093;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightElbowEffector_rotateY";
	rename -uid "F5CD7C89-4E5F-5ACE-3848-748DD4804A39";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 19.163880869314138 9 125.11797230534343
		 19 22.81179541393875 30 125.11797230534343 41 19.163878855581785 52 129.94928742828913
		 60 19.163878855581785;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightElbowEffector_rotateZ";
	rename -uid "1573091B-47D0-0283-CBAA-B9AA513F2EFB";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 155.71073201721666 9 167.20978092507266
		 19 154.7531284854129 30 167.20978092507266 41 155.71075424708306 52 187.14234749659252
		 60 155.71075424708306;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_RightElbowEffector_translateZ";
	rename -uid "A7B71ED7-4EA1-67B4-B98E-3FBCB6D6924F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.53395366668701172 9 -2.7517199516296387
		 19 0.95429730415344238 30 -2.7517199516296387 41 0.5342862606048584 52 3.5735154151916504
		 60 0.5342862606048584;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightElbowEffector_translateY";
	rename -uid "BE640E47-41D8-6828-BC60-CE82EF859D68";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 177.56729125976563 9 171.64776611328125
		 19 175.96047973632813 30 171.64776611328125 41 177.567138671875 52 168.99967956542969
		 60 177.567138671875;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightElbowEffector_translateX";
	rename -uid "47C1D511-4425-B1C5-A651-678D6BF15FAF";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -22.697689056396484 9 -31.209379196166992
		 19 -24.972572326660156 30 -31.209379196166992 41 -22.698047637939453 52 -33.457309722900391
		 60 -22.698047637939453;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightShoulderEffector_rotateX";
	rename -uid "B9DF13D2-4478-7B37-B8A7-EC887BE173B0";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -75.7012977762231 9 -80.601442923032167
		 19 -72.538665908502594 30 -80.601442923032167 41 -75.703391596005446 52 -60.021121535978281
		 60 -75.703391596005446;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightShoulderEffector_rotateY";
	rename -uid "FBC89E7B-4114-A8AB-CE16-C092A6EB6053";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -66.374172473638339 9 -45.900858924231542
		 19 -62.137653513841407 30 -45.900858924231542 41 -66.37500563924965 52 -42.342279214971434
		 60 -66.37500563924965;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightShoulderEffector_rotateZ";
	rename -uid "4FDF4F61-4789-8519-6136-36B354C94EDB";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 9.1645721599540266 9 15.369267291575959
		 19 6.2908880180257043 30 15.369267291575959 41 9.1668439155981645 52 -0.052173942042901128
		 60 9.1668439155981645;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_RightShoulderEffector_translateZ";
	rename -uid "B2729311-4AC3-C427-596C-418A9E4BED07";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 2.2771971225738525 9 2.2845578193664551
		 19 2.3521478176116943 30 2.2845578193664551 41 2.277195930480957 52 3.5551331043243408
		 60 2.277195930480957;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99819087579159349 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 -0.060124666206237493 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99819087579159349 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 -0.060124666206237493 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightShoulderEffector_translateY";
	rename -uid "D88F2AF9-4D46-E06C-79F7-6786BC55957C";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 152.55023193359375 9 152.03860473632813
		 19 151.82058715820313 30 152.03860473632813 41 152.55023193359375 52 150.6077880859375
		 60 152.55023193359375;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.70888733282641547 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0.70532173464189418 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.70888733282641547 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0.70532173464189418 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightShoulderEffector_translateX";
	rename -uid "E908A792-46B0-5058-D004-C790BD7A3FC5";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -11.894697189331055 9 -12.886863708496094
		 19 -12.287612915039063 30 -12.886863708496094 41 -11.894692420959473 52 -13.274782180786133
		 60 -11.894692420959473;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftUpLeg_rotateZ";
	rename -uid "A7804FE0-401D-FF14-1BB9-A9A94C74133F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -6.604861791723013 9 -6.6034870264384695
		 19 -6.6044841441286959 30 -6.6034870264384695 41 -6.6048007344371706 52 -6.6048671326880939
		 60 -6.6048007344371706;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftUpLeg_rotateY";
	rename -uid "25422631-415B-B42E-AA5D-D3A44CD0E33B";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -1.8584746084382253 9 -1.8584615083034208
		 19 -1.8584894022286751 30 -1.8584615083034208 41 -1.8584749252267694 52 -1.858454472181166
		 60 -1.8584749252267694;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftUpLeg_rotateX";
	rename -uid "0F4B993E-4CE5-6A31-82A9-86B619828C0F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.20901691473451134 9 0.20896978436953897
		 19 0.20900692675618265 30 0.20896978436953897 41 0.20901249020365245 52 0.20901174425778801
		 60 0.20901249020365245;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftLeg_rotateZ";
	rename -uid "B91DA5CA-4F3C-C4CF-F747-7BAEA0E269A9";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 13.104705195435479 9 13.10315850332276
		 19 13.104566630861296 30 13.10315850332276 41 13.104759375979819 52 13.104177641282361
		 60 13.104759375979819;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftLeg_rotateY";
	rename -uid "F83AE9FC-49E2-76B3-3281-4F8423C4AC76";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.00040392056859689417 9 0.00039592500014911958
		 19 0.00042472367856581541 30 0.00039592500014911958 41 0.00040341260489585109 52 0.00037539687797477861
		 60 0.00040341260489585109;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftLeg_rotateX";
	rename -uid "91D586EB-4650-A5B6-401D-359A4D416330";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.19124147332714775 9 0.19123838789088177
		 19 0.19123380226063691 30 0.19123838789088177 41 0.19124182155228181 52 0.19124688710254559
		 60 0.19124182155228181;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999999998179 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 1.9085869483806068e-07 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999999998179 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 1.9085869483806068e-07 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftFoot_rotateZ";
	rename -uid "1B3C98FC-461E-0BF0-F8BC-ADABEE460B71";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -6.8395141086742548 9 -6.8393475860492803
		 19 -6.8397563922747899 30 -6.8393475860492803 41 -6.8396314371095572 52 -6.8389888057608585
		 60 -6.8396314371095572;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftFoot_rotateY";
	rename -uid "60F03C87-45A4-2173-BAA2-A88A9B648773";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.1071329261575252 9 0.10717382722696651
		 19 0.10715030866931664 30 0.10717382722696651 41 0.1071345483127004 52 0.10717435408269439
		 60 0.1071345483127004;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftFoot_rotateX";
	rename -uid "5829DC63-445B-93BD-F149-2B9D6BD69428";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.073860414148209624 9 0.073783293753223803
		 19 0.07384455536314577 30 0.073783293753223803 41 0.073861782273856397 52 0.073764204579962522
		 60 0.073861782273856397;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftToeBase_rotateZ";
	rename -uid "99580480-4E16-2F56-37C3-BF8EB3CAE9EC";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftToeBase_rotateY";
	rename -uid "97854E04-4D1B-2EC8-4C6F-D996004F5149";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftToeBase_rotateX";
	rename -uid "C0D449A9-4220-08DA-7BE4-D68C081EF761";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftAnkleEffector_rotateX";
	rename -uid "A29310BC-4334-2839-C93A-A4AFA1001776";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftAnkleEffector_rotateY";
	rename -uid "56C2C94A-4903-5A85-7670-DCB07B6973FD";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftAnkleEffector_rotateZ";
	rename -uid "8B10A5C5-4E77-E6E1-382C-668C5FF94E75";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 -5.1226410632875603e-06 19 -2.5613209387547808e-06
		 30 -5.1226410632875603e-06 41 -1.7075470889476881e-06 52 -7.6839620020423293e-06
		 60 -1.7075470889476881e-06;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_LeftAnkleEffector_translateZ";
	rename -uid "3F4563C8-4CB8-E799-D801-9BA100395298";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -1.9073486328125e-05 9 -3.0994415283203125e-05
		 19 -2.002716064453125e-05 30 -3.0994415283203125e-05 41 -2.1457672119140625e-05 52 -3.4332275390625e-05
		 60 -2.1457672119140625e-05;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftAnkleEffector_translateY";
	rename -uid "598BD4C7-4A1B-A39E-35F3-E082771FEE38";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 8.14849853515625 9 8.1483917236328125
		 19 8.1484527587890625 30 8.1483917236328125 41 8.1484451293945313 52 8.1482658386230469
		 60 8.1484451293945313;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftAnkleEffector_translateX";
	rename -uid "3CF58136-4CBB-5088-3A61-CF86EBDD427D";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 8.9099969863891602 9 8.9099960327148438
		 19 8.9099969863891602 30 8.9099960327148438 41 8.9099969863891602 52 8.9099941253662109
		 60 8.9099969863891602;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftKneeEffector_rotateX";
	rename -uid "434985B3-43EB-751F-8B77-95AC7979E263";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.12531960376153486 9 -0.12533325611843443
		 19 -0.12533071249269728 30 -0.12533325611843443 41 -0.12532154970140502 52 -0.12532781397855072
		 60 -0.12532154970140502;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftKneeEffector_rotateY";
	rename -uid "45A7012B-49AC-DF9D-B6D4-5699BE8853C0";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.035049654962789091 9 0.034963262311901382
		 19 0.035029307578170681 30 0.034963262311901382 41 0.035050457847701368 52 0.034943823520383506
		 60 0.035050457847701368;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftKneeEffector_rotateZ";
	rename -uid "6BDFA939-4B32-64B7-642F-C6893C217F5C";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 6.8395448274451409 9 6.8393734413492675
		 19 6.8397841277985156 30 6.8393734413492675 41 6.8396600430475329 52 6.8390125904701327
		 60 6.8396600430475329;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_LeftKneeEffector_translateZ";
	rename -uid "88D9ED0A-4257-749C-C20A-78A8E18230CD";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 4.8470301628112793 9 4.8468966484069824
		 19 4.8472037315368652 30 4.8468966484069824 41 4.8471112251281738 52 4.8466358184814453
		 60 4.8471112251281738;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftKneeEffector_translateY";
	rename -uid "7FB72D47-4E93-20C9-2F56-8F87F4EBC3E8";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 48.559829711914063 9 48.55975341796875
		 19 48.559761047363281 30 48.55975341796875 41 48.559791564941406 52 48.559661865234375
		 60 48.559791564941406;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftKneeEffector_translateX";
	rename -uid "D95E22A4-44FD-1ADE-5E2F-9DAF1575BB8B";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 8.9348917007446289 9 8.9348297119140625
		 19 8.9348783493041992 30 8.9348297119140625 41 8.9348926544189453 52 8.9348239898681641
		 60 8.9348926544189453;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftFootEffector_rotateX";
	rename -uid "F9EBE9C9-48A2-DB44-0934-A29231F1B6A2";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftFootEffector_rotateY";
	rename -uid "3BE6F39C-49D3-69F1-9750-09819CE123AC";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 -5.122641056926453e-06 19 -2.5613209387547808e-06
		 30 -5.122641056926453e-06 41 -1.7075470825865789e-06 52 -7.6839619893201163e-06 60 -1.7075470825865789e-06;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftFootEffector_rotateZ";
	rename -uid "83A7983B-4DC6-E7AD-D722-62A3591F6493";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_LeftFootEffector_translateZ";
	rename -uid "BD1A712F-4433-6F75-373B-56B9E8B96345";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 12.954702377319336 9 12.954689025878906
		 19 12.95470142364502 30 12.954689025878906 41 12.95469856262207 52 12.954687118530273
		 60 12.95469856262207;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftFootEffector_translateY";
	rename -uid "4A62EDC4-404D-83B1-D0A5-8899B96CF9FF";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 1.8861813545227051 9 1.886075496673584
		 19 1.8861370086669922 30 1.886075496673584 41 1.8861279487609863 52 1.885951042175293
		 60 1.8861279487609863;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftFootEffector_translateX";
	rename -uid "619D2117-4F7C-F61D-6914-918292A8C055";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 8.9100055694580078 9 8.9100046157836914
		 19 8.9100055694580078 30 8.9100046157836914 41 8.9100055694580078 52 8.9100027084350586
		 60 8.9100055694580078;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_LeftHipEffector_rotateX";
	rename -uid "2EF6D61F-42BC-E4D7-63B7-DDB8D525C191";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.31617229729746227 9 -0.31616585101432754
		 19 -0.31616641948652313 30 -0.31616585101432754 41 -0.31617481374522782 52 -0.31616838560917027
		 60 -0.31617481374522782;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftHipEffector_rotateY";
	rename -uid "108F2A44-4A26-05EA-F648-26AA701379F5";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.038030452369654084 9 -0.038100670387027268
		 19 -0.038070545798590601 30 -0.038100670387027268 41 -0.038029998794460909 52 -0.038105924514174001
		 60 -0.038029998794460909;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_LeftHipEffector_rotateZ";
	rename -uid "E8F46BB8-4740-BD00-9941-E792E76C1BB1";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -6.2649573720627671 9 -6.2635822450697667
		 19 -6.2645792745707771 30 -6.2635822450697667 41 -6.2648964495475079 52 -6.2649624475082195
		 60 -6.2648964495475079;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_LeftHipEffector_translateZ";
	rename -uid "8907018D-4B75-9CAF-44A7-3DB23D435EF5";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.050337530672550201 9 -0.050337828695774078
		 19 -0.05033748596906662 30 -0.050337828695774078 41 -0.050337530672550201 52 -0.050337966531515121
		 60 -0.050337530672550201;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftHipEffector_translateY";
	rename -uid "F2FCDA25-495C-EDE4-85C2-9BB2C3C10DFA";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 93.170448303222656 9 93.170379638671875
		 19 93.170394897460938 30 93.170379638671875 41 93.170448303222656 52 93.170379638671875
		 60 93.170448303222656;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_LeftHipEffector_translateX";
	rename -uid "9CA97887-424B-2EA1-8902-34BBF43AF8D2";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 8.9051008224487305 9 8.9049968719482422
		 19 8.9050655364990234 30 8.9049968719482422 41 8.9050979614257813 52 8.9049587249755859
		 60 8.9050979614257813;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightUpLeg_rotateZ";
	rename -uid "6FFC87FC-4111-81FB-5B1F-708EEC478F72";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.30357471462339441 9 -0.35553724830407057
		 19 -0.34469899328917469 30 -0.35553724830407057 41 -0.30305890024054905 52 -0.37028838311954765
		 60 -0.30305890024054905;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightUpLeg_rotateY";
	rename -uid "62E469BA-459C-A281-90BF-7D935CEEE391";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -1.863801910955879 9 -1.8637384686266536
		 19 -1.8638422265886232 30 -1.8637384686266536 41 -1.8638223797811426 52 -1.8639112264921893
		 60 -1.8638223797811426;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightUpLeg_rotateX";
	rename -uid "A0FDFBC3-4A8D-F28F-CECC-D1ADD0BD7594";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.0049905829400847673 9 0.0066850018043167359
		 19 0.0063274431440581034 30 0.0066850018043167359 41 0.0049738741847958432 52 0.0071728385122967805
		 60 0.0049738741847958432;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightLeg_rotateZ";
	rename -uid "3D794C96-4136-F64C-8ED1-4D91DB3DD945";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.00011821583146041104 9 0.10507506254829224
		 19 0.089589180140227792 30 0.10507506254829224 41 0.0002477145177361594 52 0.14593286499591054
		 60 0.0002477145177361594;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightLeg_rotateY";
	rename -uid "7DB9DD44-4FC7-D8F5-3E8B-1E9A1AF6ACCC";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -2.7405545084770458e-05 9 -1.3046007394752774e-05
		 19 1.3557051179850761e-07 30 -1.3046007394752774e-05 41 -3.2366814403547599e-05 52 0.00010103377262452921
		 60 -3.2366814403547599e-05;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999999970068 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 -7.7355495207703389e-07 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999999970068 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 -7.7355495207703389e-07 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightLeg_rotateX";
	rename -uid "2BB7C87C-4D21-A531-9E7B-EC94BA2072E7";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.19034300617220198 9 0.19034460871737577
		 19 0.19034902033329354 30 0.19034460871737577 41 0.19034526327874424 52 0.19034286744918236
		 60 0.19034526327874424;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  0.99999999999999978 1 1 1 0.99999999999999978 
		1;
	setAttr -s 7 ".kiy[1:6]"  1.9696970365292926e-08 0 0 0 1.9696970365292926e-08 
		0;
	setAttr -s 7 ".kox[1:6]"  0.99999999999999978 1 1 1 0.99999999999999978 
		1;
	setAttr -s 7 ".koy[1:6]"  1.9696970365292926e-08 0 0 0 1.9696970365292926e-08 
		0;
createNode animCurveTA -n "Character1_Ctrl_RightFoot_rotateZ";
	rename -uid "4042CC4C-477E-F41F-F64D-1A91D5B08C74";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.032930139673454317 9 -0.085952118097016361
		 19 -0.081298673247487407 30 -0.085952118097016361 41 -0.033575312756879638 52 -0.11206588460461073
		 60 -0.033575312756879638;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightFoot_rotateY";
	rename -uid "8D0C52D5-46CD-4C30-0209-5DAC01AD4F28";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.11290117640629858 9 0.1128301338083401
		 19 0.11284594232318511 30 0.1128301338083401 41 0.1129089148480472 52 0.11281384862786155
		 60 0.1129089148480472;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightFoot_rotateX";
	rename -uid "764E2827-49A9-2DA5-7738-87B2F9D8240B";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.05810129931609169 9 0.058240280349874177
		 19 0.058205572237024897 30 0.058240280349874177 41 0.058079749256556824 52 0.058263808043832757
		 60 0.058079749256556824;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightToeBase_rotateZ";
	rename -uid "B5B6ED04-4E95-81E8-178F-FAA3169FB373";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightToeBase_rotateY";
	rename -uid "19261A36-4DF2-BFB1-52EF-6D9A1415370F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightToeBase_rotateX";
	rename -uid "10AA9017-4566-26E7-DD76-D1BCCFE7B688";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightAnkleEffector_rotateX";
	rename -uid "9D634178-4570-5A8E-0045-0388B84AF9CC";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightAnkleEffector_rotateY";
	rename -uid "29AD91D8-4BD5-D28C-B25B-0F8268B2895A";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightAnkleEffector_rotateZ";
	rename -uid "748BBCB2-4571-FA59-A106-0B8581E29442";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_RightAnkleEffector_translateZ";
	rename -uid "DFA0E737-4468-8916-C4BB-4181C5AAA163";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.00045099109411239624 9 0.0004509948194026947
		 19 0.00045080855488777161 30 0.0004509948194026947 41 0.00045092403888702393 52 0.00045112520456314087
		 60 0.00045092403888702393;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightAnkleEffector_translateY";
	rename -uid "14DA851E-42DF-9F9A-DBE8-EF87D547064E";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 8.1713523864746094 9 8.17132568359375
		 19 8.1712837219238281 30 8.17132568359375 41 8.1713447570800781 52 8.1713447570800781
		 60 8.1713447570800781;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999653640359 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 8.3229758234452979e-05 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999653640359 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 8.3229758234452979e-05 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightAnkleEffector_translateX";
	rename -uid "FFD33DD9-40DC-E180-9EEE-FAA79649A9B2";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -8.909998893737793 9 -8.9100008010864258
		 19 -8.9100008010864258 30 -8.9100008010864258 41 -8.909998893737793 52 -8.9100017547607422
		 60 -8.909998893737793;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightKneeEffector_rotateX";
	rename -uid "6B8F0BE2-463E-A43F-9C2B-BA90CA882CE2";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.12693157066475169 9 -0.12692304106174773
		 19 -0.12692272398655899 30 -0.12692304106174773 41 -0.1269291959673034 52 -0.12691611716613227
		 60 -0.1269291959673034;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightKneeEffector_rotateY";
	rename -uid "4DB36B67-4523-25EC-818E-99AC03406B07";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.0032445768951499723 9 0.0035142651858021071
		 19 0.003466569893249056 30 0.0035142651858021071 41 0.0032229773993288609 52 0.0035988139133404946
		 60 0.0032229773993288609;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightKneeEffector_rotateZ";
	rename -uid "2249CE50-4357-6D65-D456-97A13A7B0479";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.032988208098802631 9 0.086009979838188852
		 19 0.081356594937924909 30 0.086009979838188852 41 0.033633407336283588 52 0.112123623085548
		 60 0.033633407336283595;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_RightKneeEffector_translateZ";
	rename -uid "06869404-4BB2-671E-0BBB-558CEE117E91";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.023881066590547562 9 0.061552092432975769
		 19 0.058238409459590912 30 0.061552092432975769 41 0.024348119273781776 52 0.080106616020202637
		 60 0.024348119273781776;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightKneeEffector_translateY";
	rename -uid "C593D7A3-4082-452E-7905-B8842460EC3D";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 48.872325897216797 9 48.872249603271484
		 19 48.872200012207031 30 48.872249603271484 41 48.872299194335938 52 48.872264862060547
		 60 48.872299194335938;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999085394098 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0.00013524835636244235 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999085394098 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0.00013524835636244235 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightKneeEffector_translateX";
	rename -uid "5FCC1439-462F-ED6E-9823-A5A0C091548F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -8.9076976776123047 9 -8.907505989074707
		 19 -8.9075374603271484 30 -8.907505989074707 41 -8.9077081680297852 52 -8.9074420928955078
		 60 -8.9077081680297852;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightFootEffector_rotateX";
	rename -uid "3DCC2BD0-4C13-E0AF-1378-65806006478B";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightFootEffector_rotateY";
	rename -uid "50107D34-4812-562C-6DA0-A2A9A21DFF37";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightFootEffector_rotateZ";
	rename -uid "DD40B962-4442-AFE3-59D8-A5B861C7D149";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_RightFootEffector_translateZ";
	rename -uid "AAFB46AA-431E-86CB-1B7D-448C2DD1E05F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 12.9552001953125 9 12.9552001953125 19 12.955199241638184
		 30 12.9552001953125 41 12.955199241638184 52 12.955199241638184 60 12.955199241638184;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightFootEffector_translateY";
	rename -uid "57C6D237-4D10-ADD2-1094-118C08B7301E";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 1.9090352058410645 9 1.9090085029602051
		 19 1.9089670181274414 30 1.9090085029602051 41 1.909027099609375 52 1.9090280532836914
		 60 1.909027099609375;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999664379546 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 8.1929293270838191e-05 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999664379546 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 8.1929293270838191e-05 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightFootEffector_translateX";
	rename -uid "E9264536-4C03-1F17-690F-90882C649D6F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -8.9110841751098633 9 -8.9110860824584961
		 19 -8.9110860824584961 30 -8.9110860824584961 41 -8.9110841751098633 52 -8.9110870361328125
		 60 -8.9110841751098633;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_RightHipEffector_rotateX";
	rename -uid "A957EF76-4BBC-03ED-88B3-319A0B333A5E";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -0.31727460399736335 9 -0.31727361980914548
		 19 -0.31727679631015532 30 -0.31727361980914548 41 -0.31727450573684923 52 -0.31726687691172806
		 60 -0.31727450573684923;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightHipEffector_rotateY";
	rename -uid "544DE392-417E-6860-CA05-33BC2C46E035";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.003260918490877934 9 0.0029350605572048853
		 19 0.0029599293210339312 30 0.0029350605572048853 41 0.0032435630841636223 52 0.0026793051111511272
		 60 0.0032435630841636223;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_RightHipEffector_rotateZ";
	rename -uid "A42BC7F7-4A57-D09E-4021-498DFAAC49CE";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.032869863105169914 9 -0.019063525966764472
		 19 -0.0082311875175830589 30 -0.019063525966764472 41 0.033385538775257982 52 -0.033806424746510952
		 60 0.033385538775257982;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_RightHipEffector_translateZ";
	rename -uid "8F843B78-4F07-1B42-081A-549A6682DE87";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.05016646534204483 9 0.050166372209787369
		 19 0.050166286528110504 30 0.050166372209787369 41 0.050166469067335129 52 0.050166398286819458
		 60 0.050166469067335129;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999999996891 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 2.4891712448812924e-07 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999999996891 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 2.4891712448812924e-07 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightHipEffector_translateY";
	rename -uid "BA8580D0-45FF-7CF2-86EF-7F9C31DDFB7A";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 93.7509765625 9 93.750885009765625 19 93.750907897949219
		 30 93.750885009765625 41 93.7509765625 52 93.750877380371094 60 93.7509765625;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_RightHipEffector_translateX";
	rename -uid "E30E7B0B-4740-62A0-6F46-15AADB3F6218";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -8.905156135559082 9 -8.9052591323852539
		 19 -8.9051933288574219 30 -8.9052591323852539 41 -8.9051609039306641 52 -8.9052953720092773
		 60 -8.9051609039306641;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Head_rotateZ";
	rename -uid "F0177C3A-43E9-944D-1684-1697913A9F47";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Head_rotateY";
	rename -uid "173DFE2E-45DA-8CBF-07EE-C295382A0083";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Head_rotateX";
	rename -uid "11646769-406D-DF15-799B-25867F03165F";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0 9 0 19 0 30 0 41 0 52 0 60 0;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Neck_rotateZ";
	rename -uid "52D56148-49C7-0B36-E410-68AB7A2FBC78";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -6.052477069880115e-05 9 -5.9391031391164734e-05
		 19 -6.0992213525849733e-05 30 -5.9391031391164734e-05 41 -6.6539073580743747e-05
		 52 -6.5351407839158012e-05 60 -6.6539073580743747e-05;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Neck_rotateY";
	rename -uid "0BB3A215-4B25-37EA-62E1-F68DF706F1B3";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 0.00032138091714562785 9 0.00040165860496475998
		 19 0.00041705319493655585 30 0.00040165860496475998 41 0.00037650921265032532 52 0.00037958053391406858
		 60 0.00037650921265032532;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 0.99999999999953448 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 -9.6494452195179642e-07 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 0.99999999999953448 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 -9.6494452195179642e-07 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_Neck_rotateX";
	rename -uid "8AA74347-4E35-34D9-FC0B-428CE268BF68";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 7.0661352983753109e-06 9 1.2736389802044217e-05
		 19 1.1655014973152304e-05 30 1.2736389802044217e-05 41 8.2562731106516565e-06 52 1.1904327971022338e-05
		 60 8.2562731106516565e-06;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTA -n "Character1_Ctrl_HeadEffector_rotateX";
	rename -uid "6FD129B3-43DA-0912-8429-1EA2749E1EB9";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 1.1167108574767852 9 1.1118135526541562
		 19 1.1167127144605984 30 1.1118135526541562 41 1.1167120994127744 52 1.1118148733640381
		 60 1.1167120994127744;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_HeadEffector_rotateY";
	rename -uid "AC64B9B2-4DEE-DA14-8BFF-79AA864A6F05";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 -7.7974540466106319 9 -5.663389305973813
		 19 -7.7973564905360497 30 -5.663389305973813 41 -7.7973982209673958 52 -5.6634069746039435
		 60 -7.7973982209673958;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTA -n "Character1_Ctrl_HeadEffector_rotateZ";
	rename -uid "F5E92C6F-40B2-364C-DF30-4D8EDD1A3969";
	setAttr ".tan" 2;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 1.1703452159848087 9 1.2121394802099745
		 19 1.1703476646434492 30 1.2121394802099745 41 1.1703405581408615 52 1.2121315521101679
		 60 1.1703405581408615;
	setAttr -s 7 ".kit[0:6]"  18 2 2 18 2 2 18;
	setAttr -s 7 ".kot[0:6]"  18 2 2 18 2 2 18;
	setAttr ".roti" 5;
createNode animCurveTL -n "Character1_Ctrl_HeadEffector_translateZ";
	rename -uid "16FC76FF-45C8-325E-6D59-CCBD5845B791";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 1.0011208057403564 9 1.0328985452651978
		 19 1.0011262893676758 30 1.0328985452651978 41 1.0011181831359863 52 1.032895565032959
		 60 1.0011181831359863;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_HeadEffector_translateY";
	rename -uid "E46C9F11-4D25-49DC-5C7A-D1A3CDC254D8";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 164.33430480957031 9 164.50390625 19 164.33480834960938
		 30 164.50390625 41 164.3343505859375 52 164.50390625 60 164.3343505859375;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
createNode animCurveTL -n "Character1_Ctrl_HeadEffector_translateX";
	rename -uid "E3F1C884-49A3-8AE2-D4C2-04B87CA526E8";
	setAttr ".tan" 1;
	setAttr ".wgt" no;
	setAttr -s 7 ".ktv[0:6]"  0 6.5976443290710449 9 5.1550025939941406
		 19 6.5976128578186035 30 5.1550025939941406 41 6.597625732421875 52 5.154963493347168
		 60 6.597625732421875;
	setAttr -s 7 ".kit[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kot[0:6]"  18 1 1 18 1 1 18;
	setAttr -s 7 ".kix[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".kiy[1:6]"  0 0 0 0 0 0;
	setAttr -s 7 ".kox[1:6]"  1 1 1 1 1 1;
	setAttr -s 7 ".koy[1:6]"  0 0 0 0 0 0;
select -ne :time1;
	setAttr ".o" 0;
select -ne :hardwareRenderingGlobals;
	setAttr ".otfna" -type "stringArray" 22 "NURBS Curves" "NURBS Surfaces" "Polygons" "Subdiv Surface" "Particles" "Particle Instance" "Fluids" "Strokes" "Image Planes" "UI" "Lights" "Cameras" "Locators" "Joints" "IK Handles" "Deformers" "Motion Trails" "Components" "Hair Systems" "Follicles" "Misc. UI" "Ornaments"  ;
	setAttr ".otfva" -type "Int32Array" 22 0 1 1 1 1 1
		 1 1 1 0 0 0 0 0 0 0 0 0
		 0 0 0 0 ;
	setAttr ".fprt" yes;
select -ne :renderPartition;
	setAttr -s 2 ".st";
select -ne :renderGlobalsList1;
select -ne :defaultShaderList1;
	setAttr -s 4 ".s";
select -ne :postProcessList1;
	setAttr -s 2 ".p";
select -ne :defaultRenderingList1;
select -ne :initialShadingGroup;
	setAttr ".ro" yes;
select -ne :initialParticleSE;
	setAttr ".ro" yes;
select -ne :defaultRenderGlobals;
	setAttr ".ren" -type "string" "arnold";
select -ne :defaultResolution;
	setAttr ".pa" 1;
select -ne :hardwareRenderGlobals;
	setAttr ".ctrs" 256;
	setAttr ".btrs" 512;
select -ne :ikSystem;
	setAttr -s 4 ".sol";
connectAttr "HIKState2SK1.HipsSx" "Hips.sx";
connectAttr "HIKState2SK1.HipsSy" "Hips.sy";
connectAttr "HIKState2SK1.HipsSz" "Hips.sz";
connectAttr "HIKState2SK1.HipsTx" "Hips.tx";
connectAttr "HIKState2SK1.HipsTy" "Hips.ty";
connectAttr "HIKState2SK1.HipsTz" "Hips.tz";
connectAttr "HIKState2SK1.HipsRx" "Hips.rx";
connectAttr "HIKState2SK1.HipsRy" "Hips.ry";
connectAttr "HIKState2SK1.HipsRz" "Hips.rz";
connectAttr "Hips.s" "LeftUpLeg.is";
connectAttr "HIKState2SK1.LeftUpLegSx" "LeftUpLeg.sx";
connectAttr "HIKState2SK1.LeftUpLegSy" "LeftUpLeg.sy";
connectAttr "HIKState2SK1.LeftUpLegSz" "LeftUpLeg.sz";
connectAttr "HIKState2SK1.LeftUpLegTx" "LeftUpLeg.tx";
connectAttr "HIKState2SK1.LeftUpLegTy" "LeftUpLeg.ty";
connectAttr "HIKState2SK1.LeftUpLegTz" "LeftUpLeg.tz";
connectAttr "HIKState2SK1.LeftUpLegRx" "LeftUpLeg.rx";
connectAttr "HIKState2SK1.LeftUpLegRy" "LeftUpLeg.ry";
connectAttr "HIKState2SK1.LeftUpLegRz" "LeftUpLeg.rz";
connectAttr "LeftUpLeg.s" "LeftLeg.is";
connectAttr "HIKState2SK1.LeftLegSx" "LeftLeg.sx";
connectAttr "HIKState2SK1.LeftLegSy" "LeftLeg.sy";
connectAttr "HIKState2SK1.LeftLegSz" "LeftLeg.sz";
connectAttr "HIKState2SK1.LeftLegTx" "LeftLeg.tx";
connectAttr "HIKState2SK1.LeftLegTy" "LeftLeg.ty";
connectAttr "HIKState2SK1.LeftLegTz" "LeftLeg.tz";
connectAttr "HIKState2SK1.LeftLegRx" "LeftLeg.rx";
connectAttr "HIKState2SK1.LeftLegRy" "LeftLeg.ry";
connectAttr "HIKState2SK1.LeftLegRz" "LeftLeg.rz";
connectAttr "LeftLeg.s" "LeftFoot.is";
connectAttr "HIKState2SK1.LeftFootSx" "LeftFoot.sx";
connectAttr "HIKState2SK1.LeftFootSy" "LeftFoot.sy";
connectAttr "HIKState2SK1.LeftFootSz" "LeftFoot.sz";
connectAttr "HIKState2SK1.LeftFootTx" "LeftFoot.tx";
connectAttr "HIKState2SK1.LeftFootTy" "LeftFoot.ty";
connectAttr "HIKState2SK1.LeftFootTz" "LeftFoot.tz";
connectAttr "HIKState2SK1.LeftFootRx" "LeftFoot.rx";
connectAttr "HIKState2SK1.LeftFootRy" "LeftFoot.ry";
connectAttr "HIKState2SK1.LeftFootRz" "LeftFoot.rz";
connectAttr "LeftFoot.s" "LeftToeBase.is";
connectAttr "HIKState2SK1.LeftToeBaseTx" "LeftToeBase.tx";
connectAttr "HIKState2SK1.LeftToeBaseTy" "LeftToeBase.ty";
connectAttr "HIKState2SK1.LeftToeBaseTz" "LeftToeBase.tz";
connectAttr "HIKState2SK1.LeftToeBaseRx" "LeftToeBase.rx";
connectAttr "HIKState2SK1.LeftToeBaseRy" "LeftToeBase.ry";
connectAttr "HIKState2SK1.LeftToeBaseRz" "LeftToeBase.rz";
connectAttr "HIKState2SK1.LeftToeBaseSx" "LeftToeBase.sx";
connectAttr "HIKState2SK1.LeftToeBaseSy" "LeftToeBase.sy";
connectAttr "HIKState2SK1.LeftToeBaseSz" "LeftToeBase.sz";
connectAttr "Hips.s" "RightUpLeg.is";
connectAttr "HIKState2SK1.RightUpLegSx" "RightUpLeg.sx";
connectAttr "HIKState2SK1.RightUpLegSy" "RightUpLeg.sy";
connectAttr "HIKState2SK1.RightUpLegSz" "RightUpLeg.sz";
connectAttr "HIKState2SK1.RightUpLegTx" "RightUpLeg.tx";
connectAttr "HIKState2SK1.RightUpLegTy" "RightUpLeg.ty";
connectAttr "HIKState2SK1.RightUpLegTz" "RightUpLeg.tz";
connectAttr "HIKState2SK1.RightUpLegRx" "RightUpLeg.rx";
connectAttr "HIKState2SK1.RightUpLegRy" "RightUpLeg.ry";
connectAttr "HIKState2SK1.RightUpLegRz" "RightUpLeg.rz";
connectAttr "RightUpLeg.s" "RightLeg.is";
connectAttr "HIKState2SK1.RightLegSx" "RightLeg.sx";
connectAttr "HIKState2SK1.RightLegSy" "RightLeg.sy";
connectAttr "HIKState2SK1.RightLegSz" "RightLeg.sz";
connectAttr "HIKState2SK1.RightLegTx" "RightLeg.tx";
connectAttr "HIKState2SK1.RightLegTy" "RightLeg.ty";
connectAttr "HIKState2SK1.RightLegTz" "RightLeg.tz";
connectAttr "HIKState2SK1.RightLegRx" "RightLeg.rx";
connectAttr "HIKState2SK1.RightLegRy" "RightLeg.ry";
connectAttr "HIKState2SK1.RightLegRz" "RightLeg.rz";
connectAttr "RightLeg.s" "RightFoot.is";
connectAttr "HIKState2SK1.RightFootSx" "RightFoot.sx";
connectAttr "HIKState2SK1.RightFootSy" "RightFoot.sy";
connectAttr "HIKState2SK1.RightFootSz" "RightFoot.sz";
connectAttr "HIKState2SK1.RightFootTx" "RightFoot.tx";
connectAttr "HIKState2SK1.RightFootTy" "RightFoot.ty";
connectAttr "HIKState2SK1.RightFootTz" "RightFoot.tz";
connectAttr "HIKState2SK1.RightFootRx" "RightFoot.rx";
connectAttr "HIKState2SK1.RightFootRy" "RightFoot.ry";
connectAttr "HIKState2SK1.RightFootRz" "RightFoot.rz";
connectAttr "RightFoot.s" "RightToeBase.is";
connectAttr "HIKState2SK1.RightToeBaseTx" "RightToeBase.tx";
connectAttr "HIKState2SK1.RightToeBaseTy" "RightToeBase.ty";
connectAttr "HIKState2SK1.RightToeBaseTz" "RightToeBase.tz";
connectAttr "HIKState2SK1.RightToeBaseRx" "RightToeBase.rx";
connectAttr "HIKState2SK1.RightToeBaseRy" "RightToeBase.ry";
connectAttr "HIKState2SK1.RightToeBaseRz" "RightToeBase.rz";
connectAttr "HIKState2SK1.RightToeBaseSx" "RightToeBase.sx";
connectAttr "HIKState2SK1.RightToeBaseSy" "RightToeBase.sy";
connectAttr "HIKState2SK1.RightToeBaseSz" "RightToeBase.sz";
connectAttr "Hips.s" "Spine.is";
connectAttr "HIKState2SK1.SpineSx" "Spine.sx";
connectAttr "HIKState2SK1.SpineSy" "Spine.sy";
connectAttr "HIKState2SK1.SpineSz" "Spine.sz";
connectAttr "HIKState2SK1.SpineTx" "Spine.tx";
connectAttr "HIKState2SK1.SpineTy" "Spine.ty";
connectAttr "HIKState2SK1.SpineTz" "Spine.tz";
connectAttr "HIKState2SK1.SpineRx" "Spine.rx";
connectAttr "HIKState2SK1.SpineRy" "Spine.ry";
connectAttr "HIKState2SK1.SpineRz" "Spine.rz";
connectAttr "Spine.s" "Spine1.is";
connectAttr "HIKState2SK1.Spine1Sx" "Spine1.sx";
connectAttr "HIKState2SK1.Spine1Sy" "Spine1.sy";
connectAttr "HIKState2SK1.Spine1Sz" "Spine1.sz";
connectAttr "HIKState2SK1.Spine1Tx" "Spine1.tx";
connectAttr "HIKState2SK1.Spine1Ty" "Spine1.ty";
connectAttr "HIKState2SK1.Spine1Tz" "Spine1.tz";
connectAttr "HIKState2SK1.Spine1Rx" "Spine1.rx";
connectAttr "HIKState2SK1.Spine1Ry" "Spine1.ry";
connectAttr "HIKState2SK1.Spine1Rz" "Spine1.rz";
connectAttr "Spine1.s" "LeftShoulder.is";
connectAttr "HIKState2SK1.LeftShoulderSx" "LeftShoulder.sx";
connectAttr "HIKState2SK1.LeftShoulderSy" "LeftShoulder.sy";
connectAttr "HIKState2SK1.LeftShoulderSz" "LeftShoulder.sz";
connectAttr "HIKState2SK1.LeftShoulderTx" "LeftShoulder.tx";
connectAttr "HIKState2SK1.LeftShoulderTy" "LeftShoulder.ty";
connectAttr "HIKState2SK1.LeftShoulderTz" "LeftShoulder.tz";
connectAttr "HIKState2SK1.LeftShoulderRx" "LeftShoulder.rx";
connectAttr "HIKState2SK1.LeftShoulderRy" "LeftShoulder.ry";
connectAttr "HIKState2SK1.LeftShoulderRz" "LeftShoulder.rz";
connectAttr "LeftShoulder.s" "LeftArm.is";
connectAttr "HIKState2SK1.LeftArmSx" "LeftArm.sx";
connectAttr "HIKState2SK1.LeftArmSy" "LeftArm.sy";
connectAttr "HIKState2SK1.LeftArmSz" "LeftArm.sz";
connectAttr "HIKState2SK1.LeftArmTx" "LeftArm.tx";
connectAttr "HIKState2SK1.LeftArmTy" "LeftArm.ty";
connectAttr "HIKState2SK1.LeftArmTz" "LeftArm.tz";
connectAttr "HIKState2SK1.LeftArmRx" "LeftArm.rx";
connectAttr "HIKState2SK1.LeftArmRy" "LeftArm.ry";
connectAttr "HIKState2SK1.LeftArmRz" "LeftArm.rz";
connectAttr "LeftArm.s" "LeftForeArm.is";
connectAttr "HIKState2SK1.LeftForeArmSx" "LeftForeArm.sx";
connectAttr "HIKState2SK1.LeftForeArmSy" "LeftForeArm.sy";
connectAttr "HIKState2SK1.LeftForeArmSz" "LeftForeArm.sz";
connectAttr "HIKState2SK1.LeftForeArmTx" "LeftForeArm.tx";
connectAttr "HIKState2SK1.LeftForeArmTy" "LeftForeArm.ty";
connectAttr "HIKState2SK1.LeftForeArmTz" "LeftForeArm.tz";
connectAttr "HIKState2SK1.LeftForeArmRx" "LeftForeArm.rx";
connectAttr "HIKState2SK1.LeftForeArmRy" "LeftForeArm.ry";
connectAttr "HIKState2SK1.LeftForeArmRz" "LeftForeArm.rz";
connectAttr "LeftForeArm.s" "LeftHand.is";
connectAttr "HIKState2SK1.LeftHandSx" "LeftHand.sx";
connectAttr "HIKState2SK1.LeftHandSy" "LeftHand.sy";
connectAttr "HIKState2SK1.LeftHandSz" "LeftHand.sz";
connectAttr "HIKState2SK1.LeftHandTx" "LeftHand.tx";
connectAttr "HIKState2SK1.LeftHandTy" "LeftHand.ty";
connectAttr "HIKState2SK1.LeftHandTz" "LeftHand.tz";
connectAttr "HIKState2SK1.LeftHandRx" "LeftHand.rx";
connectAttr "HIKState2SK1.LeftHandRy" "LeftHand.ry";
connectAttr "HIKState2SK1.LeftHandRz" "LeftHand.rz";
connectAttr "Spine1.s" "RightShoulder.is";
connectAttr "HIKState2SK1.RightShoulderSx" "RightShoulder.sx";
connectAttr "HIKState2SK1.RightShoulderSy" "RightShoulder.sy";
connectAttr "HIKState2SK1.RightShoulderSz" "RightShoulder.sz";
connectAttr "HIKState2SK1.RightShoulderTx" "RightShoulder.tx";
connectAttr "HIKState2SK1.RightShoulderTy" "RightShoulder.ty";
connectAttr "HIKState2SK1.RightShoulderTz" "RightShoulder.tz";
connectAttr "HIKState2SK1.RightShoulderRx" "RightShoulder.rx";
connectAttr "HIKState2SK1.RightShoulderRy" "RightShoulder.ry";
connectAttr "HIKState2SK1.RightShoulderRz" "RightShoulder.rz";
connectAttr "RightShoulder.s" "RightArm.is";
connectAttr "HIKState2SK1.RightArmSx" "RightArm.sx";
connectAttr "HIKState2SK1.RightArmSy" "RightArm.sy";
connectAttr "HIKState2SK1.RightArmSz" "RightArm.sz";
connectAttr "HIKState2SK1.RightArmTx" "RightArm.tx";
connectAttr "HIKState2SK1.RightArmTy" "RightArm.ty";
connectAttr "HIKState2SK1.RightArmTz" "RightArm.tz";
connectAttr "HIKState2SK1.RightArmRx" "RightArm.rx";
connectAttr "HIKState2SK1.RightArmRy" "RightArm.ry";
connectAttr "HIKState2SK1.RightArmRz" "RightArm.rz";
connectAttr "RightArm.s" "RightForeArm.is";
connectAttr "HIKState2SK1.RightForeArmSx" "RightForeArm.sx";
connectAttr "HIKState2SK1.RightForeArmSy" "RightForeArm.sy";
connectAttr "HIKState2SK1.RightForeArmSz" "RightForeArm.sz";
connectAttr "HIKState2SK1.RightForeArmTx" "RightForeArm.tx";
connectAttr "HIKState2SK1.RightForeArmTy" "RightForeArm.ty";
connectAttr "HIKState2SK1.RightForeArmTz" "RightForeArm.tz";
connectAttr "HIKState2SK1.RightForeArmRx" "RightForeArm.rx";
connectAttr "HIKState2SK1.RightForeArmRy" "RightForeArm.ry";
connectAttr "HIKState2SK1.RightForeArmRz" "RightForeArm.rz";
connectAttr "RightForeArm.s" "RightHand.is";
connectAttr "HIKState2SK1.RightHandSx" "RightHand.sx";
connectAttr "HIKState2SK1.RightHandSy" "RightHand.sy";
connectAttr "HIKState2SK1.RightHandSz" "RightHand.sz";
connectAttr "HIKState2SK1.RightHandTx" "RightHand.tx";
connectAttr "HIKState2SK1.RightHandTy" "RightHand.ty";
connectAttr "HIKState2SK1.RightHandTz" "RightHand.tz";
connectAttr "HIKState2SK1.RightHandRx" "RightHand.rx";
connectAttr "HIKState2SK1.RightHandRy" "RightHand.ry";
connectAttr "HIKState2SK1.RightHandRz" "RightHand.rz";
connectAttr "Spine1.s" "Neck.is";
connectAttr "HIKState2SK1.NeckSx" "Neck.sx";
connectAttr "HIKState2SK1.NeckSy" "Neck.sy";
connectAttr "HIKState2SK1.NeckSz" "Neck.sz";
connectAttr "HIKState2SK1.NeckTx" "Neck.tx";
connectAttr "HIKState2SK1.NeckTy" "Neck.ty";
connectAttr "HIKState2SK1.NeckTz" "Neck.tz";
connectAttr "HIKState2SK1.NeckRx" "Neck.rx";
connectAttr "HIKState2SK1.NeckRy" "Neck.ry";
connectAttr "HIKState2SK1.NeckRz" "Neck.rz";
connectAttr "Neck.s" "Head.is";
connectAttr "HIKState2SK1.HeadTx" "Head.tx";
connectAttr "HIKState2SK1.HeadTy" "Head.ty";
connectAttr "HIKState2SK1.HeadTz" "Head.tz";
connectAttr "HIKState2SK1.HeadRx" "Head.rx";
connectAttr "HIKState2SK1.HeadRy" "Head.ry";
connectAttr "HIKState2SK1.HeadRz" "Head.rz";
connectAttr "HIKState2SK1.HeadSx" "Head.sx";
connectAttr "HIKState2SK1.HeadSy" "Head.sy";
connectAttr "HIKState2SK1.HeadSz" "Head.sz";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_HipsEffector.uagx";
connectAttr "Character1_Ctrl_HipsEffector_rotateZ.o" "Character1_Ctrl_HipsEffector.rz"
		;
connectAttr "Character1_Ctrl_HipsEffector_rotateY.o" "Character1_Ctrl_HipsEffector.ry"
		;
connectAttr "Character1_Ctrl_HipsEffector_rotateX.o" "Character1_Ctrl_HipsEffector.rx"
		;
connectAttr "Character1_Ctrl_HipsEffector_translateZ.o" "Character1_Ctrl_HipsEffector.tz"
		;
connectAttr "Character1_Ctrl_HipsEffector_translateY.o" "Character1_Ctrl_HipsEffector.ty"
		;
connectAttr "Character1_Ctrl_HipsEffector_translateX.o" "Character1_Ctrl_HipsEffector.tx"
		;
connectAttr "HIKState2Effector1.HipsEffectorGXM[0]" "Character1_Ctrl_HipsEffector.agx"
		;
connectAttr "HIKState2Effector2.HipsEffectorGXM[0]" "Character1_Ctrl_HipsEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftAnkleEffector.uagx"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector_rotateZ.o" "Character1_Ctrl_LeftAnkleEffector.rz"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector_rotateY.o" "Character1_Ctrl_LeftAnkleEffector.ry"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector_rotateX.o" "Character1_Ctrl_LeftAnkleEffector.rx"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector_translateZ.o" "Character1_Ctrl_LeftAnkleEffector.tz"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector_translateY.o" "Character1_Ctrl_LeftAnkleEffector.ty"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector_translateX.o" "Character1_Ctrl_LeftAnkleEffector.tx"
		;
connectAttr "HIKState2Effector1.LeftAnkleEffectorGXM[0]" "Character1_Ctrl_LeftAnkleEffector.agx"
		;
connectAttr "HIKState2Effector2.LeftAnkleEffectorGXM[0]" "Character1_Ctrl_LeftAnkleEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightAnkleEffector.uagx"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector_rotateZ.o" "Character1_Ctrl_RightAnkleEffector.rz"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector_rotateY.o" "Character1_Ctrl_RightAnkleEffector.ry"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector_rotateX.o" "Character1_Ctrl_RightAnkleEffector.rx"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector_translateZ.o" "Character1_Ctrl_RightAnkleEffector.tz"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector_translateY.o" "Character1_Ctrl_RightAnkleEffector.ty"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector_translateX.o" "Character1_Ctrl_RightAnkleEffector.tx"
		;
connectAttr "HIKState2Effector1.RightAnkleEffectorGXM[0]" "Character1_Ctrl_RightAnkleEffector.agx"
		;
connectAttr "HIKState2Effector2.RightAnkleEffectorGXM[0]" "Character1_Ctrl_RightAnkleEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftWristEffector.uagx"
		;
connectAttr "Character1_Ctrl_LeftWristEffector_rotateZ.o" "Character1_Ctrl_LeftWristEffector.rz"
		;
connectAttr "Character1_Ctrl_LeftWristEffector_rotateY.o" "Character1_Ctrl_LeftWristEffector.ry"
		;
connectAttr "Character1_Ctrl_LeftWristEffector_rotateX.o" "Character1_Ctrl_LeftWristEffector.rx"
		;
connectAttr "Character1_Ctrl_LeftWristEffector_translateZ.o" "Character1_Ctrl_LeftWristEffector.tz"
		;
connectAttr "Character1_Ctrl_LeftWristEffector_translateY.o" "Character1_Ctrl_LeftWristEffector.ty"
		;
connectAttr "Character1_Ctrl_LeftWristEffector_translateX.o" "Character1_Ctrl_LeftWristEffector.tx"
		;
connectAttr "HIKState2Effector1.LeftWristEffectorGXM[0]" "Character1_Ctrl_LeftWristEffector.agx"
		;
connectAttr "HIKState2Effector2.LeftWristEffectorGXM[0]" "Character1_Ctrl_LeftWristEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightWristEffector.uagx"
		;
connectAttr "Character1_Ctrl_RightWristEffector_rotateZ.o" "Character1_Ctrl_RightWristEffector.rz"
		;
connectAttr "Character1_Ctrl_RightWristEffector_rotateY.o" "Character1_Ctrl_RightWristEffector.ry"
		;
connectAttr "Character1_Ctrl_RightWristEffector_rotateX.o" "Character1_Ctrl_RightWristEffector.rx"
		;
connectAttr "Character1_Ctrl_RightWristEffector_translateZ.o" "Character1_Ctrl_RightWristEffector.tz"
		;
connectAttr "Character1_Ctrl_RightWristEffector_translateY.o" "Character1_Ctrl_RightWristEffector.ty"
		;
connectAttr "Character1_Ctrl_RightWristEffector_translateX.o" "Character1_Ctrl_RightWristEffector.tx"
		;
connectAttr "HIKState2Effector1.RightWristEffectorGXM[0]" "Character1_Ctrl_RightWristEffector.agx"
		;
connectAttr "HIKState2Effector2.RightWristEffectorGXM[0]" "Character1_Ctrl_RightWristEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftKneeEffector.uagx";
connectAttr "Character1_Ctrl_LeftKneeEffector_rotateZ.o" "Character1_Ctrl_LeftKneeEffector.rz"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector_rotateY.o" "Character1_Ctrl_LeftKneeEffector.ry"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector_rotateX.o" "Character1_Ctrl_LeftKneeEffector.rx"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector_translateZ.o" "Character1_Ctrl_LeftKneeEffector.tz"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector_translateY.o" "Character1_Ctrl_LeftKneeEffector.ty"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector_translateX.o" "Character1_Ctrl_LeftKneeEffector.tx"
		;
connectAttr "HIKState2Effector1.LeftKneeEffectorGXM[0]" "Character1_Ctrl_LeftKneeEffector.agx"
		;
connectAttr "HIKState2Effector2.LeftKneeEffectorGXM[0]" "Character1_Ctrl_LeftKneeEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightKneeEffector.uagx"
		;
connectAttr "Character1_Ctrl_RightKneeEffector_rotateZ.o" "Character1_Ctrl_RightKneeEffector.rz"
		;
connectAttr "Character1_Ctrl_RightKneeEffector_rotateY.o" "Character1_Ctrl_RightKneeEffector.ry"
		;
connectAttr "Character1_Ctrl_RightKneeEffector_rotateX.o" "Character1_Ctrl_RightKneeEffector.rx"
		;
connectAttr "Character1_Ctrl_RightKneeEffector_translateZ.o" "Character1_Ctrl_RightKneeEffector.tz"
		;
connectAttr "Character1_Ctrl_RightKneeEffector_translateY.o" "Character1_Ctrl_RightKneeEffector.ty"
		;
connectAttr "Character1_Ctrl_RightKneeEffector_translateX.o" "Character1_Ctrl_RightKneeEffector.tx"
		;
connectAttr "HIKState2Effector1.RightKneeEffectorGXM[0]" "Character1_Ctrl_RightKneeEffector.agx"
		;
connectAttr "HIKState2Effector2.RightKneeEffectorGXM[0]" "Character1_Ctrl_RightKneeEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftElbowEffector.uagx"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector_rotateZ.o" "Character1_Ctrl_LeftElbowEffector.rz"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector_rotateY.o" "Character1_Ctrl_LeftElbowEffector.ry"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector_rotateX.o" "Character1_Ctrl_LeftElbowEffector.rx"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector_translateZ.o" "Character1_Ctrl_LeftElbowEffector.tz"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector_translateY.o" "Character1_Ctrl_LeftElbowEffector.ty"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector_translateX.o" "Character1_Ctrl_LeftElbowEffector.tx"
		;
connectAttr "HIKState2Effector1.LeftElbowEffectorGXM[0]" "Character1_Ctrl_LeftElbowEffector.agx"
		;
connectAttr "HIKState2Effector2.LeftElbowEffectorGXM[0]" "Character1_Ctrl_LeftElbowEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightElbowEffector.uagx"
		;
connectAttr "Character1_Ctrl_RightElbowEffector_rotateZ.o" "Character1_Ctrl_RightElbowEffector.rz"
		;
connectAttr "Character1_Ctrl_RightElbowEffector_rotateY.o" "Character1_Ctrl_RightElbowEffector.ry"
		;
connectAttr "Character1_Ctrl_RightElbowEffector_rotateX.o" "Character1_Ctrl_RightElbowEffector.rx"
		;
connectAttr "Character1_Ctrl_RightElbowEffector_translateZ.o" "Character1_Ctrl_RightElbowEffector.tz"
		;
connectAttr "Character1_Ctrl_RightElbowEffector_translateY.o" "Character1_Ctrl_RightElbowEffector.ty"
		;
connectAttr "Character1_Ctrl_RightElbowEffector_translateX.o" "Character1_Ctrl_RightElbowEffector.tx"
		;
connectAttr "HIKState2Effector1.RightElbowEffectorGXM[0]" "Character1_Ctrl_RightElbowEffector.agx"
		;
connectAttr "HIKState2Effector2.RightElbowEffectorGXM[0]" "Character1_Ctrl_RightElbowEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_ChestOriginEffector.uagx"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector_rotateZ.o" "Character1_Ctrl_ChestOriginEffector.rz"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector_rotateY.o" "Character1_Ctrl_ChestOriginEffector.ry"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector_rotateX.o" "Character1_Ctrl_ChestOriginEffector.rx"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector_translateZ.o" "Character1_Ctrl_ChestOriginEffector.tz"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector_translateY.o" "Character1_Ctrl_ChestOriginEffector.ty"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector_translateX.o" "Character1_Ctrl_ChestOriginEffector.tx"
		;
connectAttr "HIKState2Effector1.ChestOriginEffectorGXM[0]" "Character1_Ctrl_ChestOriginEffector.agx"
		;
connectAttr "HIKState2Effector2.ChestOriginEffectorGXM[0]" "Character1_Ctrl_ChestOriginEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_ChestEndEffector.uagx";
connectAttr "Character1_Ctrl_ChestEndEffector_rotateZ.o" "Character1_Ctrl_ChestEndEffector.rz"
		;
connectAttr "Character1_Ctrl_ChestEndEffector_rotateY.o" "Character1_Ctrl_ChestEndEffector.ry"
		;
connectAttr "Character1_Ctrl_ChestEndEffector_rotateX.o" "Character1_Ctrl_ChestEndEffector.rx"
		;
connectAttr "Character1_Ctrl_ChestEndEffector_translateZ.o" "Character1_Ctrl_ChestEndEffector.tz"
		;
connectAttr "Character1_Ctrl_ChestEndEffector_translateY.o" "Character1_Ctrl_ChestEndEffector.ty"
		;
connectAttr "Character1_Ctrl_ChestEndEffector_translateX.o" "Character1_Ctrl_ChestEndEffector.tx"
		;
connectAttr "HIKState2Effector1.ChestEndEffectorGXM[0]" "Character1_Ctrl_ChestEndEffector.agx"
		;
connectAttr "HIKState2Effector2.ChestEndEffectorGXM[0]" "Character1_Ctrl_ChestEndEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftFootEffector.uagx";
connectAttr "Character1_Ctrl_LeftFootEffector_rotateZ.o" "Character1_Ctrl_LeftFootEffector.rz"
		;
connectAttr "Character1_Ctrl_LeftFootEffector_rotateY.o" "Character1_Ctrl_LeftFootEffector.ry"
		;
connectAttr "Character1_Ctrl_LeftFootEffector_rotateX.o" "Character1_Ctrl_LeftFootEffector.rx"
		;
connectAttr "Character1_Ctrl_LeftFootEffector_translateZ.o" "Character1_Ctrl_LeftFootEffector.tz"
		;
connectAttr "Character1_Ctrl_LeftFootEffector_translateY.o" "Character1_Ctrl_LeftFootEffector.ty"
		;
connectAttr "Character1_Ctrl_LeftFootEffector_translateX.o" "Character1_Ctrl_LeftFootEffector.tx"
		;
connectAttr "HIKState2Effector1.LeftFootEffectorGXM[0]" "Character1_Ctrl_LeftFootEffector.agx"
		;
connectAttr "HIKState2Effector2.LeftFootEffectorGXM[0]" "Character1_Ctrl_LeftFootEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightFootEffector.uagx"
		;
connectAttr "Character1_Ctrl_RightFootEffector_rotateZ.o" "Character1_Ctrl_RightFootEffector.rz"
		;
connectAttr "Character1_Ctrl_RightFootEffector_rotateY.o" "Character1_Ctrl_RightFootEffector.ry"
		;
connectAttr "Character1_Ctrl_RightFootEffector_rotateX.o" "Character1_Ctrl_RightFootEffector.rx"
		;
connectAttr "Character1_Ctrl_RightFootEffector_translateZ.o" "Character1_Ctrl_RightFootEffector.tz"
		;
connectAttr "Character1_Ctrl_RightFootEffector_translateY.o" "Character1_Ctrl_RightFootEffector.ty"
		;
connectAttr "Character1_Ctrl_RightFootEffector_translateX.o" "Character1_Ctrl_RightFootEffector.tx"
		;
connectAttr "HIKState2Effector1.RightFootEffectorGXM[0]" "Character1_Ctrl_RightFootEffector.agx"
		;
connectAttr "HIKState2Effector2.RightFootEffectorGXM[0]" "Character1_Ctrl_RightFootEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftShoulderEffector.uagx"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector_rotateZ.o" "Character1_Ctrl_LeftShoulderEffector.rz"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector_rotateY.o" "Character1_Ctrl_LeftShoulderEffector.ry"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector_rotateX.o" "Character1_Ctrl_LeftShoulderEffector.rx"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector_translateZ.o" "Character1_Ctrl_LeftShoulderEffector.tz"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector_translateY.o" "Character1_Ctrl_LeftShoulderEffector.ty"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector_translateX.o" "Character1_Ctrl_LeftShoulderEffector.tx"
		;
connectAttr "HIKState2Effector1.LeftShoulderEffectorGXM[0]" "Character1_Ctrl_LeftShoulderEffector.agx"
		;
connectAttr "HIKState2Effector2.LeftShoulderEffectorGXM[0]" "Character1_Ctrl_LeftShoulderEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightShoulderEffector.uagx"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector_rotateZ.o" "Character1_Ctrl_RightShoulderEffector.rz"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector_rotateY.o" "Character1_Ctrl_RightShoulderEffector.ry"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector_rotateX.o" "Character1_Ctrl_RightShoulderEffector.rx"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector_translateZ.o" "Character1_Ctrl_RightShoulderEffector.tz"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector_translateY.o" "Character1_Ctrl_RightShoulderEffector.ty"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector_translateX.o" "Character1_Ctrl_RightShoulderEffector.tx"
		;
connectAttr "HIKState2Effector1.RightShoulderEffectorGXM[0]" "Character1_Ctrl_RightShoulderEffector.agx"
		;
connectAttr "HIKState2Effector2.RightShoulderEffectorGXM[0]" "Character1_Ctrl_RightShoulderEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_HeadEffector.uagx";
connectAttr "Character1_Ctrl_HeadEffector_rotateZ.o" "Character1_Ctrl_HeadEffector.rz"
		;
connectAttr "Character1_Ctrl_HeadEffector_rotateY.o" "Character1_Ctrl_HeadEffector.ry"
		;
connectAttr "Character1_Ctrl_HeadEffector_rotateX.o" "Character1_Ctrl_HeadEffector.rx"
		;
connectAttr "Character1_Ctrl_HeadEffector_translateZ.o" "Character1_Ctrl_HeadEffector.tz"
		;
connectAttr "Character1_Ctrl_HeadEffector_translateY.o" "Character1_Ctrl_HeadEffector.ty"
		;
connectAttr "Character1_Ctrl_HeadEffector_translateX.o" "Character1_Ctrl_HeadEffector.tx"
		;
connectAttr "HIKState2Effector1.HeadEffectorGXM[0]" "Character1_Ctrl_HeadEffector.agx"
		;
connectAttr "HIKState2Effector2.HeadEffectorGXM[0]" "Character1_Ctrl_HeadEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftHipEffector.uagx";
connectAttr "Character1_Ctrl_LeftHipEffector_rotateZ.o" "Character1_Ctrl_LeftHipEffector.rz"
		;
connectAttr "Character1_Ctrl_LeftHipEffector_rotateY.o" "Character1_Ctrl_LeftHipEffector.ry"
		;
connectAttr "Character1_Ctrl_LeftHipEffector_rotateX.o" "Character1_Ctrl_LeftHipEffector.rx"
		;
connectAttr "Character1_Ctrl_LeftHipEffector_translateZ.o" "Character1_Ctrl_LeftHipEffector.tz"
		;
connectAttr "Character1_Ctrl_LeftHipEffector_translateY.o" "Character1_Ctrl_LeftHipEffector.ty"
		;
connectAttr "Character1_Ctrl_LeftHipEffector_translateX.o" "Character1_Ctrl_LeftHipEffector.tx"
		;
connectAttr "HIKState2Effector1.LeftHipEffectorGXM[0]" "Character1_Ctrl_LeftHipEffector.agx"
		;
connectAttr "HIKState2Effector2.LeftHipEffectorGXM[0]" "Character1_Ctrl_LeftHipEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightHipEffector.uagx";
connectAttr "Character1_Ctrl_RightHipEffector_rotateZ.o" "Character1_Ctrl_RightHipEffector.rz"
		;
connectAttr "Character1_Ctrl_RightHipEffector_rotateY.o" "Character1_Ctrl_RightHipEffector.ry"
		;
connectAttr "Character1_Ctrl_RightHipEffector_rotateX.o" "Character1_Ctrl_RightHipEffector.rx"
		;
connectAttr "Character1_Ctrl_RightHipEffector_translateZ.o" "Character1_Ctrl_RightHipEffector.tz"
		;
connectAttr "Character1_Ctrl_RightHipEffector_translateY.o" "Character1_Ctrl_RightHipEffector.ty"
		;
connectAttr "Character1_Ctrl_RightHipEffector_translateX.o" "Character1_Ctrl_RightHipEffector.tx"
		;
connectAttr "HIKState2Effector1.RightHipEffectorGXM[0]" "Character1_Ctrl_RightHipEffector.agx"
		;
connectAttr "HIKState2Effector2.RightHipEffectorGXM[0]" "Character1_Ctrl_RightHipEffector.atx"
		;
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_Hips.uagx";
connectAttr "Character1_Ctrl_Hips_rotateZ.o" "Character1_Ctrl_Hips.rz";
connectAttr "Character1_Ctrl_Hips_rotateY.o" "Character1_Ctrl_Hips.ry";
connectAttr "Character1_Ctrl_Hips_rotateX.o" "Character1_Ctrl_Hips.rx";
connectAttr "Character1_Ctrl_Hips_translateZ.o" "Character1_Ctrl_Hips.tz";
connectAttr "Character1_Ctrl_Hips_translateY.o" "Character1_Ctrl_Hips.ty";
connectAttr "Character1_Ctrl_Hips_translateX.o" "Character1_Ctrl_Hips.tx";
connectAttr "HIKState2FK1.HipsGX" "Character1_Ctrl_Hips.agx";
connectAttr "HIKState2FK2.HipsGX" "Character1_Ctrl_Hips.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftUpLeg.uagx";
connectAttr "Character1_Ctrl_LeftUpLeg_rotateZ.o" "Character1_Ctrl_LeftUpLeg.rz"
		;
connectAttr "Character1_Ctrl_LeftUpLeg_rotateY.o" "Character1_Ctrl_LeftUpLeg.ry"
		;
connectAttr "Character1_Ctrl_LeftUpLeg_rotateX.o" "Character1_Ctrl_LeftUpLeg.rx"
		;
connectAttr "Character1_Ctrl_Hips.s" "Character1_Ctrl_LeftUpLeg.is";
connectAttr "HIKState2FK1.LeftUpLegGX" "Character1_Ctrl_LeftUpLeg.agx";
connectAttr "HIKState2FK2.LeftUpLegGX" "Character1_Ctrl_LeftUpLeg.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftLeg.uagx";
connectAttr "Character1_Ctrl_LeftLeg_rotateZ.o" "Character1_Ctrl_LeftLeg.rz";
connectAttr "Character1_Ctrl_LeftLeg_rotateY.o" "Character1_Ctrl_LeftLeg.ry";
connectAttr "Character1_Ctrl_LeftLeg_rotateX.o" "Character1_Ctrl_LeftLeg.rx";
connectAttr "Character1_Ctrl_LeftUpLeg.s" "Character1_Ctrl_LeftLeg.is";
connectAttr "HIKState2FK1.LeftLegGX" "Character1_Ctrl_LeftLeg.agx";
connectAttr "HIKState2FK2.LeftLegGX" "Character1_Ctrl_LeftLeg.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftFoot.uagx";
connectAttr "Character1_Ctrl_LeftFoot_rotateZ.o" "Character1_Ctrl_LeftFoot.rz";
connectAttr "Character1_Ctrl_LeftFoot_rotateY.o" "Character1_Ctrl_LeftFoot.ry";
connectAttr "Character1_Ctrl_LeftFoot_rotateX.o" "Character1_Ctrl_LeftFoot.rx";
connectAttr "Character1_Ctrl_LeftLeg.s" "Character1_Ctrl_LeftFoot.is";
connectAttr "HIKState2FK1.LeftFootGX" "Character1_Ctrl_LeftFoot.agx";
connectAttr "HIKState2FK2.LeftFootGX" "Character1_Ctrl_LeftFoot.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftToeBase.uagx";
connectAttr "Character1_Ctrl_LeftToeBase_rotateZ.o" "Character1_Ctrl_LeftToeBase.rz"
		;
connectAttr "Character1_Ctrl_LeftToeBase_rotateY.o" "Character1_Ctrl_LeftToeBase.ry"
		;
connectAttr "Character1_Ctrl_LeftToeBase_rotateX.o" "Character1_Ctrl_LeftToeBase.rx"
		;
connectAttr "Character1_Ctrl_LeftFoot.s" "Character1_Ctrl_LeftToeBase.is";
connectAttr "HIKState2FK1.LeftToeBaseGX" "Character1_Ctrl_LeftToeBase.agx";
connectAttr "HIKState2FK2.LeftToeBaseGX" "Character1_Ctrl_LeftToeBase.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightUpLeg.uagx";
connectAttr "Character1_Ctrl_RightUpLeg_rotateZ.o" "Character1_Ctrl_RightUpLeg.rz"
		;
connectAttr "Character1_Ctrl_RightUpLeg_rotateY.o" "Character1_Ctrl_RightUpLeg.ry"
		;
connectAttr "Character1_Ctrl_RightUpLeg_rotateX.o" "Character1_Ctrl_RightUpLeg.rx"
		;
connectAttr "Character1_Ctrl_Hips.s" "Character1_Ctrl_RightUpLeg.is";
connectAttr "HIKState2FK1.RightUpLegGX" "Character1_Ctrl_RightUpLeg.agx";
connectAttr "HIKState2FK2.RightUpLegGX" "Character1_Ctrl_RightUpLeg.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightLeg.uagx";
connectAttr "Character1_Ctrl_RightLeg_rotateZ.o" "Character1_Ctrl_RightLeg.rz";
connectAttr "Character1_Ctrl_RightLeg_rotateY.o" "Character1_Ctrl_RightLeg.ry";
connectAttr "Character1_Ctrl_RightLeg_rotateX.o" "Character1_Ctrl_RightLeg.rx";
connectAttr "Character1_Ctrl_RightUpLeg.s" "Character1_Ctrl_RightLeg.is";
connectAttr "HIKState2FK1.RightLegGX" "Character1_Ctrl_RightLeg.agx";
connectAttr "HIKState2FK2.RightLegGX" "Character1_Ctrl_RightLeg.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightFoot.uagx";
connectAttr "Character1_Ctrl_RightFoot_rotateZ.o" "Character1_Ctrl_RightFoot.rz"
		;
connectAttr "Character1_Ctrl_RightFoot_rotateY.o" "Character1_Ctrl_RightFoot.ry"
		;
connectAttr "Character1_Ctrl_RightFoot_rotateX.o" "Character1_Ctrl_RightFoot.rx"
		;
connectAttr "Character1_Ctrl_RightLeg.s" "Character1_Ctrl_RightFoot.is";
connectAttr "HIKState2FK1.RightFootGX" "Character1_Ctrl_RightFoot.agx";
connectAttr "HIKState2FK2.RightFootGX" "Character1_Ctrl_RightFoot.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightToeBase.uagx";
connectAttr "Character1_Ctrl_RightToeBase_rotateZ.o" "Character1_Ctrl_RightToeBase.rz"
		;
connectAttr "Character1_Ctrl_RightToeBase_rotateY.o" "Character1_Ctrl_RightToeBase.ry"
		;
connectAttr "Character1_Ctrl_RightToeBase_rotateX.o" "Character1_Ctrl_RightToeBase.rx"
		;
connectAttr "Character1_Ctrl_RightFoot.s" "Character1_Ctrl_RightToeBase.is";
connectAttr "HIKState2FK1.RightToeBaseGX" "Character1_Ctrl_RightToeBase.agx";
connectAttr "HIKState2FK2.RightToeBaseGX" "Character1_Ctrl_RightToeBase.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_Spine.uagx";
connectAttr "Character1_Ctrl_Spine_rotateZ.o" "Character1_Ctrl_Spine.rz";
connectAttr "Character1_Ctrl_Spine_rotateY.o" "Character1_Ctrl_Spine.ry";
connectAttr "Character1_Ctrl_Spine_rotateX.o" "Character1_Ctrl_Spine.rx";
connectAttr "Character1_Ctrl_Hips.s" "Character1_Ctrl_Spine.is";
connectAttr "HIKState2FK1.SpineGX" "Character1_Ctrl_Spine.agx";
connectAttr "HIKState2FK2.SpineGX" "Character1_Ctrl_Spine.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_Spine1.uagx";
connectAttr "Character1_Ctrl_Spine1_rotateZ.o" "Character1_Ctrl_Spine1.rz";
connectAttr "Character1_Ctrl_Spine1_rotateY.o" "Character1_Ctrl_Spine1.ry";
connectAttr "Character1_Ctrl_Spine1_rotateX.o" "Character1_Ctrl_Spine1.rx";
connectAttr "Character1_Ctrl_Spine.s" "Character1_Ctrl_Spine1.is";
connectAttr "HIKState2FK1.Spine1GX" "Character1_Ctrl_Spine1.agx";
connectAttr "HIKState2FK2.Spine1GX" "Character1_Ctrl_Spine1.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftShoulder.uagx";
connectAttr "Character1_Ctrl_LeftShoulder_rotateZ.o" "Character1_Ctrl_LeftShoulder.rz"
		;
connectAttr "Character1_Ctrl_LeftShoulder_rotateY.o" "Character1_Ctrl_LeftShoulder.ry"
		;
connectAttr "Character1_Ctrl_LeftShoulder_rotateX.o" "Character1_Ctrl_LeftShoulder.rx"
		;
connectAttr "Character1_Ctrl_Spine1.s" "Character1_Ctrl_LeftShoulder.is";
connectAttr "HIKState2FK1.LeftShoulderGX" "Character1_Ctrl_LeftShoulder.agx";
connectAttr "HIKState2FK2.LeftShoulderGX" "Character1_Ctrl_LeftShoulder.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftArm.uagx";
connectAttr "Character1_Ctrl_LeftArm_rotateZ.o" "Character1_Ctrl_LeftArm.rz";
connectAttr "Character1_Ctrl_LeftArm_rotateY.o" "Character1_Ctrl_LeftArm.ry";
connectAttr "Character1_Ctrl_LeftArm_rotateX.o" "Character1_Ctrl_LeftArm.rx";
connectAttr "Character1_Ctrl_LeftShoulder.s" "Character1_Ctrl_LeftArm.is";
connectAttr "HIKState2FK1.LeftArmGX" "Character1_Ctrl_LeftArm.agx";
connectAttr "HIKState2FK2.LeftArmGX" "Character1_Ctrl_LeftArm.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftForeArm.uagx";
connectAttr "Character1_Ctrl_LeftForeArm_rotateZ.o" "Character1_Ctrl_LeftForeArm.rz"
		;
connectAttr "Character1_Ctrl_LeftForeArm_rotateY.o" "Character1_Ctrl_LeftForeArm.ry"
		;
connectAttr "Character1_Ctrl_LeftForeArm_rotateX.o" "Character1_Ctrl_LeftForeArm.rx"
		;
connectAttr "Character1_Ctrl_LeftArm.s" "Character1_Ctrl_LeftForeArm.is";
connectAttr "HIKState2FK1.LeftForeArmGX" "Character1_Ctrl_LeftForeArm.agx";
connectAttr "HIKState2FK2.LeftForeArmGX" "Character1_Ctrl_LeftForeArm.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_LeftHand.uagx";
connectAttr "Character1_Ctrl_LeftHand_rotateZ.o" "Character1_Ctrl_LeftHand.rz";
connectAttr "Character1_Ctrl_LeftHand_rotateY.o" "Character1_Ctrl_LeftHand.ry";
connectAttr "Character1_Ctrl_LeftHand_rotateX.o" "Character1_Ctrl_LeftHand.rx";
connectAttr "Character1_Ctrl_LeftForeArm.s" "Character1_Ctrl_LeftHand.is";
connectAttr "HIKState2FK1.LeftHandGX" "Character1_Ctrl_LeftHand.agx";
connectAttr "HIKState2FK2.LeftHandGX" "Character1_Ctrl_LeftHand.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightShoulder.uagx";
connectAttr "Character1_Ctrl_RightShoulder_rotateZ.o" "Character1_Ctrl_RightShoulder.rz"
		;
connectAttr "Character1_Ctrl_RightShoulder_rotateY.o" "Character1_Ctrl_RightShoulder.ry"
		;
connectAttr "Character1_Ctrl_RightShoulder_rotateX.o" "Character1_Ctrl_RightShoulder.rx"
		;
connectAttr "Character1_Ctrl_Spine1.s" "Character1_Ctrl_RightShoulder.is";
connectAttr "HIKState2FK1.RightShoulderGX" "Character1_Ctrl_RightShoulder.agx";
connectAttr "HIKState2FK2.RightShoulderGX" "Character1_Ctrl_RightShoulder.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightArm.uagx";
connectAttr "Character1_Ctrl_RightArm_rotateZ.o" "Character1_Ctrl_RightArm.rz";
connectAttr "Character1_Ctrl_RightArm_rotateY.o" "Character1_Ctrl_RightArm.ry";
connectAttr "Character1_Ctrl_RightArm_rotateX.o" "Character1_Ctrl_RightArm.rx";
connectAttr "Character1_Ctrl_RightShoulder.s" "Character1_Ctrl_RightArm.is";
connectAttr "HIKState2FK1.RightArmGX" "Character1_Ctrl_RightArm.agx";
connectAttr "HIKState2FK2.RightArmGX" "Character1_Ctrl_RightArm.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightForeArm.uagx";
connectAttr "Character1_Ctrl_RightForeArm_rotateZ.o" "Character1_Ctrl_RightForeArm.rz"
		;
connectAttr "Character1_Ctrl_RightForeArm_rotateY.o" "Character1_Ctrl_RightForeArm.ry"
		;
connectAttr "Character1_Ctrl_RightForeArm_rotateX.o" "Character1_Ctrl_RightForeArm.rx"
		;
connectAttr "Character1_Ctrl_RightArm.s" "Character1_Ctrl_RightForeArm.is";
connectAttr "HIKState2FK1.RightForeArmGX" "Character1_Ctrl_RightForeArm.agx";
connectAttr "HIKState2FK2.RightForeArmGX" "Character1_Ctrl_RightForeArm.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_RightHand.uagx";
connectAttr "Character1_Ctrl_RightHand_rotateZ.o" "Character1_Ctrl_RightHand.rz"
		;
connectAttr "Character1_Ctrl_RightHand_rotateY.o" "Character1_Ctrl_RightHand.ry"
		;
connectAttr "Character1_Ctrl_RightHand_rotateX.o" "Character1_Ctrl_RightHand.rx"
		;
connectAttr "Character1_Ctrl_RightForeArm.s" "Character1_Ctrl_RightHand.is";
connectAttr "HIKState2FK1.RightHandGX" "Character1_Ctrl_RightHand.agx";
connectAttr "HIKState2FK2.RightHandGX" "Character1_Ctrl_RightHand.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_Neck.uagx";
connectAttr "Character1_Ctrl_Neck_rotateZ.o" "Character1_Ctrl_Neck.rz";
connectAttr "Character1_Ctrl_Neck_rotateY.o" "Character1_Ctrl_Neck.ry";
connectAttr "Character1_Ctrl_Neck_rotateX.o" "Character1_Ctrl_Neck.rx";
connectAttr "Character1_Ctrl_Spine1.s" "Character1_Ctrl_Neck.is";
connectAttr "HIKState2FK1.NeckGX" "Character1_Ctrl_Neck.agx";
connectAttr "HIKState2FK2.NeckGX" "Character1_Ctrl_Neck.atx";
connectAttr "Character1_ControlRig.rao" "Character1_Ctrl_Head.uagx";
connectAttr "Character1_Ctrl_Head_rotateZ.o" "Character1_Ctrl_Head.rz";
connectAttr "Character1_Ctrl_Head_rotateY.o" "Character1_Ctrl_Head.ry";
connectAttr "Character1_Ctrl_Head_rotateX.o" "Character1_Ctrl_Head.rx";
connectAttr "Character1_Ctrl_Neck.s" "Character1_Ctrl_Head.is";
connectAttr "HIKState2FK1.HeadGX" "Character1_Ctrl_Head.agx";
connectAttr "HIKState2FK2.HeadGX" "Character1_Ctrl_Head.atx";
relationship "link" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "link" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialShadingGroup.message" ":defaultLightSet.message";
relationship "shadowLink" ":lightLinker1" ":initialParticleSE.message" ":defaultLightSet.message";
connectAttr "layerManager.dli[0]" "defaultLayer.id";
connectAttr "renderLayerManager.rlmi[0]" "defaultRenderLayer.rlid";
connectAttr "HIKproperties1.msg" "Character1.propertyState";
connectAttr "HIKSkeletonGeneratorNode1.CharacterNode" "Character1.SkeletonGenerator"
		;
connectAttr "Reference.ch" "Character1.Reference";
connectAttr "Hips.ch" "Character1.Hips";
connectAttr "LeftUpLeg.ch" "Character1.LeftUpLeg";
connectAttr "LeftLeg.ch" "Character1.LeftLeg";
connectAttr "LeftFoot.ch" "Character1.LeftFoot";
connectAttr "RightUpLeg.ch" "Character1.RightUpLeg";
connectAttr "RightLeg.ch" "Character1.RightLeg";
connectAttr "RightFoot.ch" "Character1.RightFoot";
connectAttr "Spine.ch" "Character1.Spine";
connectAttr "LeftArm.ch" "Character1.LeftArm";
connectAttr "LeftForeArm.ch" "Character1.LeftForeArm";
connectAttr "LeftHand.ch" "Character1.LeftHand";
connectAttr "RightArm.ch" "Character1.RightArm";
connectAttr "RightForeArm.ch" "Character1.RightForeArm";
connectAttr "RightHand.ch" "Character1.RightHand";
connectAttr "Head.ch" "Character1.Head";
connectAttr "LeftToeBase.ch" "Character1.LeftToeBase";
connectAttr "RightToeBase.ch" "Character1.RightToeBase";
connectAttr "LeftShoulder.ch" "Character1.LeftShoulder";
connectAttr "RightShoulder.ch" "Character1.RightShoulder";
connectAttr "Neck.ch" "Character1.Neck";
connectAttr "Spine1.ch" "Character1.Spine1";
connectAttr "Character1_Ctrl_HipsEffector.pull" "HIKproperties1.CtrlResistHipsPosition"
		;
connectAttr "Character1_Ctrl_HipsEffector.stiffness" "HIKproperties1.CtrlResistHipsOrientation"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.pull" "HIKproperties1.CtrlPullLeftFoot"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.pull" "HIKproperties1.CtrlPullRightFoot"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.pull" "HIKproperties1.CtrlChestPullLeftHand"
		;
connectAttr "Character1_Ctrl_RightWristEffector.pull" "HIKproperties1.CtrlChestPullRightHand"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.pull" "HIKproperties1.CtrlPullLeftKnee"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.stiffness" "HIKproperties1.CtrlResistLeftKnee"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.pull" "HIKproperties1.CtrlPullRightKnee"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.stiffness" "HIKproperties1.CtrlResistRightKnee"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.pull" "HIKproperties1.CtrlPullLeftElbow"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.stiffness" "HIKproperties1.CtrlResistLeftElbow"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.pull" "HIKproperties1.CtrlPullRightElbow"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.stiffness" "HIKproperties1.CtrlResistRightElbow"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.stiffness" "HIKproperties1.ParamCtrlSpineStiffness"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.pull" "HIKproperties1.CtrlResistChestPosition"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.stiffness" "HIKproperties1.CtrlResistChestOrientation"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.pull" "HIKproperties1.CtrlPullLeftToeBase"
		;
connectAttr "Character1_Ctrl_RightFootEffector.pull" "HIKproperties1.CtrlPullRightToeBase"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.stiffness" "HIKproperties1.CtrlResistLeftCollar"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.stiffness" "HIKproperties1.CtrlResistRightCollar"
		;
connectAttr "Character1_Ctrl_HeadEffector.pull" "HIKproperties1.CtrlPullHead";
connectAttr "Character1_Ctrl_HeadEffector.stiffness" "HIKproperties1.ParamCtrlNeckStiffness"
		;
connectAttr "HIKproperties1.OutputPropertySetState" "HIKSolverNode1.InputPropertySetState"
		;
connectAttr "Character1.OutputCharacterDefinition" "HIKSolverNode1.InputCharacterDefinition"
		;
connectAttr "HIKFK2State1.OutputCharacterState" "HIKSolverNode1.InputCharacterState"
		;
connectAttr "HIKPinning2State1.OutputEffectorState" "HIKSolverNode1.InputEffectorState"
		;
connectAttr "HIKPinning2State1.OutputEffectorStateNoAux" "HIKSolverNode1.InputEffectorStateNoAux"
		;
connectAttr "Character1.OutputCharacterDefinition" "HIKState2SK1.InputCharacterDefinition"
		;
connectAttr "HIKSolverNode1.OutputCharacterState" "HIKState2SK1.InputCharacterState"
		;
connectAttr "Hips.pm" "HIKState2SK1.HipsPGX";
connectAttr "Hips.jo" "HIKState2SK1.HipsPreR";
connectAttr "Hips.ssc" "HIKState2SK1.HipsSC";
connectAttr "Hips.is" "HIKState2SK1.HipsIS";
connectAttr "Hips.ro" "HIKState2SK1.HipsROrder";
connectAttr "Hips.ra" "HIKState2SK1.HipsPostR";
connectAttr "LeftUpLeg.pm" "HIKState2SK1.LeftUpLegPGX";
connectAttr "LeftUpLeg.jo" "HIKState2SK1.LeftUpLegPreR";
connectAttr "LeftUpLeg.ssc" "HIKState2SK1.LeftUpLegSC";
connectAttr "LeftUpLeg.is" "HIKState2SK1.LeftUpLegIS";
connectAttr "LeftUpLeg.ro" "HIKState2SK1.LeftUpLegROrder";
connectAttr "LeftUpLeg.ra" "HIKState2SK1.LeftUpLegPostR";
connectAttr "LeftLeg.pm" "HIKState2SK1.LeftLegPGX";
connectAttr "LeftLeg.jo" "HIKState2SK1.LeftLegPreR";
connectAttr "LeftLeg.ssc" "HIKState2SK1.LeftLegSC";
connectAttr "LeftLeg.is" "HIKState2SK1.LeftLegIS";
connectAttr "LeftLeg.ro" "HIKState2SK1.LeftLegROrder";
connectAttr "LeftLeg.ra" "HIKState2SK1.LeftLegPostR";
connectAttr "LeftFoot.pm" "HIKState2SK1.LeftFootPGX";
connectAttr "LeftFoot.jo" "HIKState2SK1.LeftFootPreR";
connectAttr "LeftFoot.ssc" "HIKState2SK1.LeftFootSC";
connectAttr "LeftFoot.is" "HIKState2SK1.LeftFootIS";
connectAttr "LeftFoot.ro" "HIKState2SK1.LeftFootROrder";
connectAttr "LeftFoot.ra" "HIKState2SK1.LeftFootPostR";
connectAttr "RightUpLeg.pm" "HIKState2SK1.RightUpLegPGX";
connectAttr "RightUpLeg.jo" "HIKState2SK1.RightUpLegPreR";
connectAttr "RightUpLeg.ssc" "HIKState2SK1.RightUpLegSC";
connectAttr "RightUpLeg.is" "HIKState2SK1.RightUpLegIS";
connectAttr "RightUpLeg.ro" "HIKState2SK1.RightUpLegROrder";
connectAttr "RightUpLeg.ra" "HIKState2SK1.RightUpLegPostR";
connectAttr "RightLeg.pm" "HIKState2SK1.RightLegPGX";
connectAttr "RightLeg.jo" "HIKState2SK1.RightLegPreR";
connectAttr "RightLeg.ssc" "HIKState2SK1.RightLegSC";
connectAttr "RightLeg.is" "HIKState2SK1.RightLegIS";
connectAttr "RightLeg.ro" "HIKState2SK1.RightLegROrder";
connectAttr "RightLeg.ra" "HIKState2SK1.RightLegPostR";
connectAttr "RightFoot.pm" "HIKState2SK1.RightFootPGX";
connectAttr "RightFoot.jo" "HIKState2SK1.RightFootPreR";
connectAttr "RightFoot.ssc" "HIKState2SK1.RightFootSC";
connectAttr "RightFoot.is" "HIKState2SK1.RightFootIS";
connectAttr "RightFoot.ro" "HIKState2SK1.RightFootROrder";
connectAttr "RightFoot.ra" "HIKState2SK1.RightFootPostR";
connectAttr "Spine.pm" "HIKState2SK1.SpinePGX";
connectAttr "Spine.jo" "HIKState2SK1.SpinePreR";
connectAttr "Spine.ssc" "HIKState2SK1.SpineSC";
connectAttr "Spine.is" "HIKState2SK1.SpineIS";
connectAttr "Spine.ro" "HIKState2SK1.SpineROrder";
connectAttr "Spine.ra" "HIKState2SK1.SpinePostR";
connectAttr "LeftArm.pm" "HIKState2SK1.LeftArmPGX";
connectAttr "LeftArm.jo" "HIKState2SK1.LeftArmPreR";
connectAttr "LeftArm.ssc" "HIKState2SK1.LeftArmSC";
connectAttr "LeftArm.is" "HIKState2SK1.LeftArmIS";
connectAttr "LeftArm.ro" "HIKState2SK1.LeftArmROrder";
connectAttr "LeftArm.ra" "HIKState2SK1.LeftArmPostR";
connectAttr "LeftForeArm.pm" "HIKState2SK1.LeftForeArmPGX";
connectAttr "LeftForeArm.jo" "HIKState2SK1.LeftForeArmPreR";
connectAttr "LeftForeArm.ssc" "HIKState2SK1.LeftForeArmSC";
connectAttr "LeftForeArm.is" "HIKState2SK1.LeftForeArmIS";
connectAttr "LeftForeArm.ro" "HIKState2SK1.LeftForeArmROrder";
connectAttr "LeftForeArm.ra" "HIKState2SK1.LeftForeArmPostR";
connectAttr "LeftHand.pm" "HIKState2SK1.LeftHandPGX";
connectAttr "LeftHand.jo" "HIKState2SK1.LeftHandPreR";
connectAttr "LeftHand.ssc" "HIKState2SK1.LeftHandSC";
connectAttr "LeftHand.is" "HIKState2SK1.LeftHandIS";
connectAttr "LeftHand.ro" "HIKState2SK1.LeftHandROrder";
connectAttr "LeftHand.ra" "HIKState2SK1.LeftHandPostR";
connectAttr "RightArm.pm" "HIKState2SK1.RightArmPGX";
connectAttr "RightArm.jo" "HIKState2SK1.RightArmPreR";
connectAttr "RightArm.ssc" "HIKState2SK1.RightArmSC";
connectAttr "RightArm.is" "HIKState2SK1.RightArmIS";
connectAttr "RightArm.ro" "HIKState2SK1.RightArmROrder";
connectAttr "RightArm.ra" "HIKState2SK1.RightArmPostR";
connectAttr "RightForeArm.pm" "HIKState2SK1.RightForeArmPGX";
connectAttr "RightForeArm.jo" "HIKState2SK1.RightForeArmPreR";
connectAttr "RightForeArm.ssc" "HIKState2SK1.RightForeArmSC";
connectAttr "RightForeArm.is" "HIKState2SK1.RightForeArmIS";
connectAttr "RightForeArm.ro" "HIKState2SK1.RightForeArmROrder";
connectAttr "RightForeArm.ra" "HIKState2SK1.RightForeArmPostR";
connectAttr "RightHand.pm" "HIKState2SK1.RightHandPGX";
connectAttr "RightHand.jo" "HIKState2SK1.RightHandPreR";
connectAttr "RightHand.ssc" "HIKState2SK1.RightHandSC";
connectAttr "RightHand.is" "HIKState2SK1.RightHandIS";
connectAttr "RightHand.ro" "HIKState2SK1.RightHandROrder";
connectAttr "RightHand.ra" "HIKState2SK1.RightHandPostR";
connectAttr "Head.pm" "HIKState2SK1.HeadPGX";
connectAttr "Head.jo" "HIKState2SK1.HeadPreR";
connectAttr "Head.ssc" "HIKState2SK1.HeadSC";
connectAttr "Head.is" "HIKState2SK1.HeadIS";
connectAttr "Head.ro" "HIKState2SK1.HeadROrder";
connectAttr "Head.ra" "HIKState2SK1.HeadPostR";
connectAttr "LeftToeBase.pm" "HIKState2SK1.LeftToeBasePGX";
connectAttr "LeftToeBase.jo" "HIKState2SK1.LeftToeBasePreR";
connectAttr "LeftToeBase.ssc" "HIKState2SK1.LeftToeBaseSC";
connectAttr "LeftToeBase.is" "HIKState2SK1.LeftToeBaseIS";
connectAttr "LeftToeBase.ro" "HIKState2SK1.LeftToeBaseROrder";
connectAttr "LeftToeBase.ra" "HIKState2SK1.LeftToeBasePostR";
connectAttr "RightToeBase.pm" "HIKState2SK1.RightToeBasePGX";
connectAttr "RightToeBase.jo" "HIKState2SK1.RightToeBasePreR";
connectAttr "RightToeBase.ssc" "HIKState2SK1.RightToeBaseSC";
connectAttr "RightToeBase.is" "HIKState2SK1.RightToeBaseIS";
connectAttr "RightToeBase.ro" "HIKState2SK1.RightToeBaseROrder";
connectAttr "RightToeBase.ra" "HIKState2SK1.RightToeBasePostR";
connectAttr "LeftShoulder.pm" "HIKState2SK1.LeftShoulderPGX";
connectAttr "LeftShoulder.jo" "HIKState2SK1.LeftShoulderPreR";
connectAttr "LeftShoulder.ssc" "HIKState2SK1.LeftShoulderSC";
connectAttr "LeftShoulder.is" "HIKState2SK1.LeftShoulderIS";
connectAttr "LeftShoulder.ro" "HIKState2SK1.LeftShoulderROrder";
connectAttr "LeftShoulder.ra" "HIKState2SK1.LeftShoulderPostR";
connectAttr "RightShoulder.pm" "HIKState2SK1.RightShoulderPGX";
connectAttr "RightShoulder.jo" "HIKState2SK1.RightShoulderPreR";
connectAttr "RightShoulder.ssc" "HIKState2SK1.RightShoulderSC";
connectAttr "RightShoulder.is" "HIKState2SK1.RightShoulderIS";
connectAttr "RightShoulder.ro" "HIKState2SK1.RightShoulderROrder";
connectAttr "RightShoulder.ra" "HIKState2SK1.RightShoulderPostR";
connectAttr "Neck.pm" "HIKState2SK1.NeckPGX";
connectAttr "Neck.jo" "HIKState2SK1.NeckPreR";
connectAttr "Neck.ssc" "HIKState2SK1.NeckSC";
connectAttr "Neck.is" "HIKState2SK1.NeckIS";
connectAttr "Neck.ro" "HIKState2SK1.NeckROrder";
connectAttr "Neck.ra" "HIKState2SK1.NeckPostR";
connectAttr "Spine1.pm" "HIKState2SK1.Spine1PGX";
connectAttr "Spine1.jo" "HIKState2SK1.Spine1PreR";
connectAttr "Spine1.ssc" "HIKState2SK1.Spine1SC";
connectAttr "Spine1.is" "HIKState2SK1.Spine1IS";
connectAttr "Spine1.ro" "HIKState2SK1.Spine1ROrder";
connectAttr "Spine1.ra" "HIKState2SK1.Spine1PostR";
connectAttr "Character1.OutputCharacterDefinition" "Character1_ControlRig.HIC";
connectAttr "Character1_Ctrl_Reference.ch" "Character1_ControlRig.Reference";
connectAttr "Character1_Ctrl_Hips.ch" "Character1_ControlRig.Hips";
connectAttr "Character1_Ctrl_LeftUpLeg.ch" "Character1_ControlRig.LeftUpLeg";
connectAttr "Character1_Ctrl_LeftLeg.ch" "Character1_ControlRig.LeftLeg";
connectAttr "Character1_Ctrl_LeftFoot.ch" "Character1_ControlRig.LeftFoot";
connectAttr "Character1_Ctrl_RightUpLeg.ch" "Character1_ControlRig.RightUpLeg";
connectAttr "Character1_Ctrl_RightLeg.ch" "Character1_ControlRig.RightLeg";
connectAttr "Character1_Ctrl_RightFoot.ch" "Character1_ControlRig.RightFoot";
connectAttr "Character1_Ctrl_Spine.ch" "Character1_ControlRig.Spine";
connectAttr "Character1_Ctrl_LeftArm.ch" "Character1_ControlRig.LeftArm";
connectAttr "Character1_Ctrl_LeftForeArm.ch" "Character1_ControlRig.LeftForeArm"
		;
connectAttr "Character1_Ctrl_LeftHand.ch" "Character1_ControlRig.LeftHand";
connectAttr "Character1_Ctrl_RightArm.ch" "Character1_ControlRig.RightArm";
connectAttr "Character1_Ctrl_RightForeArm.ch" "Character1_ControlRig.RightForeArm"
		;
connectAttr "Character1_Ctrl_RightHand.ch" "Character1_ControlRig.RightHand";
connectAttr "Character1_Ctrl_Head.ch" "Character1_ControlRig.Head";
connectAttr "Character1_Ctrl_LeftToeBase.ch" "Character1_ControlRig.LeftToeBase"
		;
connectAttr "Character1_Ctrl_RightToeBase.ch" "Character1_ControlRig.RightToeBase"
		;
connectAttr "Character1_Ctrl_LeftShoulder.ch" "Character1_ControlRig.LeftShoulder"
		;
connectAttr "Character1_Ctrl_RightShoulder.ch" "Character1_ControlRig.RightShoulder"
		;
connectAttr "Character1_Ctrl_Neck.ch" "Character1_ControlRig.Neck";
connectAttr "Character1_Ctrl_Spine1.ch" "Character1_ControlRig.Spine1";
connectAttr "Character1_Ctrl_HipsEffector.ch" "Character1_ControlRig.HipsEffector[0]"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.ch" "Character1_ControlRig.LeftAnkleEffector[0]"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.ch" "Character1_ControlRig.RightAnkleEffector[0]"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.ch" "Character1_ControlRig.LeftWristEffector[0]"
		;
connectAttr "Character1_Ctrl_RightWristEffector.ch" "Character1_ControlRig.RightWristEffector[0]"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.ch" "Character1_ControlRig.LeftKneeEffector[0]"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.ch" "Character1_ControlRig.RightKneeEffector[0]"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.ch" "Character1_ControlRig.LeftElbowEffector[0]"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.ch" "Character1_ControlRig.RightElbowEffector[0]"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.ch" "Character1_ControlRig.ChestOriginEffector[0]"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.ch" "Character1_ControlRig.ChestEndEffector[0]"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.ch" "Character1_ControlRig.LeftFootEffector[0]"
		;
connectAttr "Character1_Ctrl_RightFootEffector.ch" "Character1_ControlRig.RightFootEffector[0]"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.ch" "Character1_ControlRig.LeftShoulderEffector[0]"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.ch" "Character1_ControlRig.RightShoulderEffector[0]"
		;
connectAttr "Character1_Ctrl_HeadEffector.ch" "Character1_ControlRig.HeadEffector[0]"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.ch" "Character1_ControlRig.LeftHipEffector[0]"
		;
connectAttr "Character1_Ctrl_RightHipEffector.ch" "Character1_ControlRig.RightHipEffector[0]"
		;
connectAttr "HIKproperties1.ra" "Character1_ControlRig.ra";
connectAttr "Character1_HipsBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_ChestBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_LeftArmBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_RightArmBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_LeftLegBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_RightLegBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_HeadBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_LeftHandBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_RightHandBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_LeftFootBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_RightFootBPKG.msg" "Character1_FullBodyKG.dnsm" -na;
connectAttr "Character1_Ctrl_Hips.msg" "Character1_FullBodyKG.act[0]";
connectAttr "Character1_Ctrl_LeftUpLeg.msg" "Character1_FullBodyKG.act[1]";
connectAttr "Character1_Ctrl_LeftLeg.msg" "Character1_FullBodyKG.act[2]";
connectAttr "Character1_Ctrl_LeftFoot.msg" "Character1_FullBodyKG.act[3]";
connectAttr "Character1_Ctrl_RightUpLeg.msg" "Character1_FullBodyKG.act[4]";
connectAttr "Character1_Ctrl_RightLeg.msg" "Character1_FullBodyKG.act[5]";
connectAttr "Character1_Ctrl_RightFoot.msg" "Character1_FullBodyKG.act[6]";
connectAttr "Character1_Ctrl_Spine.msg" "Character1_FullBodyKG.act[7]";
connectAttr "Character1_Ctrl_LeftArm.msg" "Character1_FullBodyKG.act[8]";
connectAttr "Character1_Ctrl_LeftForeArm.msg" "Character1_FullBodyKG.act[9]";
connectAttr "Character1_Ctrl_LeftHand.msg" "Character1_FullBodyKG.act[10]";
connectAttr "Character1_Ctrl_RightArm.msg" "Character1_FullBodyKG.act[11]";
connectAttr "Character1_Ctrl_RightForeArm.msg" "Character1_FullBodyKG.act[12]";
connectAttr "Character1_Ctrl_RightHand.msg" "Character1_FullBodyKG.act[13]";
connectAttr "Character1_Ctrl_Head.msg" "Character1_FullBodyKG.act[14]";
connectAttr "Character1_Ctrl_LeftToeBase.msg" "Character1_FullBodyKG.act[15]";
connectAttr "Character1_Ctrl_RightToeBase.msg" "Character1_FullBodyKG.act[16]";
connectAttr "Character1_Ctrl_LeftShoulder.msg" "Character1_FullBodyKG.act[17]";
connectAttr "Character1_Ctrl_RightShoulder.msg" "Character1_FullBodyKG.act[18]";
connectAttr "Character1_Ctrl_Neck.msg" "Character1_FullBodyKG.act[19]";
connectAttr "Character1_Ctrl_Spine1.msg" "Character1_FullBodyKG.act[20]";
connectAttr "Character1_Ctrl_HipsEffector.msg" "Character1_FullBodyKG.act[21]";
connectAttr "Character1_Ctrl_LeftAnkleEffector.msg" "Character1_FullBodyKG.act[22]"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.msg" "Character1_FullBodyKG.act[23]"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.msg" "Character1_FullBodyKG.act[24]"
		;
connectAttr "Character1_Ctrl_RightWristEffector.msg" "Character1_FullBodyKG.act[25]"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.msg" "Character1_FullBodyKG.act[26]"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.msg" "Character1_FullBodyKG.act[27]"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.msg" "Character1_FullBodyKG.act[28]"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.msg" "Character1_FullBodyKG.act[29]"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.msg" "Character1_FullBodyKG.act[30]"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.msg" "Character1_FullBodyKG.act[31]"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.msg" "Character1_FullBodyKG.act[32]"
		;
connectAttr "Character1_Ctrl_RightFootEffector.msg" "Character1_FullBodyKG.act[33]"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.msg" "Character1_FullBodyKG.act[34]"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.msg" "Character1_FullBodyKG.act[35]"
		;
connectAttr "Character1_Ctrl_HeadEffector.msg" "Character1_FullBodyKG.act[36]";
connectAttr "Character1_Ctrl_LeftHipEffector.msg" "Character1_FullBodyKG.act[37]"
		;
connectAttr "Character1_Ctrl_RightHipEffector.msg" "Character1_FullBodyKG.act[38]"
		;
connectAttr "Character1_Ctrl_Hips.rz" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Hips.ry" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Hips.rx" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Hips.tz" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Hips.ty" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Hips.tx" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HipsEffector.rz" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HipsEffector.ry" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HipsEffector.rx" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HipsEffector.tz" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HipsEffector.ty" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HipsEffector.tx" "Character1_HipsBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Hips.msg" "Character1_HipsBPKG.act[0]";
connectAttr "Character1_Ctrl_HipsEffector.msg" "Character1_HipsBPKG.act[1]";
connectAttr "Character1_Ctrl_Spine.rz" "Character1_ChestBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Spine.ry" "Character1_ChestBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Spine.rx" "Character1_ChestBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Spine1.rz" "Character1_ChestBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Spine1.ry" "Character1_ChestBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Spine1.rx" "Character1_ChestBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_ChestOriginEffector.rz" "Character1_ChestBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_ChestOriginEffector.ry" "Character1_ChestBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_ChestOriginEffector.rx" "Character1_ChestBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_ChestOriginEffector.tz" "Character1_ChestBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_ChestOriginEffector.ty" "Character1_ChestBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_ChestOriginEffector.tx" "Character1_ChestBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_ChestEndEffector.rz" "Character1_ChestBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_ChestEndEffector.ry" "Character1_ChestBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_ChestEndEffector.rx" "Character1_ChestBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_ChestEndEffector.tz" "Character1_ChestBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_ChestEndEffector.ty" "Character1_ChestBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_ChestEndEffector.tx" "Character1_ChestBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_Spine.msg" "Character1_ChestBPKG.act[0]";
connectAttr "Character1_Ctrl_Spine1.msg" "Character1_ChestBPKG.act[1]";
connectAttr "Character1_Ctrl_ChestOriginEffector.msg" "Character1_ChestBPKG.act[2]"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.msg" "Character1_ChestBPKG.act[3]"
		;
connectAttr "Character1_Ctrl_LeftArm.rz" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftArm.ry" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftArm.rx" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftForeArm.rz" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftForeArm.ry" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftForeArm.rx" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftHand.rz" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftHand.ry" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftHand.rx" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftShoulder.rz" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftShoulder.ry" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftShoulder.rx" "Character1_LeftArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftWristEffector.rz" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftWristEffector.ry" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftWristEffector.rx" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftWristEffector.tz" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftWristEffector.ty" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftWristEffector.tx" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftElbowEffector.rz" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftElbowEffector.ry" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftElbowEffector.rx" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftElbowEffector.tz" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftElbowEffector.ty" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftElbowEffector.tx" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftShoulderEffector.rz" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftShoulderEffector.ry" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftShoulderEffector.rx" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftShoulderEffector.tz" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftShoulderEffector.ty" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftShoulderEffector.tx" "Character1_LeftArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftArm.msg" "Character1_LeftArmBPKG.act[0]";
connectAttr "Character1_Ctrl_LeftForeArm.msg" "Character1_LeftArmBPKG.act[1]";
connectAttr "Character1_Ctrl_LeftHand.msg" "Character1_LeftArmBPKG.act[2]";
connectAttr "Character1_Ctrl_LeftShoulder.msg" "Character1_LeftArmBPKG.act[3]";
connectAttr "Character1_Ctrl_LeftWristEffector.msg" "Character1_LeftArmBPKG.act[4]"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.msg" "Character1_LeftArmBPKG.act[5]"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.msg" "Character1_LeftArmBPKG.act[6]"
		;
connectAttr "Character1_Ctrl_RightArm.rz" "Character1_RightArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightArm.ry" "Character1_RightArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightArm.rx" "Character1_RightArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightForeArm.rz" "Character1_RightArmBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_RightForeArm.ry" "Character1_RightArmBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_RightForeArm.rx" "Character1_RightArmBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_RightHand.rz" "Character1_RightArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightHand.ry" "Character1_RightArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightHand.rx" "Character1_RightArmBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightShoulder.rz" "Character1_RightArmBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_RightShoulder.ry" "Character1_RightArmBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_RightShoulder.rx" "Character1_RightArmBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_RightWristEffector.rz" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightWristEffector.ry" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightWristEffector.rx" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightWristEffector.tz" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightWristEffector.ty" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightWristEffector.tx" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightElbowEffector.rz" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightElbowEffector.ry" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightElbowEffector.rx" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightElbowEffector.tz" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightElbowEffector.ty" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightElbowEffector.tx" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightShoulderEffector.rz" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightShoulderEffector.ry" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightShoulderEffector.rx" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightShoulderEffector.tz" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightShoulderEffector.ty" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightShoulderEffector.tx" "Character1_RightArmBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightArm.msg" "Character1_RightArmBPKG.act[0]";
connectAttr "Character1_Ctrl_RightForeArm.msg" "Character1_RightArmBPKG.act[1]";
connectAttr "Character1_Ctrl_RightHand.msg" "Character1_RightArmBPKG.act[2]";
connectAttr "Character1_Ctrl_RightShoulder.msg" "Character1_RightArmBPKG.act[3]"
		;
connectAttr "Character1_Ctrl_RightWristEffector.msg" "Character1_RightArmBPKG.act[4]"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.msg" "Character1_RightArmBPKG.act[5]"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.msg" "Character1_RightArmBPKG.act[6]"
		;
connectAttr "Character1_Ctrl_LeftUpLeg.rz" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftUpLeg.ry" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftUpLeg.rx" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftLeg.rz" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftLeg.ry" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftLeg.rx" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftFoot.rz" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftFoot.ry" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftFoot.rx" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftToeBase.rz" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftToeBase.ry" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftToeBase.rx" "Character1_LeftLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_LeftAnkleEffector.rz" "Character1_LeftLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftAnkleEffector.ry" "Character1_LeftLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftAnkleEffector.rx" "Character1_LeftLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftAnkleEffector.tz" "Character1_LeftLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftAnkleEffector.ty" "Character1_LeftLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftAnkleEffector.tx" "Character1_LeftLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_LeftKneeEffector.rz" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftKneeEffector.ry" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftKneeEffector.rx" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftKneeEffector.tz" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftKneeEffector.ty" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftKneeEffector.tx" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftFootEffector.rz" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftFootEffector.ry" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftFootEffector.rx" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftFootEffector.tz" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftFootEffector.ty" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftFootEffector.tx" "Character1_LeftLegBPKG.dnsm" 
		-na;
connectAttr "Character1_Ctrl_LeftHipEffector.rz" "Character1_LeftLegBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_LeftHipEffector.ry" "Character1_LeftLegBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_LeftHipEffector.rx" "Character1_LeftLegBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_LeftHipEffector.tz" "Character1_LeftLegBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_LeftHipEffector.ty" "Character1_LeftLegBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_LeftHipEffector.tx" "Character1_LeftLegBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_LeftUpLeg.msg" "Character1_LeftLegBPKG.act[0]";
connectAttr "Character1_Ctrl_LeftLeg.msg" "Character1_LeftLegBPKG.act[1]";
connectAttr "Character1_Ctrl_LeftFoot.msg" "Character1_LeftLegBPKG.act[2]";
connectAttr "Character1_Ctrl_LeftToeBase.msg" "Character1_LeftLegBPKG.act[3]";
connectAttr "Character1_Ctrl_LeftAnkleEffector.msg" "Character1_LeftLegBPKG.act[4]"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.msg" "Character1_LeftLegBPKG.act[5]"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.msg" "Character1_LeftLegBPKG.act[6]"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.msg" "Character1_LeftLegBPKG.act[7]"
		;
connectAttr "Character1_Ctrl_RightUpLeg.rz" "Character1_RightLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightUpLeg.ry" "Character1_RightLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightUpLeg.rx" "Character1_RightLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightLeg.rz" "Character1_RightLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightLeg.ry" "Character1_RightLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightLeg.rx" "Character1_RightLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightFoot.rz" "Character1_RightLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightFoot.ry" "Character1_RightLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightFoot.rx" "Character1_RightLegBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_RightToeBase.rz" "Character1_RightLegBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_RightToeBase.ry" "Character1_RightLegBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_RightToeBase.rx" "Character1_RightLegBPKG.dnsm" -na
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.rz" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightAnkleEffector.ry" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightAnkleEffector.rx" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightAnkleEffector.tz" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightAnkleEffector.ty" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightAnkleEffector.tx" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightKneeEffector.rz" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightKneeEffector.ry" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightKneeEffector.rx" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightKneeEffector.tz" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightKneeEffector.ty" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightKneeEffector.tx" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightFootEffector.rz" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightFootEffector.ry" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightFootEffector.rx" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightFootEffector.tz" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightFootEffector.ty" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightFootEffector.tx" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightHipEffector.rz" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightHipEffector.ry" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightHipEffector.rx" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightHipEffector.tz" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightHipEffector.ty" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightHipEffector.tx" "Character1_RightLegBPKG.dnsm"
		 -na;
connectAttr "Character1_Ctrl_RightUpLeg.msg" "Character1_RightLegBPKG.act[0]";
connectAttr "Character1_Ctrl_RightLeg.msg" "Character1_RightLegBPKG.act[1]";
connectAttr "Character1_Ctrl_RightFoot.msg" "Character1_RightLegBPKG.act[2]";
connectAttr "Character1_Ctrl_RightToeBase.msg" "Character1_RightLegBPKG.act[3]";
connectAttr "Character1_Ctrl_RightAnkleEffector.msg" "Character1_RightLegBPKG.act[4]"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.msg" "Character1_RightLegBPKG.act[5]"
		;
connectAttr "Character1_Ctrl_RightFootEffector.msg" "Character1_RightLegBPKG.act[6]"
		;
connectAttr "Character1_Ctrl_RightHipEffector.msg" "Character1_RightLegBPKG.act[7]"
		;
connectAttr "Character1_Ctrl_Head.rz" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Head.ry" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Head.rx" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Neck.rz" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Neck.ry" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Neck.rx" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HeadEffector.rz" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HeadEffector.ry" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HeadEffector.rx" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HeadEffector.tz" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HeadEffector.ty" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_HeadEffector.tx" "Character1_HeadBPKG.dnsm" -na;
connectAttr "Character1_Ctrl_Head.msg" "Character1_HeadBPKG.act[0]";
connectAttr "Character1_Ctrl_Neck.msg" "Character1_HeadBPKG.act[1]";
connectAttr "Character1_Ctrl_HeadEffector.msg" "Character1_HeadBPKG.act[2]";
connectAttr "Character1.OutputCharacterDefinition" "HIKFK2State1.InputCharacterDefinition"
		;
connectAttr "Character1_Ctrl_Reference.wm" "HIKFK2State1.ReferenceGX";
connectAttr "Character1_Ctrl_Hips.wm" "HIKFK2State1.HipsGX";
connectAttr "Character1_Ctrl_LeftUpLeg.wm" "HIKFK2State1.LeftUpLegGX";
connectAttr "Character1_Ctrl_LeftLeg.wm" "HIKFK2State1.LeftLegGX";
connectAttr "Character1_Ctrl_LeftFoot.wm" "HIKFK2State1.LeftFootGX";
connectAttr "Character1_Ctrl_RightUpLeg.wm" "HIKFK2State1.RightUpLegGX";
connectAttr "Character1_Ctrl_RightLeg.wm" "HIKFK2State1.RightLegGX";
connectAttr "Character1_Ctrl_RightFoot.wm" "HIKFK2State1.RightFootGX";
connectAttr "Character1_Ctrl_Spine.wm" "HIKFK2State1.SpineGX";
connectAttr "Character1_Ctrl_LeftArm.wm" "HIKFK2State1.LeftArmGX";
connectAttr "Character1_Ctrl_LeftForeArm.wm" "HIKFK2State1.LeftForeArmGX";
connectAttr "Character1_Ctrl_LeftHand.wm" "HIKFK2State1.LeftHandGX";
connectAttr "Character1_Ctrl_RightArm.wm" "HIKFK2State1.RightArmGX";
connectAttr "Character1_Ctrl_RightForeArm.wm" "HIKFK2State1.RightForeArmGX";
connectAttr "Character1_Ctrl_RightHand.wm" "HIKFK2State1.RightHandGX";
connectAttr "Character1_Ctrl_Head.wm" "HIKFK2State1.HeadGX";
connectAttr "Character1_Ctrl_LeftToeBase.wm" "HIKFK2State1.LeftToeBaseGX";
connectAttr "Character1_Ctrl_RightToeBase.wm" "HIKFK2State1.RightToeBaseGX";
connectAttr "Character1_Ctrl_LeftShoulder.wm" "HIKFK2State1.LeftShoulderGX";
connectAttr "Character1_Ctrl_RightShoulder.wm" "HIKFK2State1.RightShoulderGX";
connectAttr "Character1_Ctrl_Neck.wm" "HIKFK2State1.NeckGX";
connectAttr "Character1_Ctrl_Spine1.wm" "HIKFK2State1.Spine1GX";
connectAttr "Character1_Ctrl_HipsEffector.wm" "HIKEffector2State1.HipsEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_HipsEffector.rt" "HIKEffector2State1.HipsEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_HipsEffector.rr" "HIKEffector2State1.HipsEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_HipsEffector.po" "HIKEffector2State1.HipsEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_HipsEffector.pull" "HIKEffector2State1.HipsEffectorPull"
		;
connectAttr "Character1_Ctrl_HipsEffector.stiffness" "HIKEffector2State1.HipsEffectorStiffness"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.wm" "HIKEffector2State1.LeftAnkleEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.rt" "HIKEffector2State1.LeftAnkleEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.rr" "HIKEffector2State1.LeftAnkleEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.po" "HIKEffector2State1.LeftAnkleEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.pull" "HIKEffector2State1.LeftAnkleEffectorPull"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.stiffness" "HIKEffector2State1.LeftAnkleEffectorStiffness"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.wm" "HIKEffector2State1.RightAnkleEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.rt" "HIKEffector2State1.RightAnkleEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.rr" "HIKEffector2State1.RightAnkleEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.po" "HIKEffector2State1.RightAnkleEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.pull" "HIKEffector2State1.RightAnkleEffectorPull"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.stiffness" "HIKEffector2State1.RightAnkleEffectorStiffness"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.wm" "HIKEffector2State1.LeftWristEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.rt" "HIKEffector2State1.LeftWristEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.rr" "HIKEffector2State1.LeftWristEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.po" "HIKEffector2State1.LeftWristEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.pull" "HIKEffector2State1.LeftWristEffectorPull"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.stiffness" "HIKEffector2State1.LeftWristEffectorStiffness"
		;
connectAttr "Character1_Ctrl_RightWristEffector.wm" "HIKEffector2State1.RightWristEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_RightWristEffector.rt" "HIKEffector2State1.RightWristEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_RightWristEffector.rr" "HIKEffector2State1.RightWristEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_RightWristEffector.po" "HIKEffector2State1.RightWristEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_RightWristEffector.pull" "HIKEffector2State1.RightWristEffectorPull"
		;
connectAttr "Character1_Ctrl_RightWristEffector.stiffness" "HIKEffector2State1.RightWristEffectorStiffness"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.wm" "HIKEffector2State1.LeftKneeEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.rt" "HIKEffector2State1.LeftKneeEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.rr" "HIKEffector2State1.LeftKneeEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.po" "HIKEffector2State1.LeftKneeEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.pull" "HIKEffector2State1.LeftKneeEffectorPull"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.stiffness" "HIKEffector2State1.LeftKneeEffectorStiffness"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.wm" "HIKEffector2State1.RightKneeEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.rt" "HIKEffector2State1.RightKneeEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.rr" "HIKEffector2State1.RightKneeEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.po" "HIKEffector2State1.RightKneeEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.pull" "HIKEffector2State1.RightKneeEffectorPull"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.stiffness" "HIKEffector2State1.RightKneeEffectorStiffness"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.wm" "HIKEffector2State1.LeftElbowEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.rt" "HIKEffector2State1.LeftElbowEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.rr" "HIKEffector2State1.LeftElbowEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.po" "HIKEffector2State1.LeftElbowEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.pull" "HIKEffector2State1.LeftElbowEffectorPull"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.stiffness" "HIKEffector2State1.LeftElbowEffectorStiffness"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.wm" "HIKEffector2State1.RightElbowEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.rt" "HIKEffector2State1.RightElbowEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.rr" "HIKEffector2State1.RightElbowEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.po" "HIKEffector2State1.RightElbowEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.pull" "HIKEffector2State1.RightElbowEffectorPull"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.stiffness" "HIKEffector2State1.RightElbowEffectorStiffness"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.wm" "HIKEffector2State1.ChestOriginEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.rt" "HIKEffector2State1.ChestOriginEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.rr" "HIKEffector2State1.ChestOriginEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.po" "HIKEffector2State1.ChestOriginEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.pull" "HIKEffector2State1.ChestOriginEffectorPull"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.stiffness" "HIKEffector2State1.ChestOriginEffectorStiffness"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.wm" "HIKEffector2State1.ChestEndEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.rt" "HIKEffector2State1.ChestEndEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.rr" "HIKEffector2State1.ChestEndEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.po" "HIKEffector2State1.ChestEndEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.pull" "HIKEffector2State1.ChestEndEffectorPull"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.stiffness" "HIKEffector2State1.ChestEndEffectorStiffness"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.wm" "HIKEffector2State1.LeftFootEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.rt" "HIKEffector2State1.LeftFootEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.rr" "HIKEffector2State1.LeftFootEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.po" "HIKEffector2State1.LeftFootEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.pull" "HIKEffector2State1.LeftFootEffectorPull"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.stiffness" "HIKEffector2State1.LeftFootEffectorStiffness"
		;
connectAttr "Character1_Ctrl_RightFootEffector.wm" "HIKEffector2State1.RightFootEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_RightFootEffector.rt" "HIKEffector2State1.RightFootEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_RightFootEffector.rr" "HIKEffector2State1.RightFootEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_RightFootEffector.po" "HIKEffector2State1.RightFootEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_RightFootEffector.pull" "HIKEffector2State1.RightFootEffectorPull"
		;
connectAttr "Character1_Ctrl_RightFootEffector.stiffness" "HIKEffector2State1.RightFootEffectorStiffness"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.wm" "HIKEffector2State1.LeftShoulderEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.rt" "HIKEffector2State1.LeftShoulderEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.rr" "HIKEffector2State1.LeftShoulderEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.po" "HIKEffector2State1.LeftShoulderEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.pull" "HIKEffector2State1.LeftShoulderEffectorPull"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.stiffness" "HIKEffector2State1.LeftShoulderEffectorStiffness"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.wm" "HIKEffector2State1.RightShoulderEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.rt" "HIKEffector2State1.RightShoulderEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.rr" "HIKEffector2State1.RightShoulderEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.po" "HIKEffector2State1.RightShoulderEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.pull" "HIKEffector2State1.RightShoulderEffectorPull"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.stiffness" "HIKEffector2State1.RightShoulderEffectorStiffness"
		;
connectAttr "Character1_Ctrl_HeadEffector.wm" "HIKEffector2State1.HeadEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_HeadEffector.rt" "HIKEffector2State1.HeadEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_HeadEffector.rr" "HIKEffector2State1.HeadEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_HeadEffector.po" "HIKEffector2State1.HeadEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_HeadEffector.pull" "HIKEffector2State1.HeadEffectorPull"
		;
connectAttr "Character1_Ctrl_HeadEffector.stiffness" "HIKEffector2State1.HeadEffectorStiffness"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.wm" "HIKEffector2State1.LeftHipEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.rt" "HIKEffector2State1.LeftHipEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.rr" "HIKEffector2State1.LeftHipEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.po" "HIKEffector2State1.LeftHipEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.pull" "HIKEffector2State1.LeftHipEffectorPull"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.stiffness" "HIKEffector2State1.LeftHipEffectorStiffness"
		;
connectAttr "Character1_Ctrl_RightHipEffector.wm" "HIKEffector2State1.RightHipEffectorGX[0]"
		;
connectAttr "Character1_Ctrl_RightHipEffector.rt" "HIKEffector2State1.RightHipEffectorReachT[0]"
		;
connectAttr "Character1_Ctrl_RightHipEffector.rr" "HIKEffector2State1.RightHipEffectorReachR[0]"
		;
connectAttr "Character1_Ctrl_RightHipEffector.po" "HIKEffector2State1.RightHipEffectorPivot[0]"
		;
connectAttr "Character1_Ctrl_RightHipEffector.pull" "HIKEffector2State1.RightHipEffectorPull"
		;
connectAttr "Character1_Ctrl_RightHipEffector.stiffness" "HIKEffector2State1.RightHipEffectorStiffness"
		;
connectAttr "HIKEffector2State1.EFF" "HIKPinning2State1.InputEffectorState";
connectAttr "HIKEffector2State1.EFFNA" "HIKPinning2State1.InputEffectorStateNoAux"
		;
connectAttr "Character1_Ctrl_HipsEffector.pint" "HIKPinning2State1.HipsEffectorPinT"
		;
connectAttr "Character1_Ctrl_HipsEffector.pinr" "HIKPinning2State1.HipsEffectorPinR"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.pint" "HIKPinning2State1.LeftAnkleEffectorPinT"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.pinr" "HIKPinning2State1.LeftAnkleEffectorPinR"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.pint" "HIKPinning2State1.RightAnkleEffectorPinT"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.pinr" "HIKPinning2State1.RightAnkleEffectorPinR"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.pint" "HIKPinning2State1.LeftWristEffectorPinT"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.pinr" "HIKPinning2State1.LeftWristEffectorPinR"
		;
connectAttr "Character1_Ctrl_RightWristEffector.pint" "HIKPinning2State1.RightWristEffectorPinT"
		;
connectAttr "Character1_Ctrl_RightWristEffector.pinr" "HIKPinning2State1.RightWristEffectorPinR"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.pint" "HIKPinning2State1.LeftKneeEffectorPinT"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.pinr" "HIKPinning2State1.LeftKneeEffectorPinR"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.pint" "HIKPinning2State1.RightKneeEffectorPinT"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.pinr" "HIKPinning2State1.RightKneeEffectorPinR"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.pint" "HIKPinning2State1.LeftElbowEffectorPinT"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.pinr" "HIKPinning2State1.LeftElbowEffectorPinR"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.pint" "HIKPinning2State1.RightElbowEffectorPinT"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.pinr" "HIKPinning2State1.RightElbowEffectorPinR"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.pint" "HIKPinning2State1.ChestOriginEffectorPinT"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.pinr" "HIKPinning2State1.ChestOriginEffectorPinR"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.pint" "HIKPinning2State1.ChestEndEffectorPinT"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.pinr" "HIKPinning2State1.ChestEndEffectorPinR"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.pint" "HIKPinning2State1.LeftFootEffectorPinT"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.pinr" "HIKPinning2State1.LeftFootEffectorPinR"
		;
connectAttr "Character1_Ctrl_RightFootEffector.pint" "HIKPinning2State1.RightFootEffectorPinT"
		;
connectAttr "Character1_Ctrl_RightFootEffector.pinr" "HIKPinning2State1.RightFootEffectorPinR"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.pint" "HIKPinning2State1.LeftShoulderEffectorPinT"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.pinr" "HIKPinning2State1.LeftShoulderEffectorPinR"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.pint" "HIKPinning2State1.RightShoulderEffectorPinT"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.pinr" "HIKPinning2State1.RightShoulderEffectorPinR"
		;
connectAttr "Character1_Ctrl_HeadEffector.pint" "HIKPinning2State1.HeadEffectorPinT"
		;
connectAttr "Character1_Ctrl_HeadEffector.pinr" "HIKPinning2State1.HeadEffectorPinR"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.pint" "HIKPinning2State1.LeftHipEffectorPinT"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.pinr" "HIKPinning2State1.LeftHipEffectorPinR"
		;
connectAttr "Character1_Ctrl_RightHipEffector.pint" "HIKPinning2State1.RightHipEffectorPinT"
		;
connectAttr "Character1_Ctrl_RightHipEffector.pinr" "HIKPinning2State1.RightHipEffectorPinR"
		;
connectAttr "Character1.OutputCharacterDefinition" "HIKState2FK1.InputCharacterDefinition"
		;
connectAttr "HIKSolverNode1.OutputCharacterState" "HIKState2FK1.InputCharacterState"
		;
connectAttr "Character1.OutputCharacterDefinition" "HIKState2FK2.InputCharacterDefinition"
		;
connectAttr "HIKSolverNode1.decs" "HIKState2FK2.InputCharacterState";
connectAttr "HIKSolverNode1.OutputCharacterState" "HIKEffectorFromCharacter1.InputCharacterState"
		;
connectAttr "Character1.OutputCharacterDefinition" "HIKEffectorFromCharacter1.InputCharacterDefinition"
		;
connectAttr "HIKproperties1.OutputPropertySetState" "HIKEffectorFromCharacter1.InputPropertySetState"
		;
connectAttr "HIKSolverNode1.decs" "HIKEffectorFromCharacter2.InputCharacterState"
		;
connectAttr "Character1.OutputCharacterDefinition" "HIKEffectorFromCharacter2.InputCharacterDefinition"
		;
connectAttr "HIKproperties1.OutputPropertySetState" "HIKEffectorFromCharacter2.InputPropertySetState"
		;
connectAttr "Character1_Ctrl_HipsEffector.po" "HIKState2Effector1.HipsEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.po" "HIKState2Effector1.LeftAnkleEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.po" "HIKState2Effector1.RightAnkleEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.po" "HIKState2Effector1.LeftWristEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightWristEffector.po" "HIKState2Effector1.RightWristEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.po" "HIKState2Effector1.LeftKneeEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.po" "HIKState2Effector1.RightKneeEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.po" "HIKState2Effector1.LeftElbowEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.po" "HIKState2Effector1.RightElbowEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.po" "HIKState2Effector1.ChestOriginEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.po" "HIKState2Effector1.ChestEndEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.po" "HIKState2Effector1.LeftFootEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightFootEffector.po" "HIKState2Effector1.RightFootEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.po" "HIKState2Effector1.LeftShoulderEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.po" "HIKState2Effector1.RightShoulderEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_HeadEffector.po" "HIKState2Effector1.HeadEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.po" "HIKState2Effector1.LeftHipEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightHipEffector.po" "HIKState2Effector1.RightHipEffectorpivotOffset[0]"
		;
connectAttr "HIKEffectorFromCharacter1.OutputEffectorState" "HIKState2Effector1.InputEffectorState"
		;
connectAttr "Character1_Ctrl_HipsEffector.po" "HIKState2Effector2.HipsEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftAnkleEffector.po" "HIKState2Effector2.LeftAnkleEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightAnkleEffector.po" "HIKState2Effector2.RightAnkleEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftWristEffector.po" "HIKState2Effector2.LeftWristEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightWristEffector.po" "HIKState2Effector2.RightWristEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftKneeEffector.po" "HIKState2Effector2.LeftKneeEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightKneeEffector.po" "HIKState2Effector2.RightKneeEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftElbowEffector.po" "HIKState2Effector2.LeftElbowEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightElbowEffector.po" "HIKState2Effector2.RightElbowEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_ChestOriginEffector.po" "HIKState2Effector2.ChestOriginEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_ChestEndEffector.po" "HIKState2Effector2.ChestEndEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftFootEffector.po" "HIKState2Effector2.LeftFootEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightFootEffector.po" "HIKState2Effector2.RightFootEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftShoulderEffector.po" "HIKState2Effector2.LeftShoulderEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightShoulderEffector.po" "HIKState2Effector2.RightShoulderEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_HeadEffector.po" "HIKState2Effector2.HeadEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_LeftHipEffector.po" "HIKState2Effector2.LeftHipEffectorpivotOffset[0]"
		;
connectAttr "Character1_Ctrl_RightHipEffector.po" "HIKState2Effector2.RightHipEffectorpivotOffset[0]"
		;
connectAttr "HIKEffectorFromCharacter2.OutputEffectorState" "HIKState2Effector2.InputEffectorState"
		;
connectAttr "defaultRenderLayer.msg" ":defaultRenderingList1.r" -na;
// End of scene.ma
