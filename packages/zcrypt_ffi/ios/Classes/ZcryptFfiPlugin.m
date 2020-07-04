#import "ZcryptFfiPlugin.h"
#if __has_include(<zcrypt_ffi/zcrypt_ffi-Swift.h>)
#import <zcrypt_ffi/zcrypt_ffi-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "zcrypt_ffi-Swift.h"
#endif

@implementation ZcryptFfiPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftZcryptFfiPlugin registerWithRegistrar:registrar];
}
@end
