//
//  Generated file. Do not edit.
//

// clang-format off

#import "GeneratedPluginRegistrant.h"

#if __has_include(<blue_thermal_printer/BlueThermalPrinterPlugin.h>)
#import <blue_thermal_printer/BlueThermalPrinterPlugin.h>
#else
@import blue_thermal_printer;
#endif

#if __has_include(<image_picker_ios/FLTImagePickerPlugin.h>)
#import <image_picker_ios/FLTImagePickerPlugin.h>
#else
@import image_picker_ios;
#endif

#if __has_include(<path_provider_ios/FLTPathProviderPlugin.h>)
#import <path_provider_ios/FLTPathProviderPlugin.h>
#else
@import path_provider_ios;
#endif

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [BlueThermalPrinterPlugin registerWithRegistrar:[registry registrarForPlugin:@"BlueThermalPrinterPlugin"]];
  [FLTImagePickerPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTImagePickerPlugin"]];
  [FLTPathProviderPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTPathProviderPlugin"]];
}

@end
