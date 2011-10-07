function main_screen_createSprites()
	spriteDiskMenu = Sprite("spriteDiskMenu", 93, 32)
	spriteDiskSubmenu = Sprite("spriteDiskSubmenu", 368, 34)
	spriteAluMenuDie = Sprite("spriteAluMenuDie", 393, 93)
	spriteAluMenuText = Sprite("spriteAluMenuText", 415, 325)
	spriteAluDie14 = Sprite("spriteAluDie14", 666, 774)
	spriteAluDie13 = Sprite("spriteAluDie13", 1026, 594)
	spriteAluDie12 = Sprite("spriteAluDie12", 846, 594)
	spriteAluDie11 = Sprite("spriteAluDie11", 666, 594)
	spriteAluDie10 = Sprite("spriteAluDie10", 1026, 414)
	spriteAluDie9 = Sprite("spriteAluDie9", 846, 414)
	spriteAluDie8 = Sprite("spriteAluDie8", 666, 414)
	spriteAluDie7 = Sprite("spriteAluDie7", 1026, 234)
	spriteAluDie6 = Sprite("spriteAluDie6", 846, 234)
	spriteAluDie5 = Sprite("spriteAluDie5", 666, 234)
	spriteAluDie4 = Sprite("spriteAluDie4", 1026, 54)
	spriteAluDie3 = Sprite("spriteAluDie3", 846, 54)
	spriteAluDie = Sprite("spriteAluDie", 666, 54)
	spriteAbsHighlight = Sprite("spriteAbsHighlight", 366, 461)
	spriteAbsMenuDie = Sprite("spriteAbsMenuDie", 393, 510)
	spriteAbsMenuText = Sprite("spriteAbsMenuText", 433, 739)
	spriteTruckHighlight = Sprite("spriteTruckHighlight", 96, 461)
	spriteTruckMenuDie = Sprite("spriteTruckMenuDie", 128, 510)
	spriteTruckMenuText = Sprite("spriteTruckMenuText", 130, 739)
	spriteSteelHighlight = Sprite("spriteSteelHighlight", 96, 35)
	spriteSteelMenuDie = Sprite("spriteSteelMenuDie", 128, 93)
	spriteSteelMenuText = Sprite("spriteSteelMenuText", 145, 324)
	spriteKeyboardBack = Sprite("spriteKeyboardBack", 30, 33)
	spriteKeyClear = Sprite("spriteKeyClear", 367, 269)
	spriteKeyClearText = Sprite("spriteKeyClearText", 391, 287)
	spriteKeyBackspace = Sprite("spriteKeyBackspace", 367, 171)
	spriteKeyBackspaceText = Sprite("spriteKeyBackspaceText", 380, 190)
	spriteKeyEnter = Sprite("spriteKeyEnter", 367, 370)
	spriteKeyEnterText = Sprite("spriteKeyEnterText", 381, 424)
	spriteKeyPoint = Sprite("spriteKeyPoint", 264, 468)
	spriteKeyPointText = Sprite("spriteKeyPointText", 302, 499)
	spriteKey9 = Sprite("spriteKey9", 264, 171)
	spriteKey9Text = Sprite("spriteKey9Text", 288, 187)
	spriteKey8 = Sprite("spriteKey8", 162, 171)
	spriteKey8Text = Sprite("spriteKey8Text", 187, 187)
	spriteKey7 = Sprite("spriteKey7", 59, 171)
	spriteKey7Text = Sprite("spriteKey7Text", 84, 188)
	spriteKey6 = Sprite("spriteKey6", 264, 269)
	spriteKey6Text = Sprite("spriteKey6Text", 289, 285)
	spriteKey5 = Sprite("spriteKey5", 162, 269)
	spriteKey5Text = Sprite("spriteKey5Text", 186, 286)
	spriteKey4 = Sprite("spriteKey4", 59, 269)
	spriteKey4Text = Sprite("spriteKey4Text", 82, 285)
	spriteKey3 = Sprite("spriteKey3", 264, 370)
	spriteKey3Text = Sprite("spriteKey3Text", 289, 386)
	spriteKey2 = Sprite("spriteKey2", 162, 370)
	spriteKey2Text = Sprite("spriteKey2Text", 186, 386)
	spriteKey1 = Sprite("spriteKey1", 59, 370)
	spriteKey1Text = Sprite("spriteKey1Text", 87, 386)
	spriteKey0 = Sprite("spriteKey0", 62, 468)
	spriteKey0Text = Sprite("spriteKey0Text", 136, 483)
	spriteKeyboardDisplayPassword = Sprite("spriteKeyboardDisplayPassword", 66, 65)
	spriteKeyboardDisplay = Sprite("spriteKeyboardDisplay", 66, 65)
	spriteKeyboardDisplayBack = Sprite("spriteKeyboardDisplayBack", 80, 83)
	spriteKeyboardDisplayText = Sprite("spriteKeyboardDisplayText", 305, 83)
	spriteBottomFasteners = Sprite("spriteBottomFasteners", 39, 560)
	spriteRightFasteners = Sprite("spriteRightFasteners", 479, 81)
	spriteTopFasteners = Sprite("spriteTopFasteners", 39, -11)
	spriteLeftFasteners = Sprite("spriteLeftFasteners", -4, 81)
	spriteLayoutMenu = Sprite("spriteLayoutMenu", 62, 32)
	spriteLayoutSubmenu = Sprite("spriteLayoutSubmenu", 77, 72)
	spriteStatMenuDie = Sprite("spriteStatMenuDie", 98, 464)
	spriteStatDie5 = Sprite("spriteStatDie5", 620, 542)
	spriteStatDie4 = Sprite("spriteStatDie4", 390, 542)
	spriteStatDie3 = Sprite("spriteStatDie3", 850, 322)
	spriteStatDie2 = Sprite("spriteStatDie2", 620, 322)
	spriteStatDie1 = Sprite("spriteStatDie1", 390, 322)
	spriteStatMenuText = Sprite("spriteStatMenuText", 120, 691)
	spriteDynMenuDie = Sprite("spriteDynMenuDie", 98, 93)
	spriteDynDie24 = Sprite("spriteDynDie24", 850, 344)
	spriteDynDie23 = Sprite("spriteDynDie23", 620, 345)
	spriteDynDie13 = Sprite("spriteDynDie13", 390, 344)
	spriteDynDie14 = Sprite("spriteDynDie14", 850, 124)
	spriteDynDie25 = Sprite("spriteDynDie25", 620, 124)
	spriteDynDie15 = Sprite("spriteDynDie15", 390, 124)
	spriteDynMenuText = Sprite("spriteDynMenuText", 132, 324)
	spriteMainScreenBack1 = Sprite("spriteMainScreenBack1", 1023, 0)
	spriteMainScreenBack0 = Sprite("spriteMainScreenBack0", 0, 0)
	spriteRightBack2 = Sprite("spriteRightBack2", 880, 382)
	spriteRightGreenBack2 = Sprite("spriteRightGreenBack2", 880, 382)
	spriteRightBottomArrow2 = Sprite("spriteRightBottomArrow2", 1065, 554)
	spriteRightTopArrow2 = Sprite("spriteRightTopArrow2", 1065, 244)
	spriteRightWeight2 = Sprite("spriteRightWeight2", 895, 397)
	spriteRightBottomAngle = Sprite("spriteRightBottomAngle", 1024, 435)
	spriteRightTopAngle = Sprite("spriteRightTopAngle", 1022, 123)
	spriteRightGreenBack = Sprite("spriteRightGreenBack", 1057, 326)
	spriteRightBottomArrow = Sprite("spriteRightBottomArrow", 1069, 527)
	spriteRightTopArrow = Sprite("spriteRightTopArrow", 1069, 257)
	spriteRightWeight = Sprite("spriteRightWeight", 1084, 397)
	spriteLeftBottomAngle = Sprite("spriteLeftBottomAngle", 0, 435)
	spriteLeftTopAngle = Sprite("spriteLeftTopAngle", 0, 123)
	spriteLeftGreenBack = Sprite("spriteLeftGreenBack", 0, 326)
	spriteLeftBottomArrow = Sprite("spriteLeftBottomArrow", 147, 527)
	spriteLeftTopArrow = Sprite("spriteLeftTopArrow", 147, 257)
	spriteLeftWeight = Sprite("spriteLeftWeight", 14, 397)
	spriteOfsBack = Sprite("spriteOfsBack", 188, 107)
	spriteOfsButton = Sprite("spriteOfsButton", 200, 131)
	spriteOfsIcon = Sprite("spriteOfsIcon", 333, 118)
	spriteOfsButtonRed = Sprite("spriteOfsButtonRed", 200, 132)
	spriteOfsIconRed = Sprite("spriteOfsIconRed", 333, 119)
	spriteWidthStickBack = Sprite("spriteWidthStickBack", 853, 108)
	spriteWidthStickButton = Sprite("spriteWidthStickButton", 947, 131)
	spriteStickIcon = Sprite("spriteStickIcon", 864, 119)
	spriteWidthIcon = Sprite("spriteWidthIcon", 864, 119)
	spriteWidthStickButtonRed = Sprite("spriteWidthStickButtonRed", 947, 131)
	spriteStickIconRed = Sprite("spriteStickIconRed", 864, 119)
	spriteWidthIconRed = Sprite("spriteWidthIconRed", 864, 119)
	spriteDiamBack = Sprite("spriteDiamBack", 176, 680)
	spriteDiamIcon = Sprite("spriteDiamIcon", 320, 692)
	spriteDiamButton = Sprite("spriteDiamButton", 187, 705)
	spriteDiamIconRed = Sprite("spriteDiamIconRed", 320, 692)
	spriteDiamButtonRed = Sprite("spriteDiamButtonRed", 187, 705)
	spriteDiskButton = Sprite("spriteDiskButton", 384, 860)
	spriteDiskButtonText = Sprite("spriteDiskButtonText", 506, 909)
	spriteDiskIcon = Sprite("spriteDiskIcon", 406, 885)
	spriteLayoutButton = Sprite("spriteLayoutButton", 62, 860)
	spriteLayoutButtonText = Sprite("spriteLayoutButtonText", 179, 909)
	spriteLayoutIcon = Sprite("spriteLayoutIcon", 86, 890)
	spriteStopButton = Sprite("spriteStopButton", 957, 846)
	spriteStopButtonText = Sprite("spriteStopButtonText", 1014, 901)
	spriteStartButton = Sprite("spriteStartButton", 667, 846)
	spriteStartButtonText = Sprite("spriteStartButtonText", 712, 901)
	spriteHelpButton = Sprite("spriteHelpButton", 161, 20)
	spriteHelpButtonText = Sprite("spriteHelpButtonText", 183, 47)
	spriteMenuButton = Sprite("spriteMenuButton", 24, 20)
	spriteMenuButtonText = Sprite("spriteMenuButtonText", 43, 47)
	spriteUsersBack = Sprite("spriteUsersBack", 854, 674)
	spriteUsersLed = Sprite("spriteUsersLed", 990, 710)
	spriteUser2 = Sprite("spriteUser2", 867, 689)
	spriteUser2Text = Sprite("spriteUser2Text", 1006, 717)
	spriteUser1 = Sprite("spriteUser1", 867, 689)
	spriteUser1Text = Sprite("spriteUser1Text", 1008, 718)
	spriteErrorPopupBack = Sprite("spriteErrorPopupBack", 545, 0)
	spriteErrorPopupIcon = Sprite("spriteErrorPopupIcon", 559, 25)
	spriteErrorPopupText = Sprite("spriteErrorPopupText", 663, 79)
	spriteAutoAluPopupBack = Sprite("spriteAutoAluPopupBack", 377, 0)
	spriteAutoAluPopupIcon = Sprite("spriteAutoAluPopupIcon", 413, 23)
	spriteMessageBack = Sprite("spriteMessageBack", 290, 293)
	spriteMessageText = Sprite("spriteMessageText", 473, 321)
	spriteMessageOkButton = Sprite("spriteMessageOkButton", 568, 421)
	spriteMessageOkButtonText = Sprite("spriteMessageOkButtonText", 636, 437)
	spriteMessageNoButton = Sprite("spriteMessageNoButton", 743, 421)
	spriteMessageNoButtonText = Sprite("spriteMessageNoButtonText", 812, 437)
	spriteMessageYesButton = Sprite("spriteMessageYesButton", 525, 421)
	spriteMessageYesButtonText = Sprite("spriteMessageYesButtonText", 580, 437)
	spriteMessageIcon = Sprite("spriteMessageIcon", 333, 324)
	spriteProgressBack = Sprite("spriteProgressBack", 185, 317)
	spriteProgressFront = Sprite("spriteProgressFront", 229, 469)
	spriteSpeedometerSpeed = Sprite("spriteSpeedometerSpeed", 944, 504)
	spriteSpeedometerText = Sprite("spriteSpeedometerText", 943, 478)
	spriteSpeedometerArrow = Sprite("spriteSpeedometerArrow", 922, 408)
	spriteSpeedometerCenter = Sprite("spriteSpeedometerCenter", 954, 437)
	spriteProgressText = Sprite("spriteProgressText", 220, 377)
	spriteCoverMessageBack = Sprite("spriteCoverMessageBack", 258, 314)
	spriteCoverMessageText = Sprite("spriteCoverMessageText", 522, 427)
	spriteAboutMessageBack = Sprite("spriteAboutMessageBack", 265, 216)
	spriteAboutMessageText = Sprite("spriteAboutMessageText", 626, 422)
	spriteStartPanel1 = Sprite("spriteStartPanel1", 1116, 496)
	spriteStartPanel0 = Sprite("spriteStartPanel0", 93, 496)
	spriteMouseStatusIcon = Sprite("spriteMouseStatusIcon", 994, 741)
	spriteNetworkStatusIcon = Sprite("spriteNetworkStatusIcon", 755, 742)
	spriteTouchscreenCalibrationText = Sprite("spriteTouchscreenCalibrationText", 778, 540)
	spriteTouchscreenCalibrationButton = Sprite("spriteTouchscreenCalibrationButton", 753, 418)
	spriteBalanceCalibrationText = Sprite("spriteBalanceCalibrationText", 558, 540)
	spriteBalanceCalibrationButton = Sprite("spriteBalanceCalibrationButton", 555, 388)
	spriteStartWorkText = Sprite("spriteStartWorkText", 362, 540)
	spriteStartWorkButton = Sprite("spriteStartWorkButton", 232, 365)
	spriteWheelBack = Sprite("spriteWheelBack", 448, 110)
	spriteWheelTarget5 = Sprite("spriteWheelTarget5", 793, 315)
	spriteWheelTarget4 = Sprite("spriteWheelTarget4", 744, 340)
	spriteWheelTarget3 = Sprite("spriteWheelTarget3", 679, 373)
	spriteWheelTarget2 = Sprite("spriteWheelTarget2", 539, 345)
	spriteWheelTarget1 = Sprite("spriteWheelTarget1", 488, 310)
	spriteWheelWeight5 = Sprite("spriteWheelWeight5", 793, 298)
	spriteWheelWeight4 = Sprite("spriteWheelWeight4", 745, 342)
	spriteWheelWeight3 = Sprite("spriteWheelWeight3", 680, 375)
	spriteWheelWeight2 = Sprite("spriteWheelWeight2", 540, 347)
	spriteWheelWeight1 = Sprite("spriteWheelWeight1", 504, 294)
	spriteWheelArrowInstall3 = Sprite("spriteWheelArrowInstall3", 307, 347)
	spriteWheelArrowBackwardText3 = Sprite("spriteWheelArrowBackwardText3", 332, 298)
	spriteWheelArrowInstall2 = Sprite("spriteWheelArrowInstall2", 259, 321)
	spriteWheelArrowBackwardText2 = Sprite("spriteWheelArrowBackwardText2", 325, 274)
	spriteWheelArrowInstall1 = Sprite("spriteWheelArrowInstall1", 240, 295)
	spriteWheelArrowBackwardText1 = Sprite("spriteWheelArrowBackwardText1", 322, 246)
	spriteWheelArrowForwardText3 = Sprite("spriteWheelArrowForwardText3", 332, 298)
	spriteWheelArrowForwardText2 = Sprite("spriteWheelArrowForwardText2", 325, 274)
	spriteWheelArrowForwardText1 = Sprite("spriteWheelArrowForwardText1", 322, 246)
	spriteWheelArrowMeasure3 = Sprite("spriteWheelArrowMeasure3", 327, 358)
	spriteWheelArrowMeasure2 = Sprite("spriteWheelArrowMeasure2", 266, 328)
	spriteWheelArrowMeasure1 = Sprite("spriteWheelArrowMeasure1", 235, 295)
