//
//  InFinishViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/10/06.
//  Copyright © 2018 Kei Kawamura. All rights reserved.
//

import Foundation
import UIKit
import Firebase
import SwiftyDropbox
class InFinishViewController: UIViewController{
    var DBRef : DatabaseReference!
    var tableNumber : String?
    var GetMoneySum = "0"
    var C1Sum = "0"
    var C3Sum = "0"
    var C10Sum = "0"
    var dateUnix: TimeInterval = 0
    var hogetime = "0"
    var Border : String?
    var Sorder : String?
    var BSorder : String?
    var CPrice = 0
    
    @IBOutlet weak var tableNumberLabel: UILabel!
    
    @IBOutlet weak var C1Amount: UILabel!
    @IBOutlet weak var C3Amount: UILabel!
    @IBOutlet weak var C10Amount: UILabel!
    @IBOutlet weak var C1StepperValue: UIStepper!
    @IBOutlet weak var C3StepperValue: UIStepper!
    @IBOutlet weak var C10StepperValue: UIStepper!
    @IBOutlet weak var AllC1Amount: UILabel!
    @IBOutlet weak var AllC3Amount: UILabel!
    @IBOutlet weak var AllC10Amount: UILabel!
    @IBOutlet weak var BSetOrderAmount: UILabel!
    @IBOutlet weak var SSetOrderAmount: UILabel!
    @IBOutlet weak var BSSetOrderAmount: UILabel!
    @IBOutlet weak var BSetRemainAmount: UILabel!
    @IBOutlet weak var SSetRemainAmount: UILabel!
    @IBOutlet weak var BSSetRemainAmount: UILabel!
    @IBOutlet weak var BSetAccountingAmount: UILabel!
    @IBOutlet weak var SSetAccountingAmount: UILabel!
    @IBOutlet weak var BSSetAccountingAmount: UILabel!
    
    @IBOutlet weak var BSetAccountingStepper: UIStepper!
    @IBOutlet weak var SSetAccountingStepper: UIStepper!
    @IBOutlet weak var BSSetAccountingStepper: UIStepper!
    
