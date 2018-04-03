//
//  DDWebViewScriptMessage.swift
//  PartyBuilding
//
//  Created by LiTengFei on 2018/4/2.
//  Copyright © 2018年 WinKind. All rights reserved.
//

import UIKit
import WebKit

protocol DDScriptMessageHandlerable {
    var name:String { get set}

    func run(_ context:DDScriptMessageContext,executable:DDWebViewScriptMessageProtocol?) -> Void
}

typealias WKWebViewSctiptMessageHandler = (_ content: DDScriptMessageContext, _ executable: DDWebViewScriptMessageProtocol?)-> Void

class DDWebViewScriptMessage: NSObject,DDScriptMessageHandlerable {

    var context:DDScriptMessageContext?
    var name:String = ""

    weak var responseable:DDWebViewScriptMessageProtocol?

    fileprivate var messageHandler:WKWebViewSctiptMessageHandler?

    convenience init(name:String,messageHandler:WKWebViewSctiptMessageHandler? = nil){
        self.init()
        self.name = name
        self.messageHandler = messageHandler
    }

    override init() {
        super.init()
    }

    func run(_ context: DDScriptMessageContext, executable: DDWebViewScriptMessageProtocol?) {
        self.context = context
        self.responseable = executable
        
        if let handler = self.messageHandler {
            handler(context,executable)
        }
    }
}

extension DDWebViewScriptMessage:DDScriptMessageResponsable {

    func callback(_ name: String, response: [String : Any]?) {
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
        if let runable = self.responseable {
            runable.run(object, nil)
        }
    }
}
