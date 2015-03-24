//
//  JTSHardwareInfo.m
//  JTSHardwareInfo
//
//  Created by Jared Sinclair on 10/1/14.
//  Copyright (c) 2014 Nice Boy LLC. All rights reserved.
//

#import "JTSHardwareInfo.h"
#include <sys/types.h>
#include <sys/sysctl.h>

static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone             = @"iPhone1,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_3G          = @"iPhone1,2";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_3G_China    = @"iPhone1,2*";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_3GS         = @"iPhone2,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_3GS_China   = @"iPhone2,1*";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_4_GSM       = @"iPhone3,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_4_GSM_2012  = @"iPhone3,2";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_4_CDMA      = @"iPhone3,3";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_4S          = @"iPhone4,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_4S_China    = @"iPhone4,1*";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_5_GSM       = @"iPhone5,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_5_Global    = @"iPhone5,2";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_5C_GSM      = @"iPhone5,3";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_5C_Global   = @"iPhone5,4";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_5S_GSM      = @"iPhone6,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_5S_Global   = @"iPhone6,2";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_6Plus_China = @"iPhone7,1*";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_6Plus       = @"iPhone7,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_6_China     = @"iPhone7,2*";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPhone_6           = @"iPhone7,2";

static NSString * JTSHardwareInfo_HardwareIdentifier_iPad                       = @"iPad1,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Cellular              = @"iPad1,2";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_2_WiFi                = @"iPad2,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_2_GSM                 = @"iPad2,2";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_2_CDMA                = @"iPad2,3";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_2_MID_2012            = @"iPad2,4";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Mini_WiFi             = @"iPad2,5";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Mini_GSM              = @"iPad2,6";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Mini_Global           = @"iPad2,7";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_3_WiFi                = @"iPad3,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_3_CDMA                = @"iPad3,2";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_3_GSM                 = @"iPad3,3";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_4_WiFi                = @"iPad3,4";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_4_GSM                 = @"iPad3,5";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_4_Global              = @"iPad3,6";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Air_WiFi              = @"iPad4,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Air_Cellular          = @"iPad4,2";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Air_China             = @"iPad4,3";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Air_2_WiFi            = @"iPad5,3";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Air_2_Cellular        = @"iPad5,4";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_WiFi      = @"iPad4,4";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_Cellular  = @"iPad4,5";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_China     = @"iPad4,6";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Mini_3_WiFi           = @"iPad4,7";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPad_Mini_3_Cellular       = @"iPad4,8";

static NSString * JTSHardwareInfo_HardwareIdentifier_iPodTouch_1G       = @"iPod1,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPodTouch_2G       = @"iPod2,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPodTouch_3G       = @"iPod3,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPodTouch_4G       = @"iPod4,1";
static NSString * JTSHardwareInfo_HardwareIdentifier_iPodTouch_5G       = @"iPod5,1";

@implementation JTSHardwareInfo

#pragma mark - Public

+ (NSString *)hardwareIdentifier {
    static dispatch_once_t once;
    static NSString * hardware;
    dispatch_once(&once, ^ {
        size_t size = 100;
        char *hw_machine = malloc(size);
        int name[] = {CTL_HW,HW_MACHINE};
        sysctl(name, 2, hw_machine, &size, NULL, 0);
        hardware = [NSString stringWithUTF8String:hw_machine];
        free(hw_machine);
    });
    return hardware;
}

+ (JTSHardwareFamily)hardwareFamily {
    
    static dispatch_once_t once;
    static JTSHardwareFamily family;
    
    dispatch_once(&once, ^ {
        NSString *deviceName = [UIDevice currentDevice].name;
        if ([deviceName hasPrefix:@"iPhone"]) {
            family = JTSHardwareFamily_iPhone;
        }
        else if ([deviceName hasPrefix:@"iPad"]) {
            family = JTSHardwareFamily_iPad;
        }
        else if ([deviceName hasPrefix:@"iPod"]) {
            family = JTSHardwareFamily_iPodTouch;
        }
        else {
            family = JTSHardwareFamily_Unknown;
        }
    });
    
    return family;
}

+ (JTSHardwareType)hardwareType {
    static dispatch_once_t once;
    static JTSHardwareType type;
    dispatch_once(&once, ^ {
        type = [self getCurrentHardwareType];
    });
    return type;
}

