
import SwiftUI
import Firebase
import FirebaseFirestore

struct conf: View {
    
    @State var conversations: [Message] = []
    let db = Firestore.firestore()

    var body: some View {
        
        List(conversations) { conversation in
            NavigationLink(destination: Chatt(conversation: conversation)) {
                VStack(alignment: .leading) {
                    Text(conversation.userName)
                        .font(.headline)
                    Text(conversation.lastMessage)
                        .font(.subheadline)
                }
            }
        }
    }
    
    func fetchConversations() {
        db.collection("conversations").getDocuments { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let documents = snapshot?.documents else { return }
            self.conversations = documents.map { (document) -> Message in
                let data = document.data()
                let id = document.documentID
                let name = data["name"] as? String ?? ""
                let lastMessage = data["lastMessage"] as? String ?? ""
                let timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
                return Message(id: id, userName: name, lastMessage: lastMessage, timestamp: timestamp)
            }
        }
    }
}

struct conf_Previews: PreviewProvider {
    static var previews: some View {
        conf()
    }
}