end

function main_screen_deleteSprites()
	spriteDiskMenu = nil
	spriteDiskSubmenu = nil
	spriteAluMenuDie = nil
	spriteAluMenuText = nil
	spriteAluDie14 = nil
	spriteAluDie13 = nil
	spriteAluDie12 = nil
	spriteAluDie11 = nil
	spriteAluDie10 = nil
	spriteAluDie9 = nil
	spriteAluDie8 = nil
	spriteAluDie7 = nil
	spriteAluDie6 = nil
	spriteAluDie5 = nil
	spriteAluDie4 = nil
	spriteAluDie3 = nil
	spriteAluDie = nil
	spriteAbsHighlight = nil
	spriteAbsMenuDie = nil
	spriteAbsMenuText = nil
	spriteTruckHighlight = nil
	spriteTruckMenuDie = nil
	spriteTruckMenuText = nil
	spriteSteelHighlight = nil
	spriteSteelMenuDie = nil
	spriteSteelMenuText = nil
	spriteKeyboardBack = nil
	spriteKeyClear = nil
	spriteKeyClearText = nil
	spriteKeyBackspace = nil
	spriteKeyBackspaceText = nil
	spriteKeyEnter = nil
	spriteKeyEnterText = nil
	spriteKeyPoint = nil
	spriteKeyPointText = nil
	spriteKey9 = nil
	spriteKey9Text = nil
	spriteKey8 = nil
	spriteKey8Text = nil
	spriteKey7 = nil
	spriteKey7Text = nil
	spriteKey6 = nil
	spriteKey6Text = nil
	spriteKey5 = nil
	spriteKey5Text = nil
	spriteKey4 = nil
	spriteKey4Text = nil
	spriteKey3 = nil
	spriteKey3Text = nil
	spriteKey2 = nil
	spriteKey2Text = nil
	spriteKey1 = nil
	spriteKey1Text = nil
	spriteKey0 = nil
	spriteKey0Text = nil
	spriteKeyboardDisplayPassword = nil
	spriteKeyboardDisplay = nil
	spriteKeyboardDisplayBack = nil
	spriteKeyboardDisplayText = nil
	spriteBottomFasteners = nil
	spriteRightFasteners = nil
	spriteTopFasteners = nil
	spriteLeftFasteners = nil
	spriteLayoutMenu = nil
	spriteLayoutSubmenu = nil
	spriteStatMenuDie = nil
	spriteStatDie5 = nil
	spriteStatDie4 = nil
	spriteStatDie3 = nil
	spriteStatDie2 = nil
	spriteStatDie1 = nil
	spriteStatMenuText = nil
	spriteDynMenuDie = nil
	spriteDynDie24 = nil
	spriteDynDie23 = nil
	spriteDynDie13 = nil
	spriteDynDie14 = nil
	spriteDynDie25 = nil
	spriteDynDie15 = nil
	spriteDynMenuText = nil
	spriteMainScreenBack1 = nil
	spriteMainScreenBack0 = nil
	spriteRightBack2 = nil
	spriteRightGreenBack2 = nil
	spriteRightBottomArrow2 = nil
	spriteRightTopArrow2 = nil
	spriteRightWeight2 = nil
	spriteRightBottomAngle = nil
	spriteRightTopAngle = nil
	spriteRightGreenBack = nil
	spriteRightBottomArrow = nil
	spriteRightTopArrow = nil
	spriteRightWeight = nil
	spriteLeftBottomAngle = nil
	spriteLeftTopAngle = nil
	spriteLeftGreenBack = nil
	spriteLeftBottomArrow = nil
	spriteLeftTopArrow = nil
	spriteLeftWeight = nil
	spriteOfsBack = nil
	spriteOfsButton = nil
	spriteOfsIcon = nil
	spriteOfsButtonRed = nil
	spriteOfsIconRed = nil
	spriteWidthStickBack = nil
	spriteWidthStickButton = nil
	spriteStickIcon = nil
	spriteWidthIcon = nil
	spriteWidthStickButtonRed = nil
	spriteStickIconRed = nil
	spriteWidthIconRed = nil
	spriteDiamBack = nil
	spriteDiamIcon = nil
	spriteDiamButton = nil
	spriteDiamIconRed = nil
	spriteDiamButtonRed = nil
	spriteDiskButton = nil
	spriteDiskButtonText = nil
	spriteDiskIcon = nil
	spriteLayoutButton = nil
	spriteLayoutButtonText = nil
	spriteLayoutIcon = nil
	spriteStopButton = nil
	spriteStopButtonText = nil
	spriteStartButton = nil
	spriteStartButtonText = nil
	spriteHelpButton = nil
	spriteHelpButtonText = nil
	spriteMenuButton = nil
	spriteMenuButtonText = nil
	spriteUsersBack = nil
	spriteUsersLed = nil
	spriteUser2 = nil
	spriteUser2Text = nil
	spriteUser1 = nil
	spriteUser1Text = nil
	spriteErrorPopupBack = nil
	spriteErrorPopupIcon = nil
	spriteErrorPopupText = nil
	spriteAutoAluPopupBack = nil
	spriteAutoAluPopupIcon = nil
	spriteMessageBack = nil
	spriteMessageText = nil
	spriteMessageOkButton = nil
	spriteMessageOkButtonText = nil
	spriteMessageNoButton = nil
	spriteMessageNoButtonText = nil
	spriteMessageYesButton = nil
	spriteMessageYesButtonText = nil
	spriteMessageIcon = nil
	spriteProgressBack = nil
	spriteProgressFront = nil
	spriteSpeedometerSpeed = nil
	spriteSpeedometerText = nil
	spriteSpeedometerArrow = nil
	spriteSpeedometerCenter = nil
	spriteProgressText = nil
	spriteCoverMessageBack = nil
	spriteCoverMessageText = nil
	spriteAboutMessageBack = nil
	spriteAboutMessageText = nil
	spriteStartPanel1 = nil
	spriteStartPanel0 = nil
	spriteMouseStatusIcon = nil
	spriteNetworkStatusIcon = nil
	spriteTouchscreenCalibrationText = nil
	spriteTouchscreenCalibrationButton = nil
	spriteBalanceCalibrationText = nil
	spriteBalanceCalibrationButton = nil
	spriteStartWorkText = nil
	spriteStartWorkButton = nil
	spriteWheelBack = nil
	spriteWheelTarget5 = nil
	spriteWheelTarget4 = nil
	spriteWheelTarget3 = nil
	spriteWheelTarget2 = nil
	spriteWheelTarget1 = nil
	spriteWheelWeight5 = nil
	spriteWheelWeight4 = nil
	spriteWheelWeight3 = nil
	spriteWheelWeight2 = nil
	spriteWheelWeight1 = nil
	spriteWheelArrowInstall3 = nil
	spriteWheelArrowBackwardText3 = nil
	spriteWheelArrowInstall2 = nil
	spriteWheelArrowBackwardText2 = nil
	spriteWheelArrowInstall1 = nil
	spriteWheelArrowBackwardText1 = nil
	spriteWheelArrowForwardText3 = nil
	spriteWheelArrowForwardText2 = nil
	spriteWheelArrowForwardText1 = nil
	spriteWheelArrowMeasure3 = nil
	spriteWheelArrowMeasure2 = nil
	spriteWheelArrowMeasure1 = nil
end
