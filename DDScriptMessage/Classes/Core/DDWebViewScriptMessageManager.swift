//
//  DDWebViewScriptMessageManager.swift
//  PartyBuilding
//
//  Created by LiTengFei on 2018/4/2.
//  Copyright © 2018年 WinKind. All rights reserved.
//

import UIKit
import WebKit
import XCGLogger

let log = XCGLogger.default
/*
 消息响应接口  reponse
 */
protocol DDWebViewScriptMessageResponse : class {
    func response(_ script: String, _ completionHandler: ((Any?, Error?) -> Swift.Void)?)
}
/*
 消息管理类协议
 */
public protocol DDWebViewScriptMessageProtocol: class {

    func run(_ script: String, _ completionHandler: ((Any?, Error?) -> Swift.Void)?)

    var viewController:UIViewController? { get }

    var webview:WKWebView? { get }

}
/*
 消息管理类
 */
public class DDWebViewScriptMessageManager: NSObject {

    public static let shared = DDWebViewScriptMessageManager()

    var scripts:[DDWebViewScriptMessage] = []

    var scriptMessages:[String:DDWebViewScriptMessage] = [:]

    public var delegate:DDWebViewScriptMessageProtocol? = nil

    public override init() {
        super.init()
    }

    func register(_ name:String, handler:(_ runable:DDWebViewScriptMessageProtocol) -> Void){
        let message = DDWebViewScriptMessage()
        message.name = name
        register(message: message)
    }

    public func register(message:DDWebViewScriptMessage){
        scripts.append(message)
        enableScript(message)
    }

    private func enableScript(_ message:DDWebViewScriptMessage) {

        userContentController.add(self, name: message.name)

        guard let path = message.adapterScriptPath else { assert(false,"path is nil"); return }
        guard let data = NSData(contentsOfFile: path) else {  return}

        var jsString: String = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
        jsString = jsString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
        var script = WKUserScript(source: jsString, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
        userContentController.addUserScript(script)
    }

    private var resourceBundle:Bundle? {

        let bundlePath = Bundle(for: DDWebViewScriptMessageManager.self).resourcePath! + "/DDScriptMessage.bundle"

        guard let sourceBundle:Bundle = Bundle(path: bundlePath) else {
            assert(false, "can't found source bundle")
            return nil
        }
        return sourceBundle
    }

    public lazy var userContentController: WKUserContentController = {
        let controller = WKUserContentController()

        guard let sourceBundle = self.resourceBundle else {
            assert(false, "can't found source bundle")
            return controller
        }

        var url = sourceBundle.url(forResource: "winkind_common", withExtension: "js")

        if let data = NSData(contentsOfFile: (url?.path)!) {
            var jsString: String = NSString(data: data as Data, encoding: String.Encoding.utf8.rawValue)! as String
            jsString = jsString.trimmingCharacters(in: NSCharacterSet.whitespacesAndNewlines)
            var script = WKUserScript(source: jsString, injectionTime: WKUserScriptInjectionTime.atDocumentStart, forMainFrameOnly: false)
            controller.addUserScript(script)
        }

        return controller
    }()
    
}

extension DDWebViewScriptMessageManager {

    var controller:UIViewController? {
        return self.delegate?.viewController
    }
    var webview:WKWebView? {
        return self.delegate?.webview
    }
}

extension DDWebViewScriptMessageManager: DDWebViewScriptMessageResponse {

    func response(_ script: String, _ completionHandler: ((Any?, Error?) -> Void)?) {
        if let webView = self.webview {
            webview?.evaluateJavaScript(script, completionHandler: { (object, error) in
                log.debugExec {
                    log.debug(object)
                    log.debug(error)
                }
            })
        }
    }
}

extension DDWebViewScriptMessageManager : WKScriptMessageHandler {
    
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        let filterScript = scripts.filter { (script) -> Bool in
            return message.name == script.name
        }

        for script:DDWebViewScriptMessage in filterScript {
            let context = DDScriptMessageContext(message)

            script.context = context
            script.responsder = self

            script.run(context, executable: self.delegate)

        }
    }
}



