//
//  presentingViewController.swift
//  TikTokApp
//
//  Created by 村上拓麻 on 2020/08/31.
//  Copyright © 2020 村上拓麻. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn

class presentingViewController: UIViewController,GIDSignInDelegate{
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
          if let error = error {
                       print("Error: \(error.localizedDescription)")
                       return
                   }
                   let authentication = user.authentication
                   // Googleのトークンを渡し、Firebaseクレデンシャルを取得する。
                let credential = GoogleAuthProvider.credential(withIDToken: (authentication?.idToken)!,
                                                                     accessToken: (authentication?.accessToken)!)
                   // Firebaseにログインする。
                Auth.auth().signIn(with: credential) { (user, error) in
                       print("Sign on Firebase successfully")
        //                self.performSegue(withIdentifier: "viewSegue", sender: nil)//"toChatRoom"というIDで識別
                   }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
