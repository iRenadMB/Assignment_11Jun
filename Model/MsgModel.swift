
import SwiftUI
import Firebase
import FirebaseFirestoreSwift

// for onChange
//struct MsgModel: Codable,Identifiable,Hashable {
//
//    @DocumentID var id : String?
//    var msg : String
//    var user : String
//    var timeStamp: Date
//
//    enum CodingKeys: String,CodingKey {
//        case id
//        case msg
//        case user
//        case timeStamp
//
//    }
//}

struct Message: Identifiable {
    var id: String
    var userName: String
    var lastMessage: String
    var timestamp: Timestamp
}

