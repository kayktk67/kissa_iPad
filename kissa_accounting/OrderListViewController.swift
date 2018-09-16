//
//  OrderListViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/09/10.
//  Copyright © 2018年 Kei Kawamura. All rights reserved.
//


    import Foundation
    import UIKit
    import Firebase
    
    class OrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
        // インスタンス変数
        var DBRef:DatabaseReference!
        var hogearray : [String] = []
        var array1 : [String] = []
        var b1amount = Array(repeating: "0", count: 20)
        var b2amount = Array(repeating: "0", count: 20)
        var b3amount = Array(repeating: "0", count: 20)
        var b4amount = Array(repeating: "0", count: 20)
        var s1amount = Array(repeating: "0", count: 20)
        var time = Array(repeating: "0", count: 20)
        var dateUnix: TimeInterval = 0
        var hogetime : String?
        var nowrow : String?
        
        @IBOutlet weak var tableView: UITableView!
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.hogearray.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath)
            
            var status1 : String?
            var intstatus1 : Int?
            let defaultPlacex = DBRef.child("table/bsstatus").child(hogearray[indexPath.row])
            defaultPlacex.observe(.value) { (snap: DataSnapshot) in status1 = (snap.value! as AnyObject).description
                intstatus1 = Int(status1!)
                if intstatus1! == 1{
                    cell.contentView.backgroundColor = UIColor.cyan
                }else{
                    cell.contentView.backgroundColor = UIColor.clear
                }
            }
            
                let defaultPlace0 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("time")
            defaultPlace0.observe(.value) { (snap: DataSnapshot) in self.hogetime = (snap.value! as AnyObject).description
                self.dateUnix = TimeInterval(self.hogetime!)!
                let hogedate = NSDate(timeIntervalSince1970: self.dateUnix/1000)
                let formatter = DateFormatter()
                formatter.dateFormat = "HH:mm:ss"
                self.time[indexPath.row] = formatter.string(from: hogedate as Date)
            }
            let defaultPlace = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("b1amount")
            defaultPlace.observe(.value) { (snap: DataSnapshot) in self.b1amount[indexPath.row] = (snap.value! as AnyObject).description}
            let defaultPlace1 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("b2amount")
            defaultPlace1.observe(.value) { (snap: DataSnapshot) in self.b2amount[indexPath.row] = (snap.value! as AnyObject).description}
            let defaultPlace2 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("b3amount")
            defaultPlace2.observe(.value) { (snap: DataSnapshot) in self.b3amount[indexPath.row] = (snap.value! as AnyObject).description}
            let defaultPlace3 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("b4amount")
            defaultPlace3.observe(.value) { (snap: DataSnapshot) in self.b4amount[indexPath.row] = (snap.value! as AnyObject).description}
            
            
            cell.textLabel!.text = "\(String(describing: self.time[indexPath.row])) Table\(String(describing:self.hogearray[indexPath.row])) ボロネ:\(String(describing: self.b1amount[indexPath.row])) ハムチ:\(String(describing: self.b2amount[indexPath.row])) レモン:\(String(describing: self.b3amount[indexPath.row])) ガーリック:\(String(describing: self.b4amount[indexPath.row]))"
            cell.textLabel?.font = UIFont.systemFont(ofSize: 25)
        
            return cell
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            self.nowrow = hogearray[indexPath.row]
            let alertController = UIAlertController(title: "調理済み",message: "", preferredStyle: UIAlertControllerStyle.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default){ (action: UIAlertAction) in
                self.DBRef.child("table/bsstatus").child(self.nowrow!).setValue(1)
                var status : String?
                var intstatus : Int?
                let defaultPlace = self.DBRef.child("table/ddstatus").child(self.nowrow!)
                defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in status = (snapshot.value! as AnyObject).description
                    intstatus = Int(status!)
                    if intstatus! == 1{
                        self.DBRef.child("table/status").child(self.nowrow!).setValue(3)
                    }else{
                        self.DBRef.child("table/status").child(self.nowrow!).setValue(2)
                    }
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
            //オーダーリストの取得
            let defaultPlace = DBRef.child("table/orderorder")
            defaultPlace.observe(.value, with: { snapshot in
                var array: [String] = []
                for item in (snapshot.children) {
                    let snapshot = item as! DataSnapshot
                    let dict = snapshot.value as! String
                    array.append(dict)
                }
                print (array)
                DispatchQueue.main.async {
                    self.hogearray = array
                }
            })
            Timer.scheduledTimer(
                timeInterval: 0.2,
                target: self,
                selector: #selector(self.newArray(_:)),
                userInfo: nil,
                repeats: true
            )
        }
        @objc func newArray(_ sender: Timer) {
            self.tableView.reloadData()
        }
        
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
        }
}
