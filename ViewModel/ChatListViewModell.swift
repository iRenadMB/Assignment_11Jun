
import Foundation
import Firebase

class ChatListViewModell: ObservableObject {
    
    @Published var chats = [Chat]()
    
    private var db = Firestore.firestore()
    
    func fetchChats() {
        db.collection("chats").getDocuments { (snapshot, error) in
            guard let snapshot = snapshot, error == nil else {
                print(error?.localizedDescription ?? "Error fetching chats")
                return
            }
            self.chats = snapshot.documents.compactMap { document in
                let data = document.data()
                let name = data["name"] as? String ?? ""
                let lastMessage = data["lastMessage"] as? String ?? ""
                let date = data["date"] as? String ?? ""
                return Chat(name: name, lastMessage: lastMessage, date: date)
            }
        }
    }
}

struct Chat: Identifiable {
    var id = UUID()
    var name: String
    var lastMessage: String
    var date: String
}
