//
//  DDScriptMessageContext.swift
//  FourPlatform
//
//  Created by LiTengFei on 2017/8/24.
//  Copyright © 2017年 WinKind. All rights reserved.
//

import UIKit
import WebKit

/**
 可响应
 */
public protocol DDScriptMessageResponsable {
    func callback(_ name: String, response: [String:Any]?)
}

protocol DDScriptMessageContextable {
    var context: DDScriptMessageContext? { get set }
}

public class DDScriptMessageContext {

    private var params: [String:Any]
    private var response: [String:Any]

    public var functionName: String?
    public var callback: String?

    public init(_ message: WKScriptMessage) {

        self.response = [:]

        guard let maps: [String:AnyObject] = message.body as? [String : AnyObject] else {
            self.callback = ""
            self.functionName = ""
            self.params = [:]
            return
        }

        self.callback = maps["callback"] as? String ?? ""
        self.params = maps["params"] as? [String : Any] ?? [:]
        self.functionName = maps["func_name"] as? String ?? ""

        print("js script message context init and it's info is: \n \(self)")
    }

    public func addResponse(_ value:Any?,for key: String) {
        response[key] = value
    }

    public func send(to responsder: DDScriptMessageResponsable) {
        print("\(self) will send to responsder \(responsder)")
        responsder.callback(callback!, response: response)
    }
}

extension DDScriptMessageContext : CustomStringConvertible {
    public var description: String {
        var string: String = ""
        string.append("callback: \(String(describing: callback)) \n")
        string.append("functionName: \(String(describing: functionName))\n")
        let param: String = ""
        string.append(param)
        return string
    }

}
