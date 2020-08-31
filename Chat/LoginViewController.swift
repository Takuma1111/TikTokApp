import UIKit
import Firebase     //追加
import GoogleSignIn//追加


class LoginViewController: UIViewController,GIDSignInDelegate {
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

    /*** ここから追加！ ***/

    //チャット画面への遷移メソッド
    func transitionToChatRoom() {
        performSegue(withIdentifier: "viewSegue", sender: nil)//"toChatRoom"というIDで識別
        print("yばれた")
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

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?) {
      // ...
      if let error = error {
        print(error.localizedDescription)
        return
      }

      guard let authentication = user.authentication else { return }
      let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                        accessToken: authentication.accessToken)
        //最後に、認証情報を使用して Firebase での認証を行います
               Auth.auth().signIn(with: credential) { (authDataResult, error) in
                   if let error = error {
                       print(error.localizedDescription)
                       return
                   }
                   print("\nLogin succeeded\n")
                   self.transitionToChatRoom()
               }
        guard let authentication = user.authentication else { return }
        let credential = GoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
    }
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

