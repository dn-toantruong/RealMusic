//
//  RMViewController.swift
//  RealMusic
//
//  Created by asiantech on 8/25/16.
//  Copyright © 2016 asiantech. All rights reserved.
//

import UIKit

class RMViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Setup
    func setupUI() { }
    
    func setupData() { }
    
    // MARK: - Public
//    func showLoading() {
//        SVProgressHUD.showWithMaskType(SVProgressHUDMaskType.Clear)
//    }
//    
//    func hideLoading() {
//        SVProgressHUD.dismiss()
//    }
    
    func showAlertWith(mTitle: String, message: String, completion: (action: AnyObject) -> ()) {
        let alertController = UIAlertController(title: mTitle, message: message, preferredStyle: .Alert)
        let action = UIAlertAction(title: ALERT_BUTTON_DEFAULT, style: .Default) { (action) -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
            completion(action: action)
        }
        alertController.addAction(action)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func showAlertWith(mTitle: String, message: String, button1: String, button2: String, completion1: (action: AnyObject) -> (), completion2: (action: AnyObject) -> ()) {
        let alertController = UIAlertController(title: mTitle, message: message, preferredStyle: .Alert)
        let action1 = UIAlertAction(title: button1, style: .Default) { (action) -> Void in
            alertController.dismissViewControllerAnimated(true, completion: nil)
            completion1(action: action)
        }
        let action2 = UIAlertAction(title: button2, style: .Default) { (action) -> Void in
            completion2(action: action)
        }
        alertController.addAction(action1)
        alertController.addAction(action2)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func delay(delay: Double, closure: () -> ()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    // MARK: - Action
    @IBAction func back(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func close(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}
