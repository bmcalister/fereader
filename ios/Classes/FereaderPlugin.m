#import "FereaderPlugin.h"
#if __has_include(<fereader/fereader-Swift.h>)
#import <fereader/fereader-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "fereader-Swift.h"
#endif

@implementation FereaderPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFereaderPlugin registerWithRegistrar:registrar];
}
@end
