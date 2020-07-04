import Flutter
import UIKit

public class SwiftZcryptFfiPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zcrypt_ffi", binaryMessenger: registrar.messenger())
    let instance = SwiftZcryptFfiPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
   public static func dummyMethodToEnforceBundling() {
    // call some function from our static lib
    add(40, 2)
  }
}
