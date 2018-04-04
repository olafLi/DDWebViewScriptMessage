//
//  DDWebViewScriptMessage.swift
//  PartyBuilding
//
//  Created by LiTengFei on 2018/4/2.
//  Copyright © 2018年 WinKind. All rights reserved.
//

import UIKit
import WebKit

public protocol DDScriptAdapterProtocol {
    var adapterScriptPath:String? { get }
}

typealias WKWebViewSctiptMessageHandler = (_ content: DDScriptMessageContext, _ executable: DDWebViewScriptMessageProtocol?)-> Void

open class DDWebViewScriptMessage: NSObject {

    open func run(_ context: DDScriptMessageContext, executable: DDWebViewScriptMessageProtocol?) {

    }

    var context:DDScriptMessageContext?
    open var name:String = ""
    
    weak var responsder:DDWebViewScriptMessageResponse?

    fileprivate var messageHandler:WKWebViewSctiptMessageHandler?

    convenience init(name:String,messageHandler:WKWebViewSctiptMessageHandler? = nil){
        self.init()
        self.name = name
        self.messageHandler = messageHandler
    }

    override public init() {
        super.init()
    }
}

extension DDWebViewScriptMessage: DDScriptAdapterProtocol {

    open var adapterScriptPath:String? {
        let scriptName = String(describing: type(of: self))
        return Bundle.main.path(forResource: scriptName, ofType: "js")
    }

}

extension  DDWebViewScriptMessage: DDScriptMessageResponsable {

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
        if let responsder = self.responsder {
            responsder.response("JKEventHandler.callBack('\(name)',\(object))", nil)
        }
    }
}
