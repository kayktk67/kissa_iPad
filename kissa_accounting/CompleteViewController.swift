//
//  CompleteViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/09/29.
//  Copyright © 2018 Kei Kawamura. All rights reserved.
//

import UIKit
import Firebase
class CompleteViewController: UIViewController ,UICollectionViewDataSource,
UICollectionViewDelegate {
    
    let number = ["001","002","003","004","005","006","007","008","009","010","011","012","013","014","015"]
    // インスタンス変数
    var DBRef:DatabaseReference!
    var dateUnix: TimeInterval = 0
    var hogetime = Array(repeating: "0", count: 20)
    var hogetime2 = Array(repeating: "0", count: 20)
    var status = Array(repeating: "0", count: 20)
    var intstatus = Array(repeating: 0, count: 20)
    var bstatus = Array(repeating: "0", count: 20)
    var sstatus = Array(repeating: "0", count: 20)
    var dstatus = Array(repeating: "0", count: 20)
    var dxstatus = Array(repeating: "0", count: 20)
    var destatus = Array(repeating: "0", count: 20)
    var b1amount = Array(repeating: "0", count: 20)
    var s1amount = Array(repeating: "0", count: 20)
    var s2amount = Array(repeating: "0", count: 20)
    var s3amount = Array(repeating: "0", count: 20)
    var d1amount = Array(repeating: "0", count: 20)
    var d3amount = Array(repeating: "0", count: 20)
    var d4amount = Array(repeating: "0", count: 20)
    var dx1amount = Array(repeating: "0", count: 20)
    var dx2amount = Array(repeating: "0", count: 20)
    var dx3amount = Array(repeating: "0", count: 20)
    var dx4amount = Array(repeating: "0", count: 20)
    var de1amount = Array(repeating: "0", count: 20)
    var de2amount = Array(repeating: "0", count: 20)
    var de3amount = Array(repeating: "0", count: 20)
    var sbamount = Array(repeating: "0", count: 20)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let Cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InCell", for: indexPath)
        let tablelabel = Cell.contentView.viewWithTag(1) as! UILabel
        let timelabel = Cell.contentView.viewWithTag(2) as! UILabel
        let b1amountlabel = Cell.contentView.viewWithTag(3) as! UILabel
        let s1amountlabel = Cell.contentView.viewWithTag(12) as! UILabel
        let s2amountlabel = Cell.contentView.viewWithTag(13) as! UILabel
        let s3amountlabel = Cell.contentView.viewWithTag(14) as! UILabel
        let d1amountlabel = Cell.contentView.viewWithTag(5) as! UILabel
        let d3amountlabel = Cell.contentView.viewWithTag(7) as! UILabel
        let d4amountlabel = Cell.contentView.viewWithTag(8) as! UILabel
        let dx1amountlabel = Cell.contentView.viewWithTag(15) as! UILabel
        let dx2amountlabel = Cell.contentView.viewWithTag(16) as! UILabel
        let dx3amountlabel = Cell.contentView.viewWithTag(17) as! UILabel
        let dx4amountlabel = Cell.contentView.viewWithTag(18) as! UILabel
        let de1amountlabel = Cell.contentView.viewWithTag(9) as! UILabel
        let de2amountlabel = Cell.contentView.viewWithTag(10) as! UILabel
        let de3amountlabel = Cell.contentView.viewWithTag(11) as! UILabel
        let sbamountlabel = Cell.contentView.viewWithTag(6) as! UILabel
        let Statuslabel = Cell.contentView.viewWithTag(21) as! UILabel
        let BStatuslabel = Cell.contentView.viewWithTag(22) as! UILabel
        let SStatuslabel = Cell.contentView.viewWithTag(23) as! UILabel
        let DStatuslabel = Cell.contentView.viewWithTag(24) as! UILabel
        let DXStatuslabel = Cell.contentView.viewWithTag(26) as! UILabel
        let DeStatuslabel = Cell.contentView.viewWithTag(25) as! UILabel
        
        tablelabel.text = "Table" + number[indexPath.row]
        timelabel.textAlignment = .right
        sbamountlabel.text =  self.sbamount[indexPath.row]
        b1amountlabel.text =  self.b1amount[indexPath.row]
        s1amountlabel.text =  self.s1amount[indexPath.row]
        s2amountlabel.text =  self.s2amount[indexPath.row]
        s3amountlabel.text =  self.s3amount[indexPath.row]
        d1amountlabel.text =  self.d1amount[indexPath.row]
        d3amountlabel.text =  self.d3amount[indexPath.row]
        d4amountlabel.text =  self.d4amount[indexPath.row]
        dx1amountlabel.text =  self.dx1amount[indexPath.row]
        dx2amountlabel.text =  self.dx2amount[indexPath.row]
        dx3amountlabel.text =  self.dx3amount[indexPath.row]
        dx4amountlabel.text =  self.dx4amount[indexPath.row]
        de1amountlabel.text =  self.de1amount[indexPath.row]
        de2amountlabel.text =  self.de2amount[indexPath.row]
        de3amountlabel.text =  self.de3amount[indexPath.row]
        
        if Int(self.hogetime[indexPath.row]) == 0 {
            timelabel.text = ""
        }else{
            if self.intstatus[indexPath.row] == 1 || self.intstatus[indexPath.row] == 2 || self.intstatus[indexPath.row] == 4{
                self.dateUnix = TimeInterval(self.hogetime[indexPath.row])!
                let hogedate = NSDate(timeIntervalSince1970: self.dateUnix/1000)
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss"
                timelabel.text = formatter.string(from: hogedate as Date)
            }else if self.intstatus[indexPath.row] == 3{
            var calendar = Calendar.current
            calendar.locale = Locale(identifier: "ja_JP")
            self.dateUnix = TimeInterval(self.hogetime2[indexPath.row])!
            let hogedate = NSDate(timeIntervalSince1970: self.dateUnix/1000)
            let time = Date().timeIntervalSince(hogedate as Date)
            let formatter = DateComponentsFormatter()
            formatter.calendar = calendar
            formatter.unitsStyle = .positional
            formatter.allowedUnits = [.day, .hour, .minute, .second]
            formatter.zeroFormattingBehavior = [.dropLeading]
            timelabel.text = formatter.string(from: time)!
            }
        }
        
        //満席表示
        if intstatus[indexPath.row] == 0{
            Statuslabel.backgroundColor = UIColor.white
        }else if intstatus[indexPath.row] == 1{
            Statuslabel.backgroundColor = UIColor.yellow
        }else if intstatus[indexPath.row] == 2{
            Statuslabel.backgroundColor = UIColor.magenta
        }else if intstatus[indexPath.row] == 3{
            Statuslabel.backgroundColor = UIColor.red
        }else if intstatus[indexPath.row] == 4{
            Statuslabel.backgroundColor = UIColor.cyan
        }
        if Int(self.bstatus[indexPath.row]) == 1{
            BStatuslabel.backgroundColor = UIColor.magenta
        }else if Int(self.bstatus[indexPath.row]) == 2{
            BStatuslabel.backgroundColor = UIColor.cyan
        }else{
            BStatuslabel.backgroundColor = UIColor.white
        }
        if Int(self.sstatus[indexPath.row]) == 1{
            SStatuslabel.backgroundColor = UIColor.magenta
        }else if Int(self.sstatus[indexPath.row]) == 2{
            SStatuslabel.backgroundColor = UIColor.cyan
        }else{
            SStatuslabel.backgroundColor = UIColor.white
        }
        if Int(self.dstatus[indexPath.row]) == 1{
            DStatuslabel.backgroundColor = UIColor.magenta
        }else if Int(self.dstatus[indexPath.row]) == 2{
            DStatuslabel.backgroundColor = UIColor.cyan
        }else{
            DStatuslabel.backgroundColor = UIColor.white
        }
        if Int(self.dxstatus[indexPath.row]) == 1{
            DXStatuslabel.backgroundColor = UIColor.magenta
        }else if Int(self.dxstatus[indexPath.row]) == 2{
            DXStatuslabel.backgroundColor = UIColor.cyan
        }else{
            DXStatuslabel.backgroundColor = UIColor.white
        }
        if Int(self.destatus[indexPath.row]) == 1{
            DeStatuslabel.backgroundColor = UIColor.magenta
        }else if Int(self.destatus[indexPath.row]) == 2{
            DeStatuslabel.backgroundColor = UIColor.cyan
        }else{
            DeStatuslabel.backgroundColor = UIColor.white
        }
        return Cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return number.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if self.intstatus[indexPath.row] == 1 || self.intstatus[indexPath.row] == 2{
            let alertController = UIAlertController(title: "配膳完了（デザート以外）",message: "タイマーセットしますか？", preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
                self.DBRef.child("table/status").child(self.number[indexPath.row]).setValue(3)
                self.DBRef.child("table/order").child(self.number[indexPath.row]).child("completetime").setValue(ServerValue.timestamp())
            }
            let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
            alertController.addAction(okAction)
            alertController.addAction(cancelButton)
            present(alertController,animated: true,completion: nil)
            
        }else if self.intstatus[indexPath.row] == 3{
        let alertController = UIAlertController(title: "配膳完了",message: "実行しますか？", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.DBRef.child("table/status").child(self.number[indexPath.row]).setValue(4)
            self.DBRef.child("table/bstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/tbstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/sstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/dstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/dxstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/destatus").child(self.number[indexPath.row]).setValue(0)
            //オーダーキーのリセット
            var hogekey : String?
            let defaultPlace = self.DBRef.child("table/orderkey").child(self.number[indexPath.row])
            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in
                hogekey = (snapshot.value! as AnyObject).description
                self.DBRef.child("indata").child(hogekey!).updateChildValues(["completetime":ServerValue.timestamp()])
                self.DBRef.child("table/orderorder").child(hogekey!).setValue(nil)
            })
            self.collectionView.reloadData()
        }
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertAction.Style.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        
        present(alertController,animated: true,completion: nil)
        }
    }
    
    @IBAction func BStatus(sender: UIButton) {
        if let indexPath = collectionView.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            if Int(self.bstatus[indexPath.row]) == 1{
            self.DBRef.child("table/bstatus").child(self.number[indexPath.row]).setValue(2)
            }else if Int(self.bstatus[indexPath.row]) == 2{
            self.DBRef.child("table/bstatus").child(self.number[indexPath.row]).setValue(1)
            }
        }
    }
    @IBAction func SStatus(sender: UIButton) {
        if let indexPath = collectionView.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            if Int(self.sstatus[indexPath.row]) == 1{
                self.DBRef.child("table/sstatus").child(self.number[indexPath.row]).setValue(2)
            }else if Int(self.sstatus[indexPath.row]) == 2{
                self.DBRef.child("table/sstatus").child(self.number[indexPath.row]).setValue(1)
            }
        }
    }
    @IBAction func DStatus(sender: UIButton) {
        if let indexPath = collectionView.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            if Int(self.dstatus[indexPath.row]) == 1{
                self.DBRef.child("table/dstatus").child(self.number[indexPath.row]).setValue(2)
            }else if Int(self.dstatus[indexPath.row]) == 2{
                self.DBRef.child("table/dstatus").child(self.number[indexPath.row]).setValue(1)
            }
        }
    }
    @IBAction func DXStatus(sender: UIButton) {
        if let indexPath = collectionView.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            if Int(self.dxstatus[indexPath.row]) == 1{
                self.DBRef.child("table/dxstatus").child(self.number[indexPath.row]).setValue(2)
            }else if Int(self.dxstatus[indexPath.row]) == 2{
                self.DBRef.child("table/dxstatus").child(self.number[indexPath.row]).setValue(1)
            }
        }
    }
    @IBAction func DeStatus(sender: UIButton) {
        if let indexPath = collectionView.indexPath(for: sender.superview!.superview as! UICollectionViewCell) {
            if Int(self.destatus[indexPath.row]) == 1{
                self.DBRef.child("table/destatus").child(self.number[indexPath.row]).setValue(2)
            }else if Int(self.destatus[indexPath.row]) == 2{
                self.DBRef.child("table/destatus").child(self.number[indexPath.row]).setValue(1)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()
        Timer.scheduledTimer(
            timeInterval: 1.0,
            target: self,
            selector: #selector(self.reloadData(_:)),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func reloadData(_ sender: Timer) {
        for i in 0..<15{
            //席ステータス取得
            let defaultPlace00 = DBRef.child("table/status").child(number[i])
            defaultPlace00.observeSingleEvent(of: .value, with: { (snapshot) in self.status[i] = (snapshot.value! as AnyObject).description
                self.intstatus[i] = Int(self.status[i])!})
            let defaultPlace01 = DBRef.child("table/bstatus").child(number[i])
            defaultPlace01.observeSingleEvent(of: .value, with: { (snapshot) in self.bstatus[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace02 = DBRef.child("table/sstatus").child(number[i])
            defaultPlace02.observeSingleEvent(of: .value, with: { (snapshot) in self.sstatus[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace03 = DBRef.child("table/dstatus").child(number[i])
            defaultPlace03.observeSingleEvent(of: .value, with: { (snapshot) in self.dstatus[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace05 = DBRef.child("table/dxstatus").child(number[i])
            defaultPlace05.observeSingleEvent(of: .value, with: { (snapshot) in self.dxstatus[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace04 = DBRef.child("table/destatus").child(number[i])
            defaultPlace04.observeSingleEvent(of: .value, with: { (snapshot) in self.destatus[i] = (snapshot.value! as AnyObject).description})
            
            //注文数同期
            let defaultPlaceT = self.DBRef.child("table/order").child(number[i]).child("time")
            defaultPlaceT.observeSingleEvent(of: .value, with: { (snapshot) in self.hogetime[i] = (snapshot.value! as AnyObject).description
            })
            let defaultPlaceT2 = self.DBRef.child("table/order").child(number[i]).child("completetime")
            defaultPlaceT2.observeSingleEvent(of: .value, with: { (snapshot) in self.hogetime2[i] = (snapshot.value! as AnyObject).description
            })
            let defaultPlace3 = DBRef.child("table/setamount").child(number[i]).child("sset")
            defaultPlace3.observeSingleEvent(of: .value, with: { (snapshot) in self.sbamount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace = DBRef.child("table/order").child(number[i]).child("b1amount")
            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in self.b1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace9 = DBRef.child("table/order").child(number[i]).child("s1amount")
            defaultPlace9.observeSingleEvent(of: .value, with: { (snapshot) in self.s1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace10 = DBRef.child("table/order").child(number[i]).child("s2amount")
            defaultPlace10.observeSingleEvent(of: .value, with: { (snapshot) in self.s2amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace11 = DBRef.child("table/order").child(number[i]).child("s3amount")
            defaultPlace11.observeSingleEvent(of: .value, with: { (snapshot) in self.s3amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace2 = DBRef.child("table/order").child(number[i]).child("d1amount")
            defaultPlace2.observeSingleEvent(of: .value, with: { (snapshot) in self.d1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace4 = DBRef.child("table/order").child(number[i]).child("d3amount")
            defaultPlace4.observeSingleEvent(of: .value, with: { (snapshot) in self.d3amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace5 = DBRef.child("table/order").child(number[i]).child("d4amount")
            defaultPlace5.observeSingleEvent(of: .value, with: { (snapshot) in self.d4amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace12 = DBRef.child("table/order").child(number[i]).child("dx1amount")
            defaultPlace12.observeSingleEvent(of: .value, with: { (snapshot) in self.dx1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace13 = DBRef.child("table/order").child(number[i]).child("dx2amount")
            defaultPlace13.observeSingleEvent(of: .value, with: { (snapshot) in self.dx2amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace14 = DBRef.child("table/order").child(number[i]).child("dx3amount")
            defaultPlace14.observeSingleEvent(of: .value, with: { (snapshot) in self.dx3amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace15 = DBRef.child("table/order").child(number[i]).child("dx4amount")
            defaultPlace15.observeSingleEvent(of: .value, with: { (snapshot) in self.dx4amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace6 = DBRef.child("table/order").child(number[i]).child("de1amount")
            defaultPlace6.observeSingleEvent(of: .value, with: { (snapshot) in self.de1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace7 = DBRef.child("table/order").child(number[i]).child("de2amount")
            defaultPlace7.observeSingleEvent(of: .value, with: { (snapshot) in self.de2amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace8 = DBRef.child("table/order").child(number[i]).child("de3amount")
            defaultPlace8.observeSingleEvent(of: .value, with: { (snapshot) in self.de3amount[i] = (snapshot.value! as AnyObject).description})
        }
        
        self.collectionView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
