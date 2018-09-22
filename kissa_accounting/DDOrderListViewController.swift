//
//  DDOrderListViewController.swift
//  kissa_accounting
//
//  Created by Kei Kawamura on 2018/09/15.
//  Copyright © 2018年 Kei Kawamura. All rights reserved.
//

import Foundation
import UIKit
import Firebase

class DDOrderListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    // インスタンス変数
    var DBRef:DatabaseReference!
    var hogearray : [String] = []
    var array1 : [String] = []
    var d1amount = Array(repeating: "0", count: 20)
    var d2amount = Array(repeating: "0", count: 20)
    var d3amount = Array(repeating: "0", count: 20)
    var d4amount = Array(repeating: "0", count: 20)
    var de1amount = Array(repeating: "0", count: 20)
    var de2amount = Array(repeating: "0", count: 20)
    var de3amount = Array(repeating: "0", count: 20)
    var time = Array(repeating: "0", count: 20)
    var dateUnix: TimeInterval = 0
    var hogetime : String?
    
    @IBOutlet weak var tableview: UITableView!

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.hogearray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        var status1 : String?
        var intstatus1 : Int?
        let defaultPlacex = DBRef.child("table/ddstatus").child(hogearray[indexPath.row])
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
        
        let defaultPlace1 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("d1amount")
        defaultPlace1.observe(.value) { (snap: DataSnapshot) in self.d1amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace2 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("d2amount")
        defaultPlace2.observe(.value) { (snap: DataSnapshot) in self.d2amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace3 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("d3amount")
        defaultPlace3.observe(.value) { (snap: DataSnapshot) in self.d3amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace4 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("d4amount")
        defaultPlace4.observe(.value) { (snap: DataSnapshot) in self.d4amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace5 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("de1amount")
        defaultPlace5.observe(.value) { (snap: DataSnapshot) in self.de1amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace6 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("de2amount")
        defaultPlace6.observe(.value) { (snap: DataSnapshot) in self.de2amount[indexPath.row] = (snap.value! as AnyObject).description}
        let defaultPlace7 = self.DBRef.child("table/order").child(self.hogearray[indexPath.row]).child("de3amount")
        defaultPlace7.observe(.value) { (snap: DataSnapshot) in self.de3amount[indexPath.row] = (snap.value! as AnyObject).description}
        
        cell.textLabel!.text = "\(String(describing: self.time[indexPath.row])) Table\(String(describing:self.hogearray[indexPath.row])) コーヒー:\(String(describing: self.d1amount[indexPath.row])) ティー:\(String(describing: self.d2amount[indexPath.row])) ホワイト:\(String(describing: self.d3amount[indexPath.row])) パイナップル:\(String(describing: self.d4amount[indexPath.row]))   リンゴ:\(String(describing: self.de1amount[indexPath.row])) みかん:\(String(describing: self.de2amount[indexPath.row])) コーヒーゼリー:\(String(describing: self.de3amount[indexPath.row]))"
        cell.textLabel?.font = UIFont.systemFont(ofSize: 20)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alertController = UIAlertController(title: "調理済み",message: "", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default){ (action: UIAlertAction) in
            self.DBRef.child("table/ddstatus").child(self.hogearray[indexPath.row]).setValue(1)
            var status : String?
            var intstatus : Int?
            let defaultPlace = self.DBRef.child("table/bsstatus").child(self.hogearray[indexPath.row])
            defaultPlace.observeSingleEvent(of: .value, with: { (snapshot) in status = (snapshot.value! as AnyObject).description
                intstatus = Int(status!)
                if intstatus! == 1{
                    self.DBRef.child("table/status").child(self.hogearray[indexPath.row]).setValue(3)
                }else{
                    self.DBRef.child("table/status").child(self.hogearray[indexPath.row]).setValue(2)
                }
            })
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
        self.tableview.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
