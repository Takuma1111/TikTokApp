import UIKit
import Firebase     //追加
import GoogleSignIn//追加


class LoginViewController: UIViewController,GIDSignInDelegate {
    
    private var displayName = ""
    private var userId = ""
    //２つのデリゲートのプロトコルを追加
    override func viewDidLoad() {
        super.viewDidLoad()

//        GIDSignIn.sharedInstance()?.uiDelegate = self
        GIDSignIn.sharedInstance()!.delegate = self
//
        GIDSignIn.sharedInstance()!.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
//        transitionToChatRoom()
    }
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
//                    print("送信者の名前:",user?.user.displayName)
//                    print("送信者のid:",user?.user.uid)
//
//                    print("name::",user?.user.displayName)
//                    print("uid::",user?.user.uid)
                    self.displayName = user?.user.displayName as! String
                    self.userId = user?.user.uid as! String
                    self.transitionToChatRoom()
           //                self.performSegue(withIdentifier: "viewSegue", sender: nil)//"toChatRoom"というIDで識別
                      }
       }
    /*** ここから追加！ ***/

    //チャット画面への遷移メソッド
    func transitionToChatRoom() {
        performSegue(withIdentifier: "viewSegue", sender: nil)//"toChatRoom"というIDで識別
        print("yばれた")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "viewSegue" {
             let nextVC = segue.destination as! ChatViewController
             nextVC.displayName = displayName
             nextVC.senderID = userId
         }
     }
    //Googleサインインに関するデリゲートメソッド
    //signIn:didSignInForUser:withError: メソッドで、Google ID トークンと Google アクセス トークンを
    //GIDAuthentication オブジェクトから取得して、Firebase 認証情報と交換します。

//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
//        if let error = error {
//            print(error.localizedDescription)
//            return
//        }
//
//        guard let authentication = user.authentication else { return }
//        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken, accessToken: authentication.accessToken)
//
//
//        //最後に、認証情報を使用して Firebase での認証を行います
//        Auth.auth().signIn(with: credential) { (authDataResult, error) in
//            if let error = error {
//                print(error.localizedDescription)
//                return
//            }
//            print("\nLogin succeeded\n")
//            self.transitionToChatRoom()
//        }
//    }

//    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
//      // ...
//      if let error = error {
//        print(error.localizedDescription)
//        return
//      }
//
//      guard let authentication = user.authentication else { return }
//      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
//                                                        accessToken: authentication.accessToken)
//        //最後に、認証情報を使用して Firebase での認証を行います
//               Auth.auth().signIn(with: credential) { (authDataResult, error) in
//                   if let error = error {
//                       print(error.localizedDescription)
//                       return
//                   }
//                   print("\nLogin succeeded\n")
//                   self.transitionToChatRoom()
//               }
//
//    }
    @IBAction func tappedSignOut(_ sender: Any) {
        let firebaseAuth = Auth.auth()
               do {
                   try firebaseAuth.signOut()
                   print("SignOut is succeeded")
                   reloadInputViews()
               } catch let signOutError as NSError {
                   print("Error signing out: %@", signOutError)
               }
    }
    
}