    @IBOutlet weak var SumMoneyAmount: UILabel!
    @IBOutlet weak var GetMoneyAmount: UILabel!
    @IBOutlet weak var BackMoneyAmount: UILabel!
    
    
    @IBAction func C1Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        C1Amount.text = "\(Amount)"
        CPrice = Int(C1Amount.text!)!*150 + Int(C3Amount.text!)!*400 + Int(C10Amount.text!)!*1200
        SumMoneyAmount.text = "\(Int(BSetAccountingStepper.value)*600 + Int(SSetAccountingStepper.value)*600 + Int(BSSetAccountingStepper.value)*800 + CPrice)"
    }
    @IBAction func C3Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        C3Amount.text = "\(Amount)"
        CPrice = Int(C1Amount.text!)!*150 + Int(C3Amount.text!)!*400 + Int(C10Amount.text!)!*1200
        SumMoneyAmount.text = "\(Int(BSetAccountingStepper.value)*600 + Int(SSetAccountingStepper.value)*600 + Int(BSSetAccountingStepper.value)*800 + CPrice)"
    }
    @IBAction func C10Stepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        C10Amount.text = "\(Amount)"
        CPrice = Int(C1Amount.text!)!*150 + Int(C3Amount.text!)!*400 + Int(C10Amount.text!)!*1200
        SumMoneyAmount.text = "\(Int(BSetAccountingStepper.value)*600 + Int(SSetAccountingStepper.value)*600 + Int(BSSetAccountingStepper.value)*800 + CPrice)"
    }
    
    @IBAction func BSetStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        if Amount > Int(BSetRemainAmount.text!)!{
            BSetAccountingStepper.value = Double(Int(BSetRemainAmount.text!)!)
        }else{
        BSetAccountingAmount.text = "\(Amount)"
        SumMoneyAmount.text = "\(Int(BSetAccountingStepper.value)*600 + Int(SSetAccountingStepper.value)*600 + Int(BSSetAccountingStepper.value)*800 + CPrice)"
        }
    }
    @IBAction func SSetStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        if Amount > Int(SSetRemainAmount.text!)!{
            SSetAccountingStepper.value = Double(Int(SSetRemainAmount.text!)!)
        }else{
            SSetAccountingAmount.text = "\(Amount)"
            SumMoneyAmount.text = "\(Int(BSetAccountingStepper.value)*600 + Int(SSetAccountingStepper.value)*600 + Int(BSSetAccountingStepper.value)*800 + CPrice)"
        }
    }
    @IBAction func BSSetStepper(_ sender: UIStepper) {
        let Amount = Int(sender.value)
        if Amount > Int(BSSetRemainAmount.text!)!{
            BSSetAccountingStepper.value = Double(Int(BSSetRemainAmount.text!)!)
        }else{
            BSSetAccountingAmount.text = "\(Amount)"
            SumMoneyAmount.text = "\(Int(BSetAccountingStepper.value)*600 + Int(SSetAccountingStepper.value)*600 + Int(BSSetAccountingStepper.value)*800 + CPrice)"
        }
    }
    
    @IBAction func all(_ sender: Any) {
        BSetAccountingAmount.text = BSetRemainAmount.text
        BSetAccountingStepper.value = Double(Int(BSetRemainAmount.text!)!)
        SSetAccountingAmount.text = SSetRemainAmount.text
        SSetAccountingStepper.value = Double(Int(SSetRemainAmount.text!)!)
        BSSetAccountingAmount.text = BSSetRemainAmount.text
        BSSetAccountingStepper.value = Double(Int(BSSetRemainAmount.text!)!)
        SumMoneyAmount.text = "\(Int(BSetAccountingStepper.value)*600 + Int(SSetAccountingStepper.value)*600 + Int(BSSetAccountingStepper.value)*800 + CPrice)"
    }
    
    @IBAction func number(_ sender: UIButton) {
        if GetMoneyAmount.text == "0"{
            if sender.titleLabel!.text != "00"{
                GetMoneyAmount.text = ""
                GetMoneyAmount.text! += sender.titleLabel!.text!
            }
        }else if sender.titleLabel!.text == "00"{
            if Int(GetMoneyAmount.text!)!<1000{
                GetMoneyAmount.text! += sender.titleLabel!.text!
            }
        }else{
            if Int(GetMoneyAmount.text!)!<10000{
                GetMoneyAmount.text! += sender.titleLabel!.text!
            }
        }
    }
    
    @IBAction func clear(_ sender: Any) {
        GetMoneyAmount.text = "0"
        BackMoneyAmount.text = "0"
    }
    
    @IBAction func backmoney(_ sender: Any) {
        BackMoneyAmount.text = "\(Int(GetMoneyAmount.text!)!-Int(SumMoneyAmount.text!)!)"
    }
    
    @IBAction func separate(_ sender: Any) {
        BackMoneyAmount.text = "\(Int(GetMoneyAmount.text!)!-Int(SumMoneyAmount.text!)!)"
        let alertController = UIAlertController(title: "会計処理",message: "実行しますか？", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            //お釣り表示・各種初期化
            let alertController = UIAlertController(title: "お釣りは\(String(describing: self.BackMoneyAmount.text!))円です",message: "", preferredStyle: UIAlertController.Style.alert)
            let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                //レシート印刷機能
                var hogekey : String?
                let defaultPlace = self.DBRef.child("table/orderkey").child(self.tableNumber!)
                defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in hogekey = (snapshot.value! as AnyObject).description
                guard let client = DropboxClientsManager.authorizedClient else {
                    return}
                let fileData = "\(self.hogetime),\(self.tableNumber!),/\(hogekey!)/,\(self.BSetAccountingAmount.text!),\(self.SSetAccountingAmount.text!),\(self.BSSetAccountingAmount.text!),\(self.C1Amount.text!),\(self.C3Amount.text!),\(self.C10Amount.text!),\(self.GetMoneyAmount.text!)".data(using: String.Encoding.utf8, allowLossyConversion: false)!
                _ = client.files.deleteV2(path: "/Data/receipt.csv")
                        .response{ response, error in
                        if let response = response {
                            print(response)
                        }else if let error = error {
                            print(error)
                        }
                }
                _ = client.files.upload(path:"/Data/receipt.csv", input: fileData)
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
                    self.GetMoneySum = "\(Int(self.GetMoneySum)! + Int(self.GetMoneyAmount.text!)!)"
                    self.C1Sum = "\(Int(self.C1Sum)! + Int(self.C1Amount.text!)!)"
                    self.C3Sum = "\(Int(self.C3Sum)! + Int(self.C3Amount.text!)!)"
                    self.C10Sum = "\(Int(self.C10Sum)! + Int(self.C10Amount.text!)!)"
                    //全食数の更新
                    self.DBRef.child("table/allorder/allc1amount").setValue(Int(self.AllC1Amount.text!)!-Int(self.C1Amount.text!)!)
                    self.DBRef.child("table/allorder/allc3amount").setValue(Int(self.AllC3Amount.text!)!-Int(self.C3Amount.text!)!)
                    self.DBRef.child("table/allorder/allc10amount").setValue(Int(self.AllC10Amount.text!)!-Int(self.C10Amount.text!)!)
                    let BSet = Int(self.BSetRemainAmount.text!)!-Int(self.BSetAccountingAmount.text!)!
                    self.BSetRemainAmount.text = String(BSet)
                    let SSet = Int(self.SSetRemainAmount.text!)!-Int(self.SSetAccountingAmount.text!)!
                    self.SSetRemainAmount.text = String(SSet)
                    let BSSet = Int(self.BSSetRemainAmount.text!)!-Int(self.BSSetAccountingAmount.text!)!
                    self.BSSetRemainAmount.text = String(BSSet)
                    self.C1Amount.text = "0"
                    self.C1StepperValue.value = 0
                    self.C3Amount.text = "0"
                    self.C3StepperValue.value = 0
                    self.C10Amount.text = "0"
                    self.C10StepperValue.value = 0
                    self.BSetAccountingAmount.text = "0"
                    self.BSetAccountingStepper.value = 0
                    self.SSetAccountingAmount.text = "0"
                    self.SSetAccountingStepper.value = 0
                    self.BSSetAccountingAmount.text = "0"
                    self.BSSetAccountingStepper.value = 0
                    self.SumMoneyAmount.text = "0"
                    self.GetMoneyAmount.text = "0"
                    self.BackMoneyAmount.text = "0"
                    self.CPrice = 0
                
                //会計終了判定
                if self.BSetRemainAmount.text == "0",self.SSetRemainAmount.text == "0",self.BSSetRemainAmount.text == "0"{
                    let alertController = UIAlertController(title: "会計が終了しました",message: "", preferredStyle: UIAlertController.Style.alert)
                    let OKButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                            var hogekey : String?
                            let defaultPlace = self.DBRef.child("table/orderkey").child(self.tableNumber!)
                            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in hogekey = (snapshot.value! as AnyObject).description
                        self.DBRef.child("indata").child(hogekey!).updateChildValues(["exittime":ServerValue.timestamp(),"c1":self.C1Sum,"c3":self.C3Sum,"c10":self.C10Sum])
                            self.DBRef.child("table/orderorder").child(hogekey!).setValue(nil)
                            self.DBRef.child("table/orderkey").child(self.tableNumber!).setValue(nil)
                        })
                        self.DBRef.child("table/order").child(self.tableNumber!).setValue(["b1amount":0,"b3amount":0,"b4amount":0,"s1amount":0,"s2amount":0,"s3amount":0,"d1amount":0,"d2amount":0,"d3amount":0,"d4amount":0,"dx1amount":0,"dx2amount":0,"dx3amount":0,"dx4amount":0,"de1amount":0,"de2amount":0,"de3amount":0,"time":0])
                        self.DBRef.child("table/status").child(self.tableNumber!).setValue(0)
                        self.DBRef.child("table/bstatus").child(self.tableNumber!).setValue(0)
                        self.DBRef.child("table/tbstatus").child(self.tableNumber!).setValue(0)
                        self.DBRef.child("table/sstatus").child(self.tableNumber!).setValue(0)
                        self.DBRef.child("table/dstatus").child(self.tableNumber!).setValue(0)
                        self.DBRef.child("table/dxstatus").child(self.tableNumber!).setValue(0)
                        self.DBRef.child("table/destatus").child(self.tableNumber!).setValue(0)
                        self.DBRef.child("table/setamount").child(self.tableNumber!).setValue(["bset":0,"sset":0,"bsset":0])
                    }
                    alertController.addAction(OKButton)
                    self.present(alertController,animated: true,completion: nil)
                }
                })
            }
            alertController.addAction(OKButton)
            self.present(alertController,animated: true,completion: nil)
        }
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        present(alertController,animated: true,completion: nil)
    }
    
 
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()
        
        Timer.scheduledTimer(
            timeInterval: 0.1,
            target: self,
            selector: #selector(self.amountload(_:)),
            userInfo: nil,
            repeats: false
        )
    }
    
    @objc func amountload(_ sender: Timer) {
        let defaultPlace = DBRef.child("table/setamount").child(tableNumber!).child("bset")
        defaultPlace.observe(.value) { (snap: DataSnapshot) in self.BSetOrderAmount.text = (snap.value! as AnyObject).description}
        defaultPlace.observe(.value) { (snap: DataSnapshot) in self.BSetRemainAmount.text = (snap.value! as AnyObject).description}
        defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in self.Border = (snapshot.value! as AnyObject).description})
        let defaultPlace2 = DBRef.child("table/setamount").child(tableNumber!).child("sset")
        defaultPlace2.observe(.value) { (snap: DataSnapshot) in self.SSetOrderAmount.text = (snap.value! as AnyObject).description}
        defaultPlace2.observe(.value) { (snap: DataSnapshot) in self.SSetRemainAmount.text = (snap.value! as AnyObject).description}
        defaultPlace2.observeSingleEvent(of: .value, with: { (snapshot) in self.Sorder = (snapshot.value! as AnyObject).description})
        let defaultPlace3 = DBRef.child("table/setamount").child(tableNumber!).child("bsset")
        defaultPlace3.observe(.value) { (snap: DataSnapshot) in self.BSSetOrderAmount.text = (snap.value! as AnyObject).description}
        defaultPlace3.observe(.value) { (snap: DataSnapshot) in self.BSSetRemainAmount.text = (snap.value! as AnyObject).description}
        defaultPlace3.observeSingleEvent(of: .value, with: { (snapshot) in self.BSorder = (snapshot.value! as AnyObject).description})
        
        
        let defaultPlace4 = self.DBRef.child("table/allorder/allc1amount")
        defaultPlace4.observe(.value) { (snap: DataSnapshot) in
            self.AllC1Amount.text = (snap.value! as AnyObject).description
        }
        let defaultPlace5 = self.DBRef.child("table/allorder/allc3amount")
        defaultPlace5.observe(.value) { (snap: DataSnapshot) in
            self.AllC3Amount.text = (snap.value! as AnyObject).description
        }
        let defaultPlace6 = self.DBRef.child("table/allorder/allc10amount")
        defaultPlace6.observe(.value) { (snap: DataSnapshot) in
            self.AllC10Amount.text = (snap.value! as AnyObject).description
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
