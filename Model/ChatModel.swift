
import SwiftUI
import Firebase
import FirebaseFirestore

struct ChatView: View {
    @StateObject var chatViewModel = ChatViewModel()

    var body: some View {
        VStack {
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(chatViewModel.messages) { message in
                        Text("\(message.userName): \(message.lastMessage)")
                    }
                }
            }
            .padding()

            HStack {
                TextField("Message", text: $chatViewModel.newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())

                Button(action: {
                    chatViewModel.sendMessage()
                }, label: {
                    Text("Send")
                })
            }
            .padding()
        }
        .navigationBarTitle("Chats")
        .onAppear(perform: {
            chatViewModel.startListening()
        })
        .onDisappear(perform: {
            chatViewModel.stopListening()
        })
    }
}

