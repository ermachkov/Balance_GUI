function main_menu_createSprites()
	spriteQuitIcon = Sprite("spriteQuitIcon", 0, 0)
	spriteFactorySettingsIcon = Sprite("spriteFactorySettingsIcon", 0, 0)
	spriteSoftwareUpdateIcon = Sprite("spriteSoftwareUpdateIcon", 0, 0)
	spriteRemoteControlDisabledIcon = Sprite("spriteRemoteControlDisabledIcon", 0, 0)
	spriteRemoteControlEnabledIcon = Sprite("spriteRemoteControlEnabledIcon", 0, 0)
	spriteDNSIcon = Sprite("spriteDNSIcon", 0, 0)
	spriteGatewayIcon = Sprite("spriteGatewayIcon", 0, 0)
	spriteNetmaskIcon = Sprite("spriteNetmaskIcon", 0, 0)
	spriteLocalAddrIcon = Sprite("spriteLocalAddrIcon", 0, 0)
	spriteServerAddrIcon = Sprite("spriteServerAddrIcon", 0, 0)
	spriteNetworkIcon = Sprite("spriteNetworkIcon", 0, 0)
	spriteThemeIcon = Sprite("spriteThemeIcon", 0, 0)
	spriteChineseIcon = Sprite("spriteChineseIcon", 0, 0)
	spriteRussianIcon = Sprite("spriteRussianIcon", 0, 0)
	spriteEnglishIcon = Sprite("spriteEnglishIcon", 0, 0)
	spritePlus24VIcon = Sprite("spritePlus24VIcon", -1, 0)
	spritePlus5VIcon = Sprite("spritePlus5VIcon", -1, 0)
	spritePlus3_3VIcon = Sprite("spritePlus3_3VIcon", -1, -1)
	spritePlus2_5VIcon = Sprite("spritePlus2_5VIcon", -1, 0)
	spritePlus1_8VIcon = Sprite("spritePlus1_8VIcon", -1, 0)
	spritePlus1_2VIcon = Sprite("spritePlus1_2VIcon", -1, 0)
	spriteMinus5VIcon = Sprite("spriteMinus5VIcon", -1, 0)
	spriteDspVoltagesIcon = Sprite("spriteDspVoltagesIcon", -1, 0)
	spriteArmVoltagesIcon = Sprite("spriteArmVoltagesIcon", -1, 0)
	spriteRulerCalDiamIcon = Sprite("spriteRulerCalDiamIcon", 0, 0)
	spriteRulerCalOffsetIcon = Sprite("spriteRulerCalOffsetIcon", 0, 0)
	spriteRulerRadiusIcon = Sprite("spriteRulerRadiusIcon", 0, 0)
	spriteRulerVertIcon = Sprite("spriteRulerVertIcon", 0, 0)
	spriteRulerHorzIcon = Sprite("spriteRulerHorzIcon", 0, 0)
	spriteRulerCal3Icon = Sprite("spriteRulerCal3Icon", 0, 0)
	spriteRulerCal2Icon = Sprite("spriteRulerCal2Icon", 0, 0)
	spriteRulerCal1Icon = Sprite("spriteRulerCal1Icon", 0, 0)
	spriteRulerCal0Icon = Sprite("spriteRulerCal0Icon", 0, 0)
	spriteRulerCalIcon = Sprite("spriteRulerCalIcon", 0, 0)
	spriteBalanceCalWeightIcon = Sprite("spriteBalanceCalWeightIcon", 0, 0)
	spriteBalanceCal3Icon = Sprite("spriteBalanceCal3Icon", 0, 0)
	spriteBalanceCal2Icon = Sprite("spriteBalanceCal2Icon", 0, 0)
	spriteBalanceCal1Icon = Sprite("spriteBalanceCal1Icon", 0, 0)
	spriteBalanceCal0Icon = Sprite("spriteBalanceCal0Icon", 0, 0)
	spriteBalanceCalIcon = Sprite("spriteBalanceCalIcon", 0, 0)
	spriteBalanceFastCalIcon = Sprite("spriteBalanceFastCalIcon", 0, 0)
	spriteDirection1Icon = Sprite("spriteDirection1Icon", 0, 0)
	spriteDirection0Icon = Sprite("spriteDirection0Icon", 0, 0)
	spritePedalMode1Icon = Sprite("spritePedalMode1Icon", 0, 0)
	spritePedalMode0Icon = Sprite("spritePedalMode0Icon", 0, 0)
	spriteRotationMode3Icon = Sprite("spriteRotationMode3Icon", 0, 0)
	spriteRotationMode2Icon = Sprite("spriteRotationMode2Icon", 0, 0)
	spriteRotationMode1Icon = Sprite("spriteRotationMode1Icon", 0, 0)
	spriteRotationMode0Icon = Sprite("spriteRotationMode0Icon", 0, 0)
	spriteStartMode2Icon = Sprite("spriteStartMode2Icon", 0, 0)
	spriteStartMode1Icon = Sprite("spriteStartMode1Icon", 0, 0)
	spriteStartMode0Icon = Sprite("spriteStartMode0Icon", 0, 0)
	spriteMinWeightIcon = Sprite("spriteMinWeightIcon", 0, 0)
	spriteRoundIcon = Sprite("spriteRoundIcon", 0, 0)
	spriteMainSubmenu = Sprite("spriteMainSubmenu", 426, 49)
	spriteMainMenu = Sprite("spriteMainMenu", 23, 31)
	spriteOptionsMenuIcon = Sprite("spriteOptionsMenuIcon", 38, 727)
	spriteDiagnosticsMenuIcon = Sprite("spriteDiagnosticsMenuIcon", 38, 571)
	spriteCalibrationMenuIcon = Sprite("spriteCalibrationMenuIcon", 38, 416)
	spriteUser2MenuIcon = Sprite("spriteUser2MenuIcon", 38, 260)
	spriteUser1MenuIcon = Sprite("spriteUser1MenuIcon", 38, 104)
	spriteMainMenuScrollBack = Sprite("spriteMainMenuScrollBack", 1187, 162)
	spriteMainMenuScrollFront = Sprite("spriteMainMenuScrollFront", 1189, 163)
	spriteMainMenuItemSelected = Sprite("spriteMainMenuItemSelected", 507, 590)
	spriteMainMenuItemPressed = Sprite("spriteMainMenuItemPressed", 507, 762)
	spriteMainMenuTrianglePressed = Sprite("spriteMainMenuTrianglePressed", 1140, 877)
	spriteMainMenuItemNormal = Sprite("spriteMainMenuItemNormal", 507, 110)
	spriteMainMenuTriangleNormal = Sprite("spriteMainMenuTriangleNormal", 1140, 225)
	spriteMainMenuDownButton = Sprite("spriteMainMenuDownButton", 603, 947)
	spriteMainMenuUpButton = Sprite("spriteMainMenuUpButton", 602, 53)
	spriteMainMenuCloseButton = Sprite("spriteMainMenuCloseButton", 1149, 65)
	spriteMainMenuBackButton = Sprite("spriteMainMenuBackButton", 428, 153)
	spriteMainMenuItemValue = Sprite("spriteMainMenuItemValue", 980, 125)
	spriteMainMenuItemText = Sprite("spriteMainMenuItemText", 682, 183)
	spriteMainMenuItemHeader = Sprite("spriteMainMenuItemHeader", 681, 128)
	spriteMainMenuItemIcon = Sprite("spriteMainMenuItemIcon", 517, 121)
	spriteWizardBack = Sprite("spriteWizardBack", 253, 138)
	spriteWizardText = Sprite("spriteWizardText", 458, 294)
	spriteWizardText2 = Sprite("spriteWizardText2", 292, 387)
	spriteWizardHeader = Sprite("spriteWizardHeader", 460, 226)
	spriteWizardIcon = Sprite("spriteWizardIcon", 290, 228)
	spriteWizardIconGlass = Sprite("spriteWizardIconGlass", 290, 228)
	spriteWizardCloseButton = Sprite("spriteWizardCloseButton", 973, 148)
	spriteWizardCancelButton = Sprite("spriteWizardCancelButton", 778, 673)
	spriteWizardCancelButtonText = Sprite("spriteWizardCancelButtonText", 794, 692)
	spriteWizardNextButton = Sprite("spriteWizardNextButton", 546, 674)
	spriteWizardNextButtonText = Sprite("spriteWizardNextButtonText", 595, 692)
