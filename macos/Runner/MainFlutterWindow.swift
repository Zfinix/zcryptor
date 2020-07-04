import Cocoa
import FlutterMacOS

class MainFlutterWindow: NSWindow {
  override func awakeFromNib() {
    let flutterViewController = FlutterViewController.init()
    var windowFrame = self.frame
    self.minSize = NSSize(width: 750, height: 400)
    self.maxSize = NSSize(width: 750, height: 400)
    windowFrame.size = NSSize(width: 750, height: 400)
    self.contentViewController = flutterViewController
    self.setFrame(windowFrame, display: true)

    RegisterGeneratedPlugins(registry: flutterViewController)

    super.awakeFromNib()
  }
}
