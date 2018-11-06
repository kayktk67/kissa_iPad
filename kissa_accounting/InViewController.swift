//
//  InViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/09/16.
//  Copyright © 2018年 Kei Kawamura. All rights reserved.
//

import UIKit
import Firebase
class InViewController: UIViewController ,UICollectionViewDataSource,
UICollectionViewDelegate {
    
    let number = ["001","002","003","004","005","006","007","008","009","010","011","012","013","014","015","016","017","018"]
    var tablenumber : String?
    // インスタンス変数
    var DBRef:DatabaseReference!
    var dateUnix: TimeInterval = 0
    var hogetime = Array(repeating: "0", count: 20)
    var status = Array(repeating: "0", count: 20)
    var intstatus = Array(repeating: 0, count: 20)
    var hogetime1: String?
    
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
    var de4amount = Array(repeating: "0", count: 20)
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let Cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "InCell", for: indexPath)
        let tablelabel = Cell.contentView.viewWithTag(1) as! UILabel
        let timelabel = Cell.contentView.viewWithTag(2) as! UILabel
        let b1amountlabel = Cell.contentView.viewWithTag(3) as! UILabel
        let s1amountlabel = Cell.contentView.viewWithTag(4) as! UILabel
        let s2amountlabel = Cell.contentView.viewWithTag(5) as! UILabel
        let s3amountlabel = Cell.contentView.viewWithTag(6) as! UILabel
        let d1amountlabel = Cell.contentView.viewWithTag(7) as! UILabel
        let d3amountlabel = Cell.contentView.viewWithTag(9) as! UILabel
        let d4amountlabel = Cell.contentView.viewWithTag(10) as! UILabel
        let dx1amountlabel = Cell.contentView.viewWithTag(11) as! UILabel
        let dx2amountlabel = Cell.contentView.viewWithTag(12) as! UILabel
        let dx3amountlabel = Cell.contentView.viewWithTag(13) as! UILabel
        let dx4amountlabel = Cell.contentView.viewWithTag(14) as! UILabel
        let de1amountlabel = Cell.contentView.viewWithTag(15) as! UILabel
        let de2amountlabel = Cell.contentView.viewWithTag(16) as! UILabel
        let de3amountlabel = Cell.contentView.viewWithTag(17) as! UILabel
        let de4amountlabel = Cell.contentView.viewWithTag(18) as! UILabel
        tablelabel.text = "Table" + number[indexPath.row]
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
        de4amountlabel.text =  self.de4amount[indexPath.row]
        
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
                Cell.contentView.backgroundColor = UIColor.clear
            }else if intstatus[indexPath.row] == 1{
                Cell.contentView.backgroundColor = UIColor.yellow
            }else if intstatus[indexPath.row] == 2{
                Cell.contentView.backgroundColor = UIColor.magenta
            }else if intstatus[indexPath.row] == 3{
                Cell.contentView.backgroundColor = UIColor.red
            }else if intstatus[indexPath.row] == 4{
                Cell.contentView.backgroundColor = UIColor.cyan
            }
        return Cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return number.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.tablenumber = number[indexPath.row]
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        self.hogetime1 = formatter.string(from: Date())
        performSegue(withIdentifier: "toinaccountingfinish", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()
        statusloaddata()
        statusload()
        amountloaddata()
        amountload()
        Timer.scheduledTimer(
            timeInterval: 1,
            target: self,
            selector: #selector(self.reloadData(_:)),
            userInfo: nil,
            repeats: true
        )
    }
    
    @objc func reloadData(_ sender: Timer) {
        self.collectionView.reloadData()
    }
    
    func statusload(){
        let defaultPlaceXXX = self.DBRef.child("table")
        defaultPlaceXXX.observe(.childChanged, with: { (snapshot) -> Void in
            self.statusloaddata()
        })
    }
    func amountload(){
        let defaultPlaceXXX = self.DBRef.child("table/order")
        defaultPlaceXXX.observe(.childChanged, with: { (snapshot) -> Void in
            self.amountloaddata()
        })
    }
    
    func statusloaddata(){
        for i in 0..<18{
            //席ステータス取得
            let defaultPlace0 = self.DBRef.child("table/status").child(self.number[i])
            defaultPlace0.observeSingleEvent(of: .value, with: { (snapshot) in self.status[i] = (snapshot.value! as AnyObject).description
                self.intstatus[i] = Int(self.status[i])!
            })
        }
        self.collectionView.reloadData()
    }
    func amountloaddata(){
        for i in 0..<18{
            //注文数同期
            let defaultPlaceT = self.DBRef.child("table/order").child(self.number[i]).child("time")
            defaultPlaceT.observeSingleEvent(of: .value, with: { (snapshot) in self.hogetime[i] = (snapshot.value! as AnyObject).description
            })
            let defaultPlace = self.DBRef.child("table/order").child(self.number[i]).child("b1amount")
            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in self.b1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace9 = self.DBRef.child("table/order").child(self.number[i]).child("s1amount")
            defaultPlace9.observeSingleEvent(of: .value, with: { (snapshot) in self.s1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace10 = self.DBRef.child("table/order").child(self.number[i]).child("s2amount")
            defaultPlace10.observeSingleEvent(of: .value, with: { (snapshot) in self.s2amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace11 = self.DBRef.child("table/order").child(self.number[i]).child("s3amount")
            defaultPlace11.observeSingleEvent(of: .value, with: { (snapshot) in self.s3amount[i] = (snapshot.value! as AnyObject).description})
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
            let defaultPlace6 = self.DBRef.child("table/order").child(self.number[i]).child("de1amount")
            defaultPlace6.observeSingleEvent(of: .value, with: { (snapshot) in self.de1amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace7 = self.DBRef.child("table/order").child(self.number[i]).child("de2amount")
            defaultPlace7.observeSingleEvent(of: .value, with: { (snapshot) in self.de2amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace8 = self.DBRef.child("table/order").child(self.number[i]).child("de3amount")
            defaultPlace8.observeSingleEvent(of: .value, with: { (snapshot) in self.de3amount[i] = (snapshot.value! as AnyObject).description})
            let defaultPlace16 = self.DBRef.child("table/order").child(self.number[i]).child("de4amount")
            defaultPlace16.observeSingleEvent(of: .value, with: { (snapshot) in self.de4amount[i] = (snapshot.value! as AnyObject).description})
        }
        self.collectionView.reloadData()
    }
    
    //次のビューに渡す値を設定
    override func  prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let nextVC = segue.destination as! InFinishViewController
        let _ = nextVC.view
        nextVC.tableNumber = tablenumber
        nextVC.tableNumberLabel.text = "Table\(tablenumber!)"
        nextVC.BSetAccountingAmount.text = "0"
        nextVC.SSetAccountingAmount.text = "0"
        nextVC.BSSetAccountingAmount.text = "0"
        nextVC.NoIceAccountingAmount.text = "0"
        nextVC.SumMoneyAmount.text = "0"
        nextVC.GetMoneyAmount.text = "0"
        nextVC.BackMoneyAmount.text = "0"
        nextVC.C1Amount.text = "0"
        nextVC.C3Amount.text = "0"
        nextVC.C10Amount.text = "0"
        nextVC.hogetime = hogetime1!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
