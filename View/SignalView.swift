
import SwiftUI

struct SignalView: View {
    
//    let chats = Chat.sampleChat
    @State private var showBackButton: Bool = true
    @State var showFullScreen1: Bool = false

    var body: some View {

        NavigationView {

            List {
//                ForEach(chats) { chat in
//                    ChatRow(chat: chat)
//                }
//                Button(action: {
////                    ViewController()
//                }) {
//                    Image (systemName: "camera")
//                }
                HStack {
                    if showBackButton {
                        backButton
                    }
                    Spacer()
                    
                    titleSection
                }
                .padding()
                .accentColor(.black)
                .background(Color.white.ignoresSafeArea(edges: .top))
                
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Chats")
            .navigationBarItems(trailing: Button(action: {}) {
                Image (systemName: "pencil")
            })
            .navigationBarItems(trailing: Button(action: {}) {
                Image (systemName: "camera")
            })
        }
    }
}

struct SignalView_Previews: PreviewProvider {
    static var previews: some View {
        SignalView()
    }
}

extension SignalView {
    
    private var backButton: some View{
        
        NavigationLink(destination: MainMessage()){
            
            Button(action: {
                showFullScreen1.toggle()
                
            }, label: {
                Image(systemName: "chevron.left")
            })
        }
    }
    
    private var titleSection: some View{
        VStack(spacing: 4) {
            
            Text("Sign up and get started on your own podcast!")
                .font(.system(size: 25, weight: .heavy, design: .default))
                .fontWeight(.semibold)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 20)
        }
    }
}
