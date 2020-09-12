//
//  ChatViewController.swift
//  TikTokApp
//
//  Created by 村上拓麻 on 2020/08/29.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ChatViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var nameInputView: UITextField!
    @IBOutlet weak var messageInputView: UITextField!
    
    @IBOutlet weak var inputViewBottomMargin: NSLayoutConstraint!
    var databaseRef: DatabaseReference!

    override func viewDidLoad() {
        super.viewDidLoad()

        databaseRef = Database.database().reference()
        //observeでイベント監視を行う
        databaseRef.observe(.childAdded, with: { snapshot in
            if let obj = snapshot.value as? [String : AnyObject], let name = obj["name"] as? String, let message = obj["message"] {
                       let currentText = self.textView.text
                       self.textView.text = (currentText ?? "") + "\n\(name) : \(message)"
                }
            })
        
        //キーボードが表示されるタイミングと非表示になるタイミングを監視
       NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
       NotificationCenter.default.addObserver(self, selector: #selector(ChatViewController.keyboardWillHide(_:)), name: UIResponder.keyboardDidHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: NSNotification){
          if let userInfo = notification.userInfo, let keyboardFrameInfo = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
              inputViewBottomMargin.constant = keyboardFrameInfo.cgRectValue.height
          }

      }

      @objc func keyboardWillHide(_ notification: NSNotification){
          inputViewBottomMargin.constant = 0
      }
    
    //ボタンを押した際にtextfieldに入力されたデータを送信
    @IBAction func sendButton(_ sender: Any) {
        view.endEditing(true)

        if let name = nameInputView.text, let message = messageInputView.text {
            let messageData = ["name": name, "message": message]
            databaseRef.childByAutoId().setValue(messageData)

            messageInputView.text = ""
        }
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
