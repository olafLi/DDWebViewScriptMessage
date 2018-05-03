//
//  ViewController.swift
//  DDScriptMessage
//
//  Created by olafLi on 04/03/2018.
//  Copyright (c) 2018 olafLi. All rights reserved.
//

import UIKit
import WebKit
import DDScriptMessage

class ViewController: UIViewController {

    lazy var webView:WKWebView = {
        let webview = WKWebView(frame: self.view.bounds, configuration: self.configuration)

        if let htmlPath = Bundle.main.path(forResource: "index", ofType: "html") {
            webview.load(URLRequest(url: URL(fileURLWithPath: htmlPath), cachePolicy: URLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10))
        }
        return webview
    }()

    lazy var configuration:WKWebViewConfiguration = {
        let configuration = WKWebViewConfiguration()
        configuration.preferences = WKPreferences()
        configuration.preferences.javaScriptEnabled = true
        configuration.preferences.javaScriptCanOpenWindowsAutomatically = false
        configuration.preferences.minimumFontSize = 10
        configuration.processPool = WKProcessPool()
        configuration.userContentController = DDWebViewScriptMessageManager.shared.userContentController
        return configuration
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DDWebViewScriptMessageManager.shared.delegate = self
        DDWebViewScriptMessageManager.shared.register(message: AlertScriptMessage())

        self.view.addSubview(self.webView)


    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController :DDWebViewScriptMessageProtocol {
    func run(_ script: String, _ completionHandler: ((Any?, Error?) -> Void)?) {

    }

    var viewController: UIViewController? {
        return self
    }

    var webview: WKWebView? {
        return self.webView
    }


}
