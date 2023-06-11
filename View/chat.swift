//
//  chat.swift
//  Signall
//
//  Created by Renad Majed on 22/11/1444 AH.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct Chatt: View {
    
    var conversation: Message
    @State var messageText = ""
    let currentUser = Auth.auth().currentUser
    
    var body: some View {
        VStack {
            Text(conversation.userName)
                .font(.headline)
            List {
                // عرض الرسائل هنا
            }
            HStack {
                TextField("Type a message", text: $messageText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                Button(action: sendMessage) {
                    Text("Send")
                }
            }
        }
        .onAppear(perform: createChatRoom)
    }
    
    func createChatRoom() {
        let db = Firestore.firestore()
        let chatRoomId = "\(currentUser!.uid)_\(conversation.id)"
        db.collection("chatRooms").document(chatRoomId).getDocument { (snapshot, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            if let _ = snapshot?.data() {
                // غرفة المحادثة موجودة بالفعل
                return
            }
            // إنشاء غرفة محادثة جديدة
            db.collection("chatRooms").document(chatRoomId).setData([
                "name": conversation.userName,
                "members": [currentUser!.uid, conversation.id]
            ])
        }
    }
    
    func sendMessage() {
        // إرسال الرسالة إلى Firebase
    }
}


//struct Chatt_Previews: PreviewProvider {
//    static var previews: some View {
//        Chatt()
//    }
//}
