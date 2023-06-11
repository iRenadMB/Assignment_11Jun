
import SwiftUI

struct PrivacyPage: View {
    
    @State var showFullScreen: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Image("onBording")
                    .resizable()
                    .frame(width: 280, height: 290)
                
                Text("Take privacy with you.\nBe yourself in\nevery message.")
                    .multilineTextAlignment(.center)
                    .font(.title)
                    .bold()
                
                VStack{
                    Spacer()
                    
                    Button(action: {
                        if let url = URL(string: "https://signal.org/legal/") {
                            UIApplication.shared.open(url)
                        }
                    }, label: {
                        Text("Terms & Privacy Policy")
                            .foregroundColor(.blue)
                            .font(.callout)
                    })
                    
                    Button(action: {
                        showFullScreen.toggle()
                        
                    }, label: {
                        Text("Continue")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 330, height: 55)
                            .background(Color("background"))
                            .cornerRadius(20)
                        .foregroundColor(.primary) })
                }
            }.padding(.top, 120)
        }.fullScreenCover(isPresented: $showFullScreen) {
            Permission()
        }
    }
}

struct PrivacyPage_Previews: PreviewProvider {
    static var previews: some View {
        PrivacyPage()
    }
}
