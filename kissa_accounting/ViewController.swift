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
    
    let number = ["001","002","003","004","005","006","007","008","009","010"]
    var tablenumber : String?
    // インスタンス変数
    var DBRef:DatabaseReference!
   
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell{
        let Cell:UICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath)
        let tablelabel = Cell.contentView.viewWithTag(1) as! UILabel
        let b1amountlabel = Cell.contentView.viewWithTag(2) as! UILabel
        let s1amountlabel = Cell.contentView.viewWithTag(3) as! UILabel
        let d1amountlabel = Cell.contentView.viewWithTag(4) as! UILabel
        let de1amountlabel = Cell.contentView.viewWithTag(5) as! UILabel
        tablelabel.text = "Table" + number[indexPath.row]
        
        //注文数同期
        let defaultPlace = DBRef.child("table/order").child(number[indexPath.row]).child("b1amount")
        defaultPlace.observe(.value) { (snap: DataSnapshot) in b1amountlabel.text = (snap.value! as AnyObject).description}
        let defaultPlace1 = DBRef.child("table/order").child(number[indexPath.row]).child("s1amount")
        defaultPlace1.observe(.value) { (snap: DataSnapshot) in s1amountlabel.text = (snap.value! as AnyObject).description}
        let defaultPlace2 = DBRef.child("table/order").child(number[indexPath.row]).child("d1amount")
        defaultPlace2.observe(.value) { (snap: DataSnapshot) in d1amountlabel.text = (snap.value! as AnyObject).description}
        let defaultPlace3 = DBRef.child("table/order").child(number[indexPath.row]).child("de1amount")
        defaultPlace3.observe(.value) { (snap: DataSnapshot) in de1amountlabel.text = (snap.value! as AnyObject).description}
        
        //満席表示
        var status : String?
        var intstatus : Int?
        let defaultPlace0 = DBRef.child("table/status").child(number[indexPath.row])
        defaultPlace0.observe(.value) { (snap: DataSnapshot) in status = (snap.value! as AnyObject).description
            intstatus = Int(status!)
            if intstatus! == 0{
                Cell.contentView.backgroundColor = UIColor.clear
            }else if intstatus! == 1{
                Cell.contentView.backgroundColor = UIColor.yellow
            }else if intstatus! == 2{
                Cell.contentView.backgroundColor = UIColor.magenta
            }else if intstatus! == 3{
                Cell.contentView.backgroundColor = UIColor.red
            }else if intstatus! == 4{
                Cell.contentView.backgroundColor = UIColor.cyan
            }
        }
        
        return Cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return number.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "会計処理",message: "実行しますか？", preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
            self.DBRef.child("table/order").child(self.number[indexPath.row]).setValue(["b1amount":0,"s1amount":0,"d1amount":0,"de1amount":0,"time":0])
            self.DBRef.child("table/status").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/bsstatus").child(self.number[indexPath.row]).setValue(0)
            self.DBRef.child("table/ddstatus").child(self.number[indexPath.row]).setValue(0)
            var hogekey : String?
            let defaultPlace = self.DBRef.child("table/orderkey").child(self.number[indexPath.row])
            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in hogekey = (snapshot.value! as AnyObject).description
                self.DBRef.child("table/orderorder").child(hogekey!).setValue(nil)
                self.DBRef.child("table/orderkey").child(self.number[indexPath.row]).setValue(nil)
            })
        }
        let cancelButton = UIAlertAction(title: "キャンセル", style: UIAlertActionStyle.cancel, handler: nil)
        
        alertController.addAction(okAction)
        alertController.addAction(cancelButton)
        
        present(alertController,animated: true,completion: nil)
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //インスタンスを作成
        DBRef = Database.database().reference()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

