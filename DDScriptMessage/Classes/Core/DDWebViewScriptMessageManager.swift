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

public protocol DDWebViewScriptMessageProtocol: class {

    func run(_ script: String, _ completionHandler: ((Any?, Error?) -> Swift.Void)?)

    var viewController:UIViewController? { get }

    var webview:WKWebView? { get }

}

class DDWebViewScriptMessageManager: NSObject {

    static let shared = DDWebViewScriptMessageManager()

    var scripts:[DDWebViewScriptMessage] = []

    var scriptMessages:[String:DDWebViewScriptMessage] = [:]

    var delegate:DDWebViewScriptMessageProtocol? = nil

    func register(_ name:String, handler:(_ runable:DDWebViewScriptMessageProtocol) -> Void){
        let message = DDWebViewScriptMessage()
        message.name = name
        register(message: message)
    }


    func register(message:DDWebViewScriptMessage){
        scripts.append(message)
        enableScript(message)
    }

    func register(_ messageHandler:DDBaseScriptMessageHandler, for name:String) {
        userContentController.add(messageHandler, name: name)
    }

    private func enableScript(_ message:DDWebViewScriptMessage) {
        userContentController.add(self, name: message.name)
    }

    lazy var userContentController: WKUserContentController = {
        let controller = WKUserContentController()

        let bundle = Bundle(for: DDWebViewScriptMessageManager.self)
        var url = bundle.url(forResource: "winkind_common", withExtension: "js")

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

extension DDWebViewScriptMessageManager : WKScriptMessageHandler {
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

        let filterScript = scripts.filter { (script) -> Bool in
            return message.name == script.name
        }

        for script in filterScript {
            let context = DDScriptMessageContext(message)
            script.context = context
            script.responseable = self.delegate
            script.run(context,executable: self.delegate)
        }
    }
}

extension DDWebViewScriptMessageManager {



}


