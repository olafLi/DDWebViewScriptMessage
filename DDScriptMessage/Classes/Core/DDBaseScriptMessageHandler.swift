//
//  DDBaseScriptMessageHandler.swift
//  FourPlatform
//
//  Created by LiTengFei on 2017/8/16.
//  Copyright © 2017年 Winkind. All rights reserved.
//

import UIKit
import WebKit

public class DDBaseScriptMessageHandler: NSObject {

    var context: DDScriptMessageContext?
//    var completion: ScriptMessageContextCompletion?

    fileprivate var callback: String = ""

    var contentController: DDWebViewScriptMessageProtocol?
    var web: WKWebView

    public init(_ content: DDWebViewScriptMessageProtocol, _ webView: WKWebView = WKWebView()) {
        self.contentController = content
        self.web = webView
        super.init()
    }
}

extension DDBaseScriptMessageHandler : DDWebViewScriptMessageProtocol, DDScriptMessageResponsable {

    public var webview:WKWebView? {
        return self.contentController?.webview
    }

    public var viewController:UIViewController? {
        return self.contentController?.viewController
    }

    public func run(_ script: String, _ completionHandler: ((Any?, Error?) -> Void)?) {
//        self.contentController.run(script, completionHandler)
    }

    public func callback(_ name: String, response: [String : Any]?) {
        var object: String = ""
        if let resp = response {
            do {
                let data = try JSONSerialization.data(withJSONObject: resp, options: JSONSerialization.WritingOptions.prettyPrinted)
                object = NSString(data: data, encoding: String.Encoding.utf8.rawValue)! as String
                object = object.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
            } catch {
                log.debug(error)
            }
        }
        self.run("JKEventHandler.callBack('\(name)',\(object))", nil)
    }
}

extension DDBaseScriptMessageHandler : WKScriptMessageHandler {

    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {

    }
}
