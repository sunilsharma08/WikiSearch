//
//  WikiPageViewController.swift
//  WikiSearch
//
//  Created by Sunil on 18/08/18.
//  Copyright © 2018 Sunil Sharma. All rights reserved.
//

import UIKit
import WebKit

class WikiPageViewController: UIViewController {

    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var wikiWebView: WKWebView!
    var presenter: WPPresenterInterface!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        customiseNavigationController()
        addWebView()
        presenter.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.shouldRemoveShadow(false)
    }
    
    func customiseNavigationController() {
        navigationController?.isNavigationBarHidden = false
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: nil, style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.barTintColor = AppColors.navBackground
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: AppColors.navText]
        
    }
    
    func addWebView() {
        let webConfiguration = WKWebViewConfiguration()
        wikiWebView = WKWebView(frame: self.view.frame, configuration: webConfiguration)
        wikiWebView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        wikiWebView.uiDelegate = self
        wikiWebView.navigationDelegate = self
        self.view.addSubview(wikiWebView)
        self.view.bringSubview(toFront: activityIndicatorView)
    }

    func setLoadingVisible(_ visible: Bool) {
        if visible {
            activityIndicatorView.startAnimating()
        } else {
            activityIndicatorView.stopAnimating()
        }
    }
}

extension WikiPageViewController: WKUIDelegate, WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        setLoadingVisible(true)
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        setLoadingVisible(false)
    }
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        presenter.failToLoadWikiPage(withError: error)
        setLoadingVisible(false)
    }
}

extension WikiPageViewController: WPViewInterface {
    
    func loadWikiPageWith(url: URL) {
        var request = URLRequest(url: url)
        request.cachePolicy = .returnCacheDataElseLoad
        wikiWebView.load(request)
    }
    
    func updateViewTitle(string: String) {
        self.navigationItem.title = string
    }
}
