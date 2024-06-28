//
//  ClassicViewController.swift
//  Currency
//
//

import UIKit
import WebKit

final class ClassicViewController: UIViewController {
    
// MARK: - Properties
    
    private var webView: WKWebView!
    
// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView = WKWebView(frame: view.frame)
        view.addSubview(webView)
        
        if let url = URL(string: "https://www.google.com") {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
}
