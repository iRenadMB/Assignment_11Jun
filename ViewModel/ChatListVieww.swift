////
////  ChatListVieww.swift
////  Signall
////
////  Created by Renad Majed on 22/11/1444 AH.
////
//
//import Foundation
//
//struct ChatRowVieww: View {
//    
//
//    var body: some View {
//        HStack {
//            Image(systemName: "person.circle.fill")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(width: 60, height: 60)
//                .foregroundColor(.gray)
//                .padding(.trailing)
//
//            VStack(alignment: .leading) {
//                Text(chat.name)
//                    .font(.headline)
//                Text(chat.lastMessage)
//                    .font(.subheadline)
//                    .foregroundColor(.gray)
//            }
//            Spacer()
//
//            VStack {
//                Text(chat.date)
//                    .font(.caption)
//                    .foregroundColor(.gray)
//                    .padding(.bottom, 4)
//                if true {
//                    Text("2")
//                        .font(.caption)
//                        .foregroundColor(.white)
//                        .padding(4)
//                        .background(Color.blue)
//                        .clipShape(Circle())
//                }
//            }
//        }
//        .padding()
//    }
//}
//
//struct ChatDetailView: View {
//
//    var chat: Chat
//
//    var body: some View {
//        VStack {
//            Spacer()
//            Text(chat.name)
//                .font(.largeTitle)
//                .fontWeight(.bold)
//            Spacer()
//            Text(chat.lastMessage)
//                .font(.title2)
//                .foregroundColor(.gray)
//            Spacer()
//            Text(chat.date)
//                .font(.caption)
//                .foregroundColor(.gray)
//        }
//    }
//}
