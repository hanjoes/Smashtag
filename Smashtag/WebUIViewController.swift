//
//  WebUIViewController.swift
//  Smashtag
//
//  Created by Hanzhou Shi on 1/17/16.
//  Copyright © 2016 USF. All rights reserved.
//

import UIKit

class WebUIViewController: UIViewController, UIWebViewDelegate {
    @IBOutlet weak var webView: UIWebView!
    @IBOutlet weak var goBackButton: UIBarButtonItem!
    @IBOutlet weak var goForwardButton: UIBarButtonItem!
    
    @IBAction func goBack(sender: UIBarButtonItem) {
        webView.goBack()
    }
    @IBAction func goForward(sender: UIBarButtonItem) {
        webView.goForward()
    }
    
    // MARK: - Live Cycle
    
    override func viewDidLoad() {
        if url != nil {
            loadPage()
        }
        webView.delegate = self
    }
    
    // MARK: - Delegate for UIWebView
    
    func webViewDidFinishLoad(webView: UIWebView) {
        goBackButton.enabled = self.webView.canGoBack
        goForwardButton.enabled = self.webView.canGoForward
    }

    var url: NSURL? {
        didSet {
            if url != nil {
                loadPage()
            }
        }
    }
    
    private func loadPage() {
        webView?.loadRequest(NSURLRequest(URL: url!))
        
    }
}
