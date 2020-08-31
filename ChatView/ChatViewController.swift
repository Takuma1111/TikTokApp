//
//  ChatViewController.swift
//  TikTokApp
//
//  Created by 村上拓麻 on 2020/08/29.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import UIKit
import FirebaseDatabase


class ChatViewController: UIViewController ,UITableViewDelegate{

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameInputView: UITextField!
    @IBOutlet weak var messageInputView: UITextField!
    
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    var databaseRef: DatabaseReference!
    @IBOutlet weak var tableView: UITableView!
    
    var judge : Bool = false
    
    var response : [String] = []
    var otherResponse : [String] = []
    var count : Int = 0
    var resName : String = ""
    var array : [[String]] = []
    
    var displayName : String = ""
    var senderID : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("受け取った：",displayName + senderID)
        
        tableView.delegate = self
        tableView.dataSource = self
        self.tableView.register(UINib(nibName: "ChatTableViewCell", bundle: nil), forCellReuseIdentifier: "ChatTableViewCell")
        self.tableView.register(UINib(nibName: "OtherChatTableViewCell", bundle: nil), forCellReuseIdentifier: "OtherChatTableViewCell")
        
        databaseRef = Database.database().reference()
        //observeでイベント監視を行う
        databaseRef.observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"],let id = obj["id"] as? String {
//                       let currentText = self.textView.text
                self.resName = name
                if(id != self.senderID){
                    self.otherResponse.append(message as! String)
                    var a :[String] = []
                    a.append(name)
                    a.append(message as! String)
                    a.append(id)
                    self.array.append(a)
                }else{
                    self.response.append(message as! String)
                    var a :[String] = []
                    a.append(name)
                    a.append(message as! String)
                    a.append(id)
                    self.array.append(a)
                }
//                self.judge = true
//                self.count = self.response.count + self.otherResponse.count
                print("配列中身",self.array)
                self.tableView.reloadData()

//                       self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
                }
            })
        
        if(self.judge){
            print("実行")
            tableView.reloadData()
        }

        //キーボードが表示されるタイミングと非表示になるタイミングを監視
//      z
    }
    
//    @objc func keyboardWillShow(_ notification: NSNotification){
//          if let userInfo = notification.userInfo, let keyboardFrameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
//              inputViewBottomMargin.constant = keyboardFrameInfo.cgRectValue.height
//          }
//      }
//
//      @objc func keyboardWillHide(_ notification: NSNotification){
//          inputViewBottomMargin.constant = 0
//      }
//
    //ボタンを押した際にtextfieldに入力されたデータを送信
    @IBAction func sendButton(_ sender: Any) {
        view.endEditing(true)

        if let mess = messageInputView.text {
            let messageData = ["name":displayName ,"message" : mess,"id":senderID]
            databaseRef.childByAutoId().setValue(messageData)
            messageInputView.text = ""
            response.append(mess)
//            count += 1
            self.tableView.reloadData()
            let indexPath = IndexPath(row: tableView.numberOfRows(inSection: 0) - 1, section: 0)
            self.tableView.scrollToRow(at: indexPath, at: .bottom, animated: true)
//            tableView.estimatedRowHeight = 60
//            self.tableView.contentOffset = CGPoint(x: 0, y: -self.tableView.contentInset.bottom);
//            self.tableView.setContentOffset(CGPoint(x: 0, y: self.tableView.contentSize.height - self.tableView.frame.size.height), animated: true)
//            self.tableView.setContent(offset:CGPointMake(0, self.tableView.contentSize.height - self.tableView.frame.size.height),animated: false);
        }
        
//        if let name = nameInputView.text, let message = messageInputView.text {
//            let messageData = ["name": name, "message": message]
//            databaseRef.childByAutoId().setValue(messageData)
//
//            messageInputView.text = ""
//        }
    }
    
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if(resName == "T2"){
//            count = response.count
//        }else{
//            count = otherResponse.count
//        }
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "chatCell") as! ChatTableViewCell

        var cell : UITableViewCell;
        if(array[indexPath.row][2] == senderID){
            cell = tableView.dequeueReusableCell(withIdentifier: "ChatTableViewCell") as! ChatTableViewCell
            cell.textLabel?.text = array[indexPath.row][1]
//            cell.textLabel?.textAlignment = NSTextAlignment.center
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "OtherChatTableViewCell") as! OtherChatTableViewCell
            cell.textLabel?.text = array[indexPath.row][1]
            cell.textLabel?.textAlignment = NSTextAlignment.left
        }
        print(response)
        return cell
    }
}


