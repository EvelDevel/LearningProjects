//
//  DetailViewController.swift
//  07-WhitehousePetitions
//
//  Created by Евгений Никитин on 05.11.2021.
//

import UIKit
import WebKit

class DetailViewController: UIViewController {

    var webView: WKWebView!
    var detailItem: Petition?
    
    override func loadView() {
        setupWebView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}


// MARK: Privates
extension DetailViewController {
    
    private func setup() {
        showDetailItem()
    }
    
    private func setupWebView() {
        webView = WKWebView()
        view = webView
    }
    
    private func showDetailItem() {
        guard let detailItem = detailItem else { return }
        
        let html = """
        <html>
        <head>
        <meta name ="viewport" content="width=device-width, initial-scale=1">
        <style> body { font-size: 150%; } </style>
        </head>
        <body>
        \(detailItem.body)
        </body>
        </html>
        """
        
        webView.loadHTMLString(html, baseURL: nil)
    }
}
