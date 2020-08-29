import UIKit
import MessageKit//追加
//import MessageInputBar//追加
import Firebase   //追加
import GoogleSignIn

class ChatMessageViewController: MessagesViewController { // <- MessagesViewControllerに必ず書き換える


    //外部のファイルから書き換えられないようにprivate
    private var ref: DatabaseReference! //RealtimeDatabaseからの応答
//    private var user: User! //ユーザー
    var messageList: [Message] = [] //Message型のオブジェクトの入る配列

    
    @IBOutlet weak var signInButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference() //リファレンスの初期化
//        user = Auth.auth().currentUser      //認証した現在のユーザーを格納

        //各種デリゲートをこのVCに設定
        messagesCollectionView.messagesDataSource = self as! MessagesDataSource
        messagesCollectionView.messagesLayoutDelegate = self as! MessagesLayoutDelegate
        messagesCollectionView.messagesDisplayDelegate = self as! MessagesDisplayDelegate
        messagesCollectionView.messageCellDelegate = self as! MessageCellDelegate
//        messageInputBar.delegate = self as InputBarAccessoryViewDelegate

        // メッセージ入力時に一番下までスクロール
//        scrollsToBottomOnKeybordBeginsEditing = true // default false
        maintainPositionOnKeyboardFrameChanged = true // default false

        
        
        //公式
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
        
    }
}