+ (NSString *)hardwareDisplayName {
    
    NSString *displayName = nil;
    
    switch ([self hardwareType]) {
            
            
        case JTSHardwareType_Simulator:
            displayName = @"iOS Simulator";
            break;
            
            
        case JTSHardwareType_NotAvailable:
        case JTSHardwareType_iPhone_Unreleased:
        case JTSHardwareType_iPad_Unreleased:
        case JTSHardwareType_iPodTouch_Unreleased:
            displayName = [[UIDevice currentDevice] name];
            break;
            
        
        case JTSHardwareType_iPhone_6_China:
            displayName = @"iPhone 6 (China)";
            break;
        case JTSHardwareType_iPhone_6:
            displayName = @"iPhone 6";
            break;
        case JTSHardwareType_iPhone_6Plus_China:
            displayName = @"iPhone 6 Plus (China)";
            break;
        case JTSHardwareType_iPhone_6Plus:
            displayName = @"iPhone 6 Plus";
            break;
        case JTSHardwareType_iPhone_5S_Global:
            displayName = @"iPhone 5s (Global)";
            break;
        case JTSHardwareType_iPhone_5S_GSM:
            displayName = @"iPhone 5s (GSM)";
            break;
        case JTSHardwareType_iPhone_5C_Global:
            displayName = @"iPhone 5c (Global)";
            break;
        case JTSHardwareType_iPhone_5C_GSM:
            displayName = @"iPhone 5c (GSM)";
            break;
        case JTSHardwareType_iPhone_5_Global:
            displayName = @"iPhone 5 (Global)";
            break;
        case JTSHardwareType_iPhone_5_GSM:
            displayName = @"iPhone 5 (GSM)";
            break;
        case JTSHardwareType_iPhone_4S_China:
            displayName = @"iPhone 4S (China)";
            break;
        case JTSHardwareType_iPhone_4S:
            displayName = @"iPhone 4S";
            break;
        case JTSHardwareType_iPhone_4_GSM_2012:
            displayName = @"iPhone 4 (GSM 2012)";
            break;
        case JTSHardwareType_iPhone_4_CDMA:
            displayName = @"iPhone 4 (CDMA)";
            break;
        case JTSHardwareType_iPhone_4_GSM:
            displayName = @"iPhone 4 (GSM)";
            break;
        case JTSHardwareType_iPhone_3GS:
            displayName = @"iPhone 3GS";
            break;
        case JTSHardwareType_iPhone_3GS_China:
            displayName = @"iPhone 3GS (China/No WiFi)";
            break;
        case JTSHardwareType_iPhone_3G:
            displayName = @"iPhone 3G";
            break;
        case JTSHardwareType_iPhone_3G_China:
            displayName = @"iPhone 3G (China/No WiFi)";
            break;
        case JTSHardwareType_iPhone:
            displayName = @"iPhone";
            break;
        

        case JTSHardwareType_iPad_Mini_3_Cellular:
            displayName = @"iPad Mini 3 (Cellular)";
            break;
        case JTSHardwareType_iPad_Mini_3_WiFi:
            displayName = @"iPad Mini 3 (WiFi)";
            break;
        case JTSHardwareType_iPad_Mini_Retina_China:
            displayName = @"iPad Mini Retina (China)";
            break;
        case JTSHardwareType_iPad_Mini_Retina_Cellular:
            displayName = @"iPad Mini Retina (Cellular)";
            break;
        case JTSHardwareType_iPad_Mini_Retina_WiFi:
            displayName = @"iPad Mini Retina (WiFi)";
            break;
        case JTSHardwareType_iPad_Mini_Global:
            displayName = @"iPad Mini (Global)";
            break;
        case JTSHardwareType_iPad_Mini_GSM:
            displayName = @"iPad Mini (GSM)";
            break;
        case JTSHardwareType_iPad_Mini_WiFi:
            displayName = @"iPad Mini (WiFi)";
            break;
            
            
        case JTSHardwareType_iPad_Air_China:
            displayName = @"iPad Air (China)";
            break;
        case JTSHardwareType_iPad_Air_Cellular:
            displayName = @"iPad Air (Cellular)";
            break;
        case JTSHardwareType_iPad_Air_WiFi:
            displayName = @"iPad Air (WiFi)";
            break;
        case JTSHardwareType_iPad_Air_2_Cellular:
            displayName = @"iPad Air 2 (Cellular)";
            break;
        case JTSHardwareType_iPad_Air_2_WiFi:
            displayName = @"iPad Air 2 (WiFi)";
            break;
            
            
        case JTSHardwareType_iPad_4_Global:
            displayName = @"iPad 4 (Global)";
            break;
        case JTSHardwareType_iPad_4_GSM:
            displayName = @"iPad 4 (GSM)";
            break;
        case JTSHardwareType_iPad_4_WiFi:
            displayName = @"iPad 4 (WiFi)";
            break;
        case JTSHardwareType_iPad_3_CDMA:
            displayName = @"iPad 3 (CDMA)";
            break;
        case JTSHardwareType_iPad_3_GSM:
            displayName = @"iPad 3 (GSM)";
            break;
        case JTSHardwareType_iPad_3_WiFi:
            displayName = @"iPad 3 (WiFi)";
            break;
        case JTSHardwareType_iPad_2_Mid_2012:
            displayName = @"iPad 2 (Mid 2012)";
            break;
        case JTSHardwareType_iPad_2_CDMA:
            displayName = @"iPad 2 (CDMA)";
            break;
        case JTSHardwareType_iPad_2_GSM:
            displayName = @"iPad (GSM)";
            break;
        case JTSHardwareType_iPad_2_WiFi:
            displayName = @"iPad 2 (WiFi)";
            break;
        case JTSHardwareType_iPad_Cellular:
            displayName = @"iPad (Cellular)";
            break;
        case JTSHardwareType_iPad:
            displayName = @"iPad";
            break;
            
            
        case JTSHardwareType_iPodTouch_5Gen:
            displayName = @"iPod Touch (5th Gen)";
            break;
        case JTSHardwareType_iPodTouch_4Gen:
            displayName = @"iPod Touch (4th Gen)";
            break;
        case JTSHardwareType_iPodTouch_3Gen:
            displayName = @"iPod Touch (3rd Gen)";
            break;
        case JTSHardwareType_iPodTouch_2Gen:
            displayName = @"iPod Touch (2nd Gen)";
            break;
        case JTSHardwareType_iPodTouch_1Gen:
            displayName = @"iPod Touch (1st Gen)";
            break;
            
            
        default:
            displayName = @"Not Available";
            break;
    }
    
    return displayName;
}

