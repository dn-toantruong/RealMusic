//
//  UserViewController.swift
//  RealMusic
//
//  Created by asiantech on 9/13/16.
//  Copyright © 2016 asiantech. All rights reserved.
//

import UIKit

class UserViewController: RMViewController {

    @IBOutlet weak var webView: UIWebView!
    var userUrlString = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func setupUI() {
        super.setupUI()
    }
    
    override func setupData() {
        super.setupData()
        let url = NSURL(string: userUrlString as String)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
}
