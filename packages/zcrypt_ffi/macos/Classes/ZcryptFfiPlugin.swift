import Cocoa
import FlutterMacOS

public class ZcryptFfiPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "zcrypt_ffi", binaryMessenger: registrar.messenger)
    let instance = ZcryptFfiPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    switch call.method {
    case "getPlatformVersion":
      result("macOS " + ProcessInfo.processInfo.operatingSystemVersionString)
    default:
      result(FlutterMethodNotImplemented)
    }
  }
    public static func dummyMethodToEnforceBundling() {
    // call some function from our static lib
    //add(40, 2)
  }
}