+ (BOOL)airDropIsAvailable {
    
    static dispatch_once_t once;
    static BOOL isAvailable;
    
    dispatch_once(&once, ^ {
        
        JTSHardwareType hardwareType = [self hardwareType];
        
        if (hardwareType == JTSHardwareType_NotAvailable) {
            isAvailable = YES;
        }
        else if (hardwareType == JTSHardwareType_iPhone_Unreleased) {
            isAvailable = YES;
        }
        else if (hardwareType == JTSHardwareType_iPad_Unreleased) {
            isAvailable = YES;
        }
        else if (hardwareType == JTSHardwareType_iPodTouch_Unreleased) {
            isAvailable = YES;
        }
        else {
            NSString *hardwareString = [self hardwareIdentifier];
            if ([hardwareString hasPrefix:@"iPhone"]) {
                isAvailable = (hardwareType >= JTSHardwareType_iPhone_5_GSM);
            }
            else if ([hardwareString hasPrefix:@"iPad"]) {
                isAvailable = (hardwareType >= JTSHardwareType_iPad_4_WiFi);
            }
            else if ([hardwareString hasPrefix:@"iPod"]) {
                isAvailable = (hardwareType >= JTSHardwareType_iPodTouch_5Gen);
            }
        }
    });
    
    return isAvailable;
}

#pragma mark - Private

