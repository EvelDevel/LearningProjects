//
//  ViewController.swift
//  04-EasyBrowser
//
//  Created by Евгений Никитин on 30.10.2021.
//

import UIKit
import WebKit

class ViewController: UIViewController {
    
    var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: Privates
extension ViewController {
    
    private func setup() {
        setupWebView()
        loadContent()
        setupNavigationItem()
    }
    
    private func setupWebView() {
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    private func setupNavigationItem() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Open",
            style: .plain,
            target: self,
            action: #selector(openTapped))
    }
    
    @objc private func openTapped() {
        let ac = UIAlertController(
            title: "Open page ...",
            message: nil,
            preferredStyle: .actionSheet)
        
        ac.addAction(UIAlertAction(
            title: "apple.com",
            style: .default,
            handler: openPage))
        
        ac.addAction(UIAlertAction(
            title: "hackingwithswift.com",
            style: .default,
            handler: openPage))
        
        ac.addAction(UIAlertAction(
            title: "Cancel",
            style: .cancel))
        
        /// Where this action sheet be anchored on iPads
        ac.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
        
        present(ac, animated: true)
    }
    
    private func openPage(action: UIAlertAction) {
        guard let actionTitle = action.title else { return }
        guard let url = URL(string: "https://" + actionTitle) else { return }
        webView.load(URLRequest(url: url))
    }
}


// MARK: Delegate methods
extension ViewController: WKNavigationDelegate {
    
    private func loadContent() {
        let url = URL(string: "https://hackingwithswift.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
