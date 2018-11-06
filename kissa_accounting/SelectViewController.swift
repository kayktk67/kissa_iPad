//
//  SelectViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/09/10.
//  Copyright © 2018年 Kei Kawamura. All rights reserved.
//

import Foundation
import UIKit
import SwiftyDropbox
class SelectViewController : UIViewController{
    
    @IBAction func toInAccounting(_ sender: Any) {
        performSegue(withIdentifier: "toinaccounting", sender: nil)
    }
    @IBAction func toAccounting(_ sender: Any) {
        performSegue(withIdentifier: "toaccounting", sender: nil)
    }
    @IBAction func toComplete(_ sender: Any) {
        performSegue(withIdentifier: "tocompleteviewcontroller", sender: nil)
    }
    @IBAction func toAllAmount(_ sender: Any) {
        performSegue(withIdentifier: "toallamount", sender: nil)
    }
    
    @IBAction func dropbox(_ sender: Any) {
        DropboxClientsManager.authorizeFromController(UIApplication.shared,controller: self,openURL: { (url: URL) -> Void in
            UIApplication.shared.openURL(url)
        })
    }
    
    @IBAction func upload(_ sender: Any) {
        guard let client = DropboxClientsManager.authorizedClient else {
            return
        }
        let fileData = "testing data example".data(using: String.Encoding.utf8, allowLossyConversion: false)!
        
        _ = client.files.upload(path:"/Data/myUploadTestFile.txt", input: fileData)
            .response { response, error in
                if let response = response {
                    print(response)
                }else if let error = error {
                    print(error)
                }
            }
            .progress { progressData in
                print(progressData)
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