+ (JTSHardwareType)getCurrentHardwareType {
    
    NSString *hardware = [self hardwareIdentifier];
    
    if ([hardware hasPrefix:@"iPhone"]) {
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_6_China])       return JTSHardwareType_iPhone_6_China;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_6])             return JTSHardwareType_iPhone_6;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_6Plus_China])   return JTSHardwareType_iPhone_6Plus_China;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_6Plus])         return JTSHardwareType_iPhone_6Plus;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_5S_Global])     return JTSHardwareType_iPhone_5S_Global;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_5S_GSM])        return JTSHardwareType_iPhone_5S_GSM;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_5C_Global])     return JTSHardwareType_iPhone_5C_Global;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_5C_GSM])        return JTSHardwareType_iPhone_5C_GSM;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_5_Global])      return JTSHardwareType_iPhone_5_Global;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_5_GSM])         return JTSHardwareType_iPhone_5_GSM;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_4S_China])      return JTSHardwareType_iPhone_4S_China;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_4S])            return JTSHardwareType_iPhone_4S;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_4_CDMA])        return JTSHardwareType_iPhone_4_CDMA;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_4_GSM_2012])    return JTSHardwareType_iPhone_4_GSM_2012;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_4_GSM])         return JTSHardwareType_iPhone_4_GSM;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_3GS_China])     return JTSHardwareType_iPhone_3GS_China;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_3GS])           return JTSHardwareType_iPhone_3GS;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_3G_China])      return JTSHardwareType_iPhone_3G_China;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone_3G])            return JTSHardwareType_iPhone_3G;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPhone])               return JTSHardwareType_iPhone;
        return JTSHardwareType_iPhone_Unreleased;
    }
    else if ([hardware hasPrefix:@"iPad"]) {
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Mini_3_Cellular])return JTSHardwareType_iPad_Mini_3_Cellular;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Mini_3_WiFi])    return JTSHardwareType_iPad_Mini_3_WiFi;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_China])   return JTSHardwareType_iPad_Mini_Retina_China;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_Cellular])return JTSHardwareType_iPad_Mini_Retina_Cellular;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Mini_Retina_WiFi])    return JTSHardwareType_iPad_Mini_Retina_WiFi;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Mini_Global])         return JTSHardwareType_iPad_Mini_Global;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Mini_GSM])            return JTSHardwareType_iPad_Mini_GSM;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Mini_WiFi])           return JTSHardwareType_iPad_Mini_WiFi;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Air_2_Cellular])      return JTSHardwareType_iPad_Air_2_Cellular;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Air_2_WiFi])          return JTSHardwareType_iPad_Air_2_WiFi;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Air_China])           return JTSHardwareType_iPad_Air_China;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Air_Cellular])        return JTSHardwareType_iPad_Air_Cellular;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Air_WiFi])            return JTSHardwareType_iPad_Air_WiFi;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_4_Global])            return JTSHardwareType_iPad_4_Global;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_4_GSM])               return JTSHardwareType_iPad_4_GSM;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_4_WiFi])              return JTSHardwareType_iPad_4_WiFi;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_3_CDMA])              return JTSHardwareType_iPad_3_CDMA;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_3_GSM])               return JTSHardwareType_iPad_3_GSM;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_3_WiFi])              return JTSHardwareType_iPad_3_WiFi;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_2_MID_2012])          return JTSHardwareType_iPad_2_Mid_2012;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_2_CDMA])              return JTSHardwareType_iPad_2_CDMA;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_2_GSM])               return JTSHardwareType_iPad_2_GSM;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_2_WiFi])              return JTSHardwareType_iPad_2_WiFi;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad_Cellular])            return JTSHardwareType_iPad_Cellular;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPad])                     return JTSHardwareType_iPad;
        return JTSHardwareType_iPad_Unreleased;
    }
    else if ([hardware hasPrefix:@"iPod"]) {
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPodTouch_5G])         return JTSHardwareType_iPodTouch_5Gen;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPodTouch_4G])         return JTSHardwareType_iPodTouch_4Gen;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPodTouch_3G])         return JTSHardwareType_iPodTouch_3Gen;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPodTouch_2G])         return JTSHardwareType_iPodTouch_2Gen;
        if ([hardware isEqualToString:JTSHardwareInfo_HardwareIdentifier_iPodTouch_1G])         return JTSHardwareType_iPodTouch_1Gen;
        return JTSHardwareType_iPodTouch_Unreleased;
    }
    
    if ([hardware isEqualToString:@"i386"]) return JTSHardwareType_Simulator;
    if ([hardware isEqualToString:@"x86_64"]) return JTSHardwareType_Simulator;
    
    return JTSHardwareType_NotAvailable;
}

@end













