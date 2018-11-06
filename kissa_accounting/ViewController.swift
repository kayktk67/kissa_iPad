//
//  ViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/09/09.
//  Copyright © 2018年 Kei Kawamura. All rights reserved.
//

import UIKit
import Firebase
class ViewController: UIViewController ,UICollectionViewDataSource,
UICollectionViewDelegate {
    
    var number : [String] = []
    var tablenumber : String?
    // インスタンス変数
    var DBRef:DatabaseReference!
    var dateUnix: TimeInterval = 0
    
    var status = Array(repeating: "0", count: 20)
    var intstatus = Array(repeating: 0, count: 20)
    var hogetime = Array(repeating: "0", count: 20)
    var tbstatus = Array(repeating: "0", count: 20)
    var sstatus = Array(repeating: "0", count: 20)
    var dstatus = Array(repeating: "0", count: 20)
    var dxstatus = Array(repeating: "0", count: 20)
    var b3amount = Array(repeating: "0", count: 20)
    var b4amount = Array(repeating: "0", count: 20)
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
    var c1amount = Array(repeating: "0", count: 20)
    var c3amount = Array(repeating: "0", count: 20)
    var c10amount = Array(repeating: "0", count: 20)

   
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let Cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let tablelabel = Cell.contentView.viewWithTag(1) as! UILabel
        let timelabel = Cell.contentView.viewWithTag(2) as! UILabel
        let b3amountlabel = Cell.contentView.viewWithTag(3) as! UILabel
        let b4amountlabel = Cell.contentView.viewWithTag(4) as! UILabel
        let s1amountlabel = Cell.contentView.viewWithTag(9) as! UILabel
        let s2amountlabel = Cell.contentView.viewWithTag(10) as! UILabel
        let s3amountlabel = Cell.contentView.viewWithTag(11) as! UILabel
        let d1amountlabel = Cell.contentView.viewWithTag(5) as! UILabel
        let d3amountlabel = Cell.contentView.viewWithTag(7) as! UILabel
        let d4amountlabel = Cell.contentView.viewWithTag(8) as! UILabel
        let Statuslabel = Cell.contentView.viewWithTag(12) as! UILabel
        let BStatuslabel = Cell.contentView.viewWithTag(13) as! UILabel
        let SStatuslabel = Cell.contentView.viewWithTag(14) as! UILabel
        let DStatuslabel = Cell.contentView.viewWithTag(15) as! UILabel
        let DXStatuslabel = Cell.contentView.viewWithTag(20) as! UILabel
        let dx1amountlabel = Cell.contentView.viewWithTag(16) as! UILabel
        let dx2amountlabel = Cell.contentView.viewWithTag(17) as! UILabel
        let dx3amountlabel = Cell.contentView.viewWithTag(18) as! UILabel
        let dx4amountlabel = Cell.contentView.viewWithTag(19) as! UILabel
        let c1amountlabel = Cell.contentView.viewWithTag(21) as! UILabel
        let c3amountlabel = Cell.contentView.viewWithTag(22) as! UILabel
        let c10amountlabel = Cell.contentView.viewWithTag(23) as! UILabel
        b3amountlabel.text =  self.b3amount[indexPath.row]
        b4amountlabel.text =  self.b4amount[indexPath.row]
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
        c1amountlabel.text =  self.c1amount[indexPath.row]
        c3amountlabel.text =  self.c3amount[indexPath.row]
        c10amountlabel.text =  self.c10amount[indexPath.row]
        tablelabel.text = "Table" + number[indexPath.row]
        
        //注文数同期
            if Int(self.hogetime[indexPath.row]) == 0 {
                timelabel.text = ""
            }else{
            self.dateUnix = TimeInterval(self.hogetime[indexPath.row])!
            let hogedate = NSDate(timeIntervalSince1970: self.dateUnix/1000)
            let formatter = DateFormatter()
            formatter.dateFormat = "HH:mm:ss"
            timelabel.text = formatter.string(from: hogedate as Date)
            }
        
        //満席表示
            if intstatus[indexPath.row] == 0{
                Statuslabel.backgroundColor = UIColor.white
            }else if intstatus[indexPath.row] == 1{
                Statuslabel.backgroundColor = UIColor.yellow
            }else if intstatus[indexPath.row] == 2{
                Statuslabel.backgroundColor = UIColor.magenta
            }else if intstatus[indexPath.row] == 3{
                Statuslabel.backgroundColor = UIColor.cyan
            }
            if Int(self.tbstatus[indexPath.row]) == 1{
                BStatuslabel.backgroundColor = UIColor.magenta
            }else{
                BStatuslabel.backgroundColor = UIColor.white
            }
            if Int(self.sstatus[indexPath.row]) == 1{
                SStatuslabel.backgroundColor = UIColor.magenta
            }else{
                SStatuslabel.backgroundColor = UIColor.white
            }
            if Int(self.dstatus[indexPath.row]) == 1{
                DStatuslabel.backgroundColor = UIColor.magenta
            }else{
                DStatuslabel.backgroundColor = UIColor.white
            }
            if Int(self.dxstatus[indexPath.row]) == 1{
                DXStatuslabel.backgroundColor = UIColor.magenta
            }else{
                DXStatuslabel.backgroundColor = UIColor.white
            }
        return Cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return number.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "完了処理",message: "実行しますか？", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.DBRef.child("table/order").child(self.number[indexPath.row]).setValue(["b1amount":0,"b2amount":0,"b3amount":0,"b4amount":0,"s1amount":0,"s2amount":0,"s3amount":0,"d1amount":0,"d2amount":0,"d3amount":0,"d4amount":0,"dx1amount":0,"dx2amount":0,"dx3amount":0,"dx4amount":0,"de1amount":0,"de2amount":0,"de3amount":0,"c1amount":0,"c3amount":0,"c10amount":0,"time":0])
            self.DBRef.child("table/status").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/bstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/tbstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/sstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/dstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/dxstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/destatus").child(self.number[indexPath.row]).setValue(0)
            
            
            var hogekey : String?
            let defaultPlace = self.DBRef.child("table/orderkey").child(self.number[indexPath.row])
            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in hogekey = (snapshot.value! as AnyObject).description
                self.DBRef.child("todata").child(hogekey!).updateChildValues(["completetime":ServerValue.timestamp()])
                self.DBRef.child("table/orderorder").child(hogekey!).setValue(nil)
                self.DBRef.child("table/orderkey").child(self.number[indexPath.row]).setValue(nil)
            })
            self.collectionView.reloadData()
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
        //オーダーリストの取得
        let defaultPlace = self.DBRef.child("table/orderorder")
        defaultPlace.observe(.value, with: { snapshot in
            var array: [String] = []
            for item in (snapshot.children) {
                let snapshot = item as! DataSnapshot
                let dict = snapshot.value as! String
                if Int(dict)!>100{
                    array.append(dict)
                }
            }
            DispatchQueue.main.async {
                self.number = array
                self.statusload()
                self.statusloaddata()
                self.amountload()
                self.amountloaddata()
            }
        })
        
        Timer.scheduledTimer(
            timeInterval: 0.5,
            target: self,
            selector: #selector(self.load(_:)),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func load(_ sender: Timer) {
        self.collectionView.reloadData()
    }
    
    func amountload(){
        let defaultPlaceXXX = self.DBRef.child("table/order")
        defaultPlaceXXX.observe(.childChanged, with: { (snapshot) -> Void in
            //オーダーリストの取得
            let defaultPlace = self.DBRef.child("table/orderorder")
            defaultPlace.observe(.value, with: { snapshot in
                var array: [String] = []
                for item in (snapshot.children) {
                    let snapshot = item as! DataSnapshot
                    let dict = snapshot.value as! String
                    if Int(dict)!>100{
                        array.append(dict)
                    }
                }
                DispatchQueue.main.async {
                    self.number = array
                }
            })
            self.amountloaddata()
        })
    }
    
    func statusload(){
        let defaultPlaceXXXX = self.DBRef.child("table")
        defaultPlaceXXXX.observe(.childChanged, with: { (snapshot) -> Void in
            //オーダーリストの取得
            let defaultPlace = self.DBRef.child("table/orderorder")
            defaultPlace.observe(.value, with: { snapshot in
                var array: [String] = []
                for item in (snapshot.children) {
                    let snapshot = item as! DataSnapshot
                    let dict = snapshot.value as! String
                    if Int(dict)!>100{
                        array.append(dict)
                    }
                }
                DispatchQueue.main.async {
                    self.number = array
                }
            })
            self.statusloaddata()
        })
    }
    
    func amountloaddata(){
        for i in 0..<self.number.count{
            //注文数同期
            let defaultPlaceT = self.DBRef.child("table/order").child(self.number[i]).child("time")
            defaultPlaceT.observeSingleEvent(of: .value, with: { (snapshot) in self.hogetime[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace = self.DBRef.child("table/order").child(self.number[i]).child("b3amount")
            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in self.b3amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace1 = self.DBRef.child("table/order").child(self.number[i]).child("b4amount")
            defaultPlace1.observeSingleEvent(of: .value, with: { (snapshot) in self.b4amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace6 = self.DBRef.child("table/order").child(self.number[i]).child("s1amount")
            defaultPlace6.observeSingleEvent(of: .value, with: { (snapshot) in self.s1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace7 = self.DBRef.child("table/order").child(self.number[i]).child("s2amount")
            defaultPlace7.observeSingleEvent(of: .value, with: { (snapshot) in self.s2amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace8 = self.DBRef.child("table/order").child(self.number[i]).child("s3amount")
            defaultPlace8.observeSingleEvent(of: .value, with: { (snapshot) in self.s3amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace2 = self.DBRef.child("table/order").child(self.number[i]).child("d1amount")
            defaultPlace2.observeSingleEvent(of: .value, with: { (snapshot) in self.d1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace4 = self.DBRef.child("table/order").child(self.number[i]).child("d3amount")
            defaultPlace4.observeSingleEvent(of: .value, with: { (snapshot) in self.d3amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace5 = self.DBRef.child("table/order").child(self.number[i]).child("d4amount")
            defaultPlace5.observeSingleEvent(of: .value, with: { (snapshot) in self.d4amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace12 = self.DBRef.child("table/order").child(self.number[i]).child("dx1amount")
            defaultPlace12.observeSingleEvent(of: .value, with: { (snapshot) in self.dx1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace13 = self.DBRef.child("table/order").child(self.number[i]).child("dx2amount")
            defaultPlace13.observeSingleEvent(of: .value, with: { (snapshot) in self.dx2amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace14 = self.DBRef.child("table/order").child(self.number[i]).child("dx3amount")
            defaultPlace14.observeSingleEvent(of: .value, with: { (snapshot) in self.dx3amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace15 = self.DBRef.child("table/order").child(self.number[i]).child("dx4amount")
            defaultPlace15.observeSingleEvent(of: .value, with: { (snapshot) in self.dx4amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace16 = self.DBRef.child("table/order").child(self.number[i]).child("c1amount")
            defaultPlace16.observeSingleEvent(of: .value, with: { (snapshot) in self.c1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace17 = self.DBRef.child("table/order").child(self.number[i]).child("c3amount")
            defaultPlace17.observeSingleEvent(of: .value, with: { (snapshot) in self.c3amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace18 = self.DBRef.child("table/order").child(self.number[i]).child("c10amount")
            defaultPlace18.observeSingleEvent(of: .value, with: { (snapshot) in self.c10amount[i] = (snapshot.value! as AnyObject).description})
        }
        self.collectionView.reloadData()
    }
    
    func statusloaddata(){
        for i in 0..<self.number.count{
            //席ステータス取得
            let defaultPlace0 = self.DBRef.child("table/status").child(self.number[i])
            defaultPlace0.observeSingleEvent(of: .value, with: { (snapshot) in self.status[i] = (snapshot.value! as AnyObject).description
                self.intstatus[i] = Int(self.status[i])!})
            let defaultPlace9 = self.DBRef.child("table/tbstatus").child(self.number[i])
            defaultPlace9.observeSingleEvent(of: .value, with: { (snapshot) in self.tbstatus[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace10 = self.DBRef.child("table/sstatus").child(self.number[i])
            defaultPlace10.observeSingleEvent(of: .value, with: { (snapshot) in self.sstatus[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace11 = self.DBRef.child("table/dstatus").child(self.number[i])
            defaultPlace11.observeSingleEvent(of: .value, with: { (snapshot) in self.dstatus[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace16 = self.DBRef.child("table/dxstatus").child(self.number[i])
            defaultPlace16.observeSingleEvent(of: .value, with: { (snapshot) in self.dxstatus[i] = (snapshot.value! as  AnyObject).description})
        }
        self.collectionView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
