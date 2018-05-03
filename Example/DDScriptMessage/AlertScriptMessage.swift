//
//  AlertScriptMessage.swift
//  DDScriptMessage_Example
//
//  Created by LiTengFei on 2018/4/4.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import DDScriptMessage

class AlertScriptMessage: DDWebViewScriptMessage {
    
    override init() {
        super.init()
    }

    override func run(_ context: DDScriptMessageContext, executable: DDWebViewScriptMessageProtocol?) {
        let alert = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            context.addResponse("response string is text", for: "text")
            context.send(to: self)
        }))
        executable?.viewController?.present(alert, animated: true, completion: nil)
    }

    override var name: String {
        get{
            return "alert"
        }
        set {
            self.name = newValue
        }
    }
}
