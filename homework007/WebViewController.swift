//
//  WebViewController.swift
//  homework008
//
//  Created by FISH on 2018/12/9.
//  Copyright © 2018年 FISH. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    var urlStr: String?
    @IBOutlet weak var web: WKWebView!
    @IBOutlet weak var loading: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        web.navigationDelegate = self

        if let urlStr = urlStr, let url = URL(string: urlStr) {
            let request = URLRequest(url: url)
            web.load(request)
        }
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        loading.stopAnimating()
    }

//    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//        loading.stopAnimating()
//    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
