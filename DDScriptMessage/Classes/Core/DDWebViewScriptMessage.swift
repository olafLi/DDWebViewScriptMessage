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

public protocol DDScriptMessageHandlerable {

    func run(_ context:DDScriptMessageContext,executable:DDWebViewScriptMessageProtocol?) -> Void
}

typealias WKWebViewSctiptMessageHandler = (_ content: DDScriptMessageContext, _ executable: DDWebViewScriptMessageProtocol?)-> Void

open class DDWebViewScriptMessage: NSObject,DDScriptMessageHandlerable {

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

    open func run(_ context: DDScriptMessageContext, executable: DDWebViewScriptMessageProtocol?) {

    }
}

extension DDWebViewScriptMessage:DDScriptMessageResponsable {

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
        if let runable = self.responsder {
            runable.response(object, nil)
        }
    }
}
