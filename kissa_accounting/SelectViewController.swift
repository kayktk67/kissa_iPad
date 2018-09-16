//
//  SelectViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/09/10.
//  Copyright © 2018年 Kei Kawamura. All rights reserved.
//

import Foundation
import UIKit
class SelectViewController : UIViewController{
    
    
    @IBAction func toInAccounting(_ sender: Any) {
        performSegue(withIdentifier: "toinaccounting", sender: nil)
    }
    @IBAction func toAccounting(_ sender: Any) {
        performSegue(withIdentifier: "toaccounting", sender: nil)
    }
    @IBAction func toOrderList(_ sender: Any) {
        performSegue(withIdentifier: "toorderlist", sender: nil)
    }
    
    @IBAction func toDDOrderList(_ sender: Any) {
        performSegue(withIdentifier: "toddorderlist", sender: nil)
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
