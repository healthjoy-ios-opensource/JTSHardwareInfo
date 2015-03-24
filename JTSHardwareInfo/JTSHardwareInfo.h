//
//  JTSHardwareInfo.h
//  JTSHardwareInfo
//
//  Created by Jared Sinclair on 10/1/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//
//  Originally based on code by InderKumarRathmore at https://github.com/InderKumarRathore/UIDevice-Hardware
//

#import <UIKit/UIKit.h>

@interface JTSHardwareInfo : NSObject

typedef NS_ENUM(NSInteger, JTSHardwareFamily) {
    JTSHardwareFamily_Unknown = 0,
    JTSHardwareFamily_iPhone,
    JTSHardwareFamily_iPad,
    JTSHardwareFamily_iPodTouch,
};

typedef NS_ENUM(NSInteger, JTSHardwareType) {
    
    JTSHardwareType_NotAvailable = 0,
    JTSHardwareType_Simulator,
    
    JTSHardwareType_iPhone_Unreleased,
    JTSHardwareType_iPodTouch_Unreleased,
    JTSHardwareType_iPad_Unreleased,
    
    JTSHardwareType_iPhone,
    JTSHardwareType_iPhone_3G,
    JTSHardwareType_iPhone_3G_China,
    JTSHardwareType_iPhone_3GS,
    JTSHardwareType_iPhone_3GS_China,
    JTSHardwareType_iPhone_4_GSM,
    JTSHardwareType_iPhone_4_GSM_2012,
    JTSHardwareType_iPhone_4_CDMA,
    JTSHardwareType_iPhone_4S,
    JTSHardwareType_iPhone_4S_China,
    JTSHardwareType_iPhone_5_GSM,
    JTSHardwareType_iPhone_5_Global,
    JTSHardwareType_iPhone_5C_GSM,
    JTSHardwareType_iPhone_5C_Global,
    JTSHardwareType_iPhone_5S_GSM,
    JTSHardwareType_iPhone_5S_Global,
    JTSHardwareType_iPhone_6,
    JTSHardwareType_iPhone_6_China,
    JTSHardwareType_iPhone_6Plus,
    JTSHardwareType_iPhone_6Plus_China,
    
    JTSHardwareType_iPodTouch_1Gen,
    JTSHardwareType_iPodTouch_2Gen,
    JTSHardwareType_iPodTouch_3Gen,
    JTSHardwareType_iPodTouch_4Gen,
    JTSHardwareType_iPodTouch_5Gen,
    
    JTSHardwareType_iPad,
    JTSHardwareType_iPad_Cellular,
    JTSHardwareType_iPad_2_WiFi,
    JTSHardwareType_iPad_2_GSM,
    JTSHardwareType_iPad_2_CDMA,
    JTSHardwareType_iPad_2_Mid_2012,
    JTSHardwareType_iPad_3_WiFi,
    JTSHardwareType_iPad_3_GSM,
    JTSHardwareType_iPad_3_CDMA,
    JTSHardwareType_iPad_4_WiFi,
    JTSHardwareType_iPad_4_GSM,
    JTSHardwareType_iPad_4_Global,
    JTSHardwareType_iPad_Air_WiFi,
    JTSHardwareType_iPad_Air_Cellular,
    JTSHardwareType_iPad_Air_2_WiFi,
    JTSHardwareType_iPad_Air_2_Cellular,
    JTSHardwareType_iPad_Air_China,
    JTSHardwareType_iPad_Mini_WiFi,
    JTSHardwareType_iPad_Mini_GSM,
    JTSHardwareType_iPad_Mini_Global,
    JTSHardwareType_iPad_Mini_Retina_WiFi,
    JTSHardwareType_iPad_Mini_Retina_Cellular,
    JTSHardwareType_iPad_Mini_Retina_China,
    JTSHardwareType_iPad_Mini_3_WiFi,
    JTSHardwareType_iPad_Mini_3_Cellular,
};

+ (NSString *)hardwareIdentifier;
+ (JTSHardwareType)hardwareType;
+ (JTSHardwareFamily)hardwareFamily;
+ (NSString *)hardwareDisplayName;
+ (BOOL)airDropIsAvailable;

@end



