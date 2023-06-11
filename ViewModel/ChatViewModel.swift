
import SwiftUI
import Firebase
import FirebaseFirestore

class ChatViewModel: ObservableObject {
    @Published var messages = [Message]()
    @Published var newMessage = ""

    private var db = Firestore.firestore()
    private var listenerRegistration: ListenerRegistration?

    func sendMessage() {
        guard let currentUser = Auth.auth().currentUser else {
            print("User is not signed in")
            return
        }

        let message = [
            "body": newMessage,
            "author": currentUser.uid,
            "timestamp": Timestamp()
        ] as [String : Any]

        db.collection("messages").addDocument(data: message) { error in
            if let error = error {
                print("Error sending message: \(error.localizedDescription)")
                return
            }

            self.newMessage = ""
        }
    }

    func startListening() {
        listenerRegistration = db.collection("messages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, error in
                if let error = error {
                    print("Error listening for messages: \(error.localizedDescription)")
                    return
                }

                guard let documents = querySnapshot?.documents else {
                    print("No documents")
                    return
                }

                self.messages = documents.map { queryDocumentSnapshot -> Message in
                    let data = queryDocumentSnapshot.data()
                    let id = queryDocumentSnapshot.documentID
                    let body = data["body"] as? String ?? ""
                    let userName = data["author"] as? String ?? ""

                    return Message(id: id, body: body, userName: userName)
                }
            }
    }

    func stopListening() {
        listenerRegistration?.remove()
    }
}