end

function main_menu_deleteSprites()
	spriteQuitIcon = nil
	spriteFactorySettingsIcon = nil
	spriteSoftwareUpdateIcon = nil
	spriteRemoteControlDisabledIcon = nil
	spriteRemoteControlEnabledIcon = nil
	spriteDNSIcon = nil
	spriteGatewayIcon = nil
	spriteNetmaskIcon = nil
	spriteLocalAddrIcon = nil
	spriteServerAddrIcon = nil
	spriteNetworkIcon = nil
	spriteThemeIcon = nil
	spriteChineseIcon = nil
	spriteRussianIcon = nil
	spriteEnglishIcon = nil
	spritePlus24VIcon = nil
	spritePlus5VIcon = nil
	spritePlus3_3VIcon = nil
	spritePlus2_5VIcon = nil
	spritePlus1_8VIcon = nil
	spritePlus1_2VIcon = nil
	spriteMinus5VIcon = nil
	spriteDspVoltagesIcon = nil
	spriteArmVoltagesIcon = nil
	spriteRulerCalDiamIcon = nil
	spriteRulerCalOffsetIcon = nil
	spriteRulerRadiusIcon = nil
	spriteRulerVertIcon = nil
	spriteRulerHorzIcon = nil
	spriteRulerCal3Icon = nil
	spriteRulerCal2Icon = nil
	spriteRulerCal1Icon = nil
	spriteRulerCal0Icon = nil
	spriteRulerCalIcon = nil
	spriteBalanceCalWeightIcon = nil
	spriteBalanceCal3Icon = nil
	spriteBalanceCal2Icon = nil
	spriteBalanceCal1Icon = nil
	spriteBalanceCal0Icon = nil
	spriteBalanceCalIcon = nil
	spriteBalanceFastCalIcon = nil
	spriteDirection1Icon = nil
	spriteDirection0Icon = nil
	spritePedalMode1Icon = nil
	spritePedalMode0Icon = nil
	spriteRotationMode3Icon = nil
	spriteRotationMode2Icon = nil
	spriteRotationMode1Icon = nil
	spriteRotationMode0Icon = nil
	spriteStartMode2Icon = nil
	spriteStartMode1Icon = nil
	spriteStartMode0Icon = nil
	spriteMinWeightIcon = nil
	spriteRoundIcon = nil
	spriteMainSubmenu = nil
	spriteMainMenu = nil
	spriteOptionsMenuIcon = nil
	spriteDiagnosticsMenuIcon = nil
	spriteCalibrationMenuIcon = nil
	spriteUser2MenuIcon = nil
	spriteUser1MenuIcon = nil
	spriteMainMenuScrollBack = nil
	spriteMainMenuScrollFront = nil
	spriteMainMenuItemSelected = nil
	spriteMainMenuItemPressed = nil
	spriteMainMenuTrianglePressed = nil
	spriteMainMenuItemNormal = nil
	spriteMainMenuTriangleNormal = nil
	spriteMainMenuDownButton = nil
	spriteMainMenuUpButton = nil
	spriteMainMenuCloseButton = nil
	spriteMainMenuBackButton = nil
	spriteMainMenuItemValue = nil
	spriteMainMenuItemText = nil
	spriteMainMenuItemHeader = nil
	spriteMainMenuItemIcon = nil
	spriteWizardBack = nil
	spriteWizardText = nil
	spriteWizardText2 = nil
	spriteWizardHeader = nil
	spriteWizardIcon = nil
	spriteWizardIconGlass = nil
	spriteWizardCloseButton = nil
	spriteWizardCancelButton = nil
	spriteWizardCancelButtonText = nil
	spriteWizardNextButton = nil
	spriteWizardNextButtonText = nil
end
