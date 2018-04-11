//
//  AlertScriptMessage.swift
//  DDScriptMessage_Example
//
//  Created by LiTengFei on 2018/4/4.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import DDScriptMessage

public class AlertScriptMessage: DDWebViewScriptMessage {
    
    public override init() {
        super.init()
    }

    override public func run(_ context: DDScriptMessageContext, executable: DDWebViewScriptMessageProtocol?) {
        let alert = UIAlertController(title: "title", message: "message", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: { (action) in
            context.addResponse("response string is text", for: "text")
            context.send(to: self)
        }))
        executable?.viewController?.present(alert, animated: true, completion: nil)
    }

    override public var name: String {
        get{
            return "alert"
        }
        set {
            self.name = newValue
        }
    }
    
    public override var adapterScriptPath:String? {
        guard let sourceBundle = self.resourceBundle else {
            log.debug("can't found source bundle")
            return ""
        }
        let scriptName = String(describing: type(of: self))
        return sourceBundle.path(forResource: scriptName, ofType: "js")
    }
}
