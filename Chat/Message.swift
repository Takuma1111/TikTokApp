import Foundation
import MessageKit

struct Message: MessageType {
    var sender: SenderType
    //classではなくstruct!
//    var sender: Sender
    var sentDate: Date
    var messageId: String
    var kind: MessageKind
}
