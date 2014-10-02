JTSHardwareInfo
===============

A convenient and thorough utility for referencing iOS device hardware information.

## Features

- **Comprehensive** – Includes hardwared identifiers for all iOS devices released by Apple, from the original iPhone to the iPhone 6 and 6 Plus.

- **AirDrop** – Check for general AirDrop availability.

## Supported Devices

Here's the current enum of all hardware types:

```objc
typedef NS_ENUM(NSInteger, JTSHardwareType) {
    
    JTSHardwareType_NotAvailable,
    JTSHardwareType_Simulator,
    
    JTSHardwareType_iPhone_UNRELEASED,
    JTSHardwareType_iPodTouch_UNRELEASED,
    JTSHardwareType_iPad_UNRELEASED,
    
    JTSHardwareType_iPhone,
    JTSHardwareType_iPhone_3G,
    JTSHardwareType_iPhone_3G_CHINA,
    JTSHardwareType_iPhone_3GS,
    JTSHardwareType_iPhone_3GS_CHINA,
    JTSHardwareType_iPhone_4_GSM,
    JTSHardwareType_iPhone_4_GSM_2012,
    JTSHardwareType_iPhone_4_CDMA,
    JTSHardwareType_iPhone_4S,
    JTSHardwareType_iPhone_4S_CHINA,
    JTSHardwareType_iPhone_5_GSM,
    JTSHardwareType_iPhone_5_GLOBAL,
    JTSHardwareType_iPhone_5C_GSM,
    JTSHardwareType_iPhone_5C_GLOBAL,
    JTSHardwareType_iPhone_5S_GSM,
    JTSHardwareType_iPhone_5S_GLOBAL,
    JTSHardwareType_iPhone_6,
    JTSHardwareType_iPhone_6_CHINA,
    JTSHardwareType_iPhone_6Plus,
    JTSHardwareType_iPhone_6Plus_CHINA,
    
    JTSHardwareType_iPodTouch_1Gen,
    JTSHardwareType_iPodTouch_2Gen,
    JTSHardwareType_iPodTouch_3Gen,
    JTSHardwareType_iPodTouch_4Gen,
    JTSHardwareType_iPodTouch_5Gen,
    
    JTSHardwareType_iPad,
    JTSHardwareType_iPad_CELLULAR,
    JTSHardwareType_iPad_2_WIFI,
    JTSHardwareType_iPad_2_GSM,
    JTSHardwareType_iPad_2_CDMA,
    JTSHardwareType_iPad_2_MID2012,
    JTSHardwareType_iPad_3_WIFI,
    JTSHardwareType_iPad_3_GSM,
    JTSHardwareType_iPad_3_CDMA,
    JTSHardwareType_iPad_4_WIFI,
    JTSHardwareType_iPad_4_GSM,
    JTSHardwareType_iPad_4_GLOBAL,
    JTSHardwareType_iPad_Air_WIFI,
    JTSHardwareType_iPad_Air_CELLULAR,
    JTSHardwareType_iPad_Air_CHINA,
    JTSHardwareType_iPad_Mini_WIFI,
    JTSHardwareType_iPad_Mini_GSM,
    JTSHardwareType_iPad_Mini_GLOBAL,
    JTSHardwareType_iPad_Mini_Retina_WIFI,
    JTSHardwareType_iPad_Mini_Retina_CELLULAR,
    JTSHardwareType_iPad_Mini_Retina_CHINA,
};
```
