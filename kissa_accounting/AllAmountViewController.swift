//
//  AllAmountViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/11/03.
//  Copyright © 2018 Kei Kawamura. All rights reserved.
//

import UIKit
import Firebase
class AllAmountViewController: UIViewController{
    var DBRef : DatabaseReference!
    @IBOutlet weak var AllB1AmountLabel: UILabel!
    @IBOutlet weak var AllS1AmountLabel: UILabel!
    @IBOutlet weak var AllS2AmountLabel: UILabel!
    @IBOutlet weak var AllS3AmountLabel: UILabel!
    @IBOutlet weak var AllD1AmountLabel: UILabel!
    @IBOutlet weak var AllD3AmountLabel: UILabel!
    @IBOutlet weak var AllD4AmountLabel: UILabel!
    @IBOutlet weak var AllDX1AmountLabel: UILabel!
    @IBOutlet weak var AllDX2AmountLabel: UILabel!
    @IBOutlet weak var AllDX3AmountLabel: UILabel!
    @IBOutlet weak var AllDX4AmountLabel: UILabel!
    @IBOutlet weak var AllDe1AmountLabel: UILabel!
    @IBOutlet weak var AllDe2AmountLabel: UILabel!
    @IBOutlet weak var AllDe3AmountLabel: UILabel!
    @IBOutlet weak var AllDe4AmountLabel: UILabel!
    @IBOutlet weak var AllSBAmountLabel: UILabel!
    
    @IBOutlet weak var B3AmountLabel: UILabel!
    @IBOutlet weak var B4AmountLabel: UILabel!
    @IBOutlet weak var TS1AmountLabel: UILabel!
    @IBOutlet weak var TS2AmountLabel: UILabel!
    @IBOutlet weak var TS3AmountLabel: UILabel!
    @IBOutlet weak var TD1AmountLabel: UILabel!
    @IBOutlet weak var TD3AmountLabel: UILabel!
    @IBOutlet weak var TD4AmountLabel: UILabel!
    @IBOutlet weak var TDX3AmountLabel: UILabel!
    @IBOutlet weak var TDX4AmountLabel: UILabel!
    @IBOutlet weak var AllCookieAmount: UILabel!
    
    @IBOutlet weak var InProceeds: UILabel!
    @IBOutlet weak var ToProceeds: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()
        allamountload()
    }
    
    func allamountload(){
        let defaultPlace10 = self.DBRef.child("table/allorder/allb1amount")
        defaultPlace10.observe(.value) { (snap: DataSnapshot) in
            self.AllB1AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace12 = self.DBRef.child("table/allorder/alls1amount")
        defaultPlace12.observe(.value) { (snap: DataSnapshot) in
            self.AllS1AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace26 = self.DBRef.child("table/allorder/alls2amount")
        defaultPlace26.observe(.value) { (snap: DataSnapshot) in
            self.AllS2AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace27 = self.DBRef.child("table/allorder/alls3amount")
        defaultPlace27.observe(.value) { (snap: DataSnapshot) in
            self.AllS3AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace13 = self.DBRef.child("table/allorder/alld1amount")
        defaultPlace13.observe(.value) { (snap: DataSnapshot) in
            self.AllD1AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace15 = self.DBRef.child("table/allorder/alld3amount")
        defaultPlace15.observe(.value) { (snap: DataSnapshot) in
            self.AllD3AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace16 = self.DBRef.child("table/allorder/alld4amount")
        defaultPlace16.observe(.value) { (snap: DataSnapshot) in
            self.AllD4AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace28 = self.DBRef.child("table/allorder/alldx1amount")
        defaultPlace28.observe(.value) { (snap: DataSnapshot) in
            self.AllDX1AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace29 = self.DBRef.child("table/allorder/alldx2amount")
        defaultPlace29.observe(.value) { (snap: DataSnapshot) in
            self.AllDX2AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace30 = self.DBRef.child("table/allorder/alldx3amount")
        defaultPlace30.observe(.value) { (snap: DataSnapshot) in
            self.AllDX3AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace31 = self.DBRef.child("table/allorder/alldx4amount")
        defaultPlace31.observe(.value) { (snap: DataSnapshot) in
            self.AllDX4AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace17 = self.DBRef.child("table/allorder/allde1amount")
        defaultPlace17.observe(.value) { (snap: DataSnapshot) in
            self.AllDe1AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace18 = self.DBRef.child("table/allorder/allde2amount")
        defaultPlace18.observe(.value) { (snap: DataSnapshot) in
            self.AllDe2AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace19 = self.DBRef.child("table/allorder/allde3amount")
        defaultPlace19.observe(.value) { (snap: DataSnapshot) in
            self.AllDe3AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace34 = self.DBRef.child("table/allorder/allde4amount")
        defaultPlace34.observe(.value) { (snap: DataSnapshot) in
            self.AllDe4AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlace32 = self.DBRef.child("table/allorder/allsbamount")
        defaultPlace32.observe(.value) { (snap: DataSnapshot) in
            self.AllSBAmountLabel.text = (snap.value! as AnyObject).description
        }
        
        let defaultPlacex8 = self.DBRef.child("table/allorder/allb3amount")
        defaultPlacex8.observe(.value) { (snap: DataSnapshot) in
            self.B3AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex9 = self.DBRef.child("table/allorder/allb4amount")
        defaultPlacex9.observe(.value) { (snap: DataSnapshot) in
            self.B4AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex10 = self.DBRef.child("table/allorder/allts1amount")
        defaultPlacex10.observe(.value) { (snap: DataSnapshot) in
            self.TS1AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex17 = self.DBRef.child("table/allorder/allts2amount")
        defaultPlacex17.observe(.value) { (snap: DataSnapshot) in
            self.TS2AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex18 = self.DBRef.child("table/allorder/allts3amount")
        defaultPlacex18.observe(.value) { (snap: DataSnapshot) in
            self.TS3AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex11 = self.DBRef.child("table/allorder/alltd1amount")
        defaultPlacex11.observe(.value) { (snap: DataSnapshot) in
            self.TD1AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex13 = self.DBRef.child("table/allorder/alltd3amount")
        defaultPlacex13.observe(.value) { (snap: DataSnapshot) in
            self.TD3AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex14 = self.DBRef.child("table/allorder/alltd4amount")
        defaultPlacex14.observe(.value) { (snap: DataSnapshot) in
            self.TD4AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex32 = self.DBRef.child("table/allorder/alltdx3amount")
        defaultPlacex32.observe(.value) { (snap: DataSnapshot) in
            self.TDX3AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex33 = self.DBRef.child("table/allorder/alltdx4amount")
        defaultPlacex33.observe(.value) { (snap: DataSnapshot) in
            self.TDX4AmountLabel.text = (snap.value! as AnyObject).description
        }
        let defaultPlacex35 = self.DBRef.child("table/allorder/allcookieamount")
        defaultPlacex35.observe(.value) { (snap: DataSnapshot) in
            self.AllCookieAmount.text = (snap.value! as AnyObject).description
        }
        let defaultPlaceXX7 = self.DBRef.child("inproceeds")
        defaultPlaceXX7.observe(.value) { (snap: DataSnapshot) in
            self.InProceeds.text = (snap.value! as AnyObject).description
        }
        let defaultPlaceXX34 = self.DBRef.child("toproceeds")
        defaultPlaceXX34.observe(.value) { (snap: DataSnapshot) in
            self.ToProceeds.text = (snap.value! as AnyObject).description
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
