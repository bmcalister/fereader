import Flutter
import UIKit
import NFolioReaderKit

public class SwiftFereaderPlugin: NSObject, FlutterPlugin, FolioReaderPageDelegate, FlutterStreamHandler {
    let folioReader = FolioReader()
    static var pageResult: FlutterResult? = nil
    static var pageChannel:FlutterEventChannel? = nil
    
    var config: EpubConfig?
    
    
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "fereader", binaryMessenger: registrar.messenger())
        let instance = SwiftFereaderPlugin()
        pageChannel = FlutterEventChannel.init(name: "page",
                                               binaryMessenger: registrar.messenger());
        registrar.addMethodCallDelegate(instance, channel: channel)
    }
    
    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        
        
        switch call.method {
        case "setConfig":
            let arguments = call.arguments as![String:Any]
            let Identifier = arguments["identifier"] as! String
            let scrollDirection = arguments["scrollDirection"] as! String
            let color = arguments["themeColor"] as! String
            let allowSharing = arguments["allowSharing"] as! Bool
            let enableTts = arguments["enableTts"] as! Bool
            let nightMode = arguments["nightMode"] as! Bool
            
            self.folioReader.nightMode = nightMode
            
            self.config = EpubConfig.init(Identifier: Identifier,tintColor: color,allowSharing:
                                            allowSharing,scrollDirection: scrollDirection, enableTts: enableTts, nightMode: nightMode)
            
            break
        case "open":
            setPageHandler()
            let arguments = call.arguments as![String:Any]
            let bookPath = arguments["bookPath"] as! String
            self.open(epubPath: bookPath)
            
            break
        case "close":
            self.close()
            break
        default:
            break
        }
    }
    
    private func setPageHandler(){
        SwiftFereaderPlugin.pageChannel?.setStreamHandler(self)
    }
    
    @objc public func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        SwiftFereaderPlugin.pageResult = events
        return nil
    }
    
    public func onCancel(withArguments arguments: Any?) -> FlutterError? {
        return nil
    }
    
    
    fileprivate func open(epubPath: String) {
        if epubPath == "" {
            return
        }
        
        let readerVc = UIApplication.shared.keyWindow!.rootViewController ?? UIViewController()
        folioReader.presentReader(parentViewController: readerVc, withEpubPath: epubPath, andConfig: self.config!.config, fullScreen: true)
        folioReader.nightMode = config?.nightMode ?? false
        folioReader.readerCenter?.pageDelegate = self
        
    }
    
    public func pageWillLoad(_ page: FolioReaderPage) {
        
        print("page.pageNumber:"+String(page.pageNumber))
        
        if (SwiftFereaderPlugin.pageResult != nil){
            SwiftFereaderPlugin.pageResult!(String(page.pageNumber))
        }
        
    }
    
    private func close(){
        folioReader.readerContainer?.dismiss(animated: true, completion: nil)
    }
}
