
import SwiftUI
import UserNotifications

struct Permission: View {
    
    @State var showFullScreen: Bool = false
    
    var body: some View {
        
        NavigationStack {
            
            VStack {
                
                Text("Allowing notifications and contacts lets you\nsee when messages arrive and helps you find\npeople you know. Contacts are encrypted so\nthe Signal service can't see them.")
                    .multilineTextAlignment(.center)
                    .font(.callout)
                    .foregroundColor(.gray)
                
                Spacer()
                Button(action: {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
                        if granted {
                            print("تم السماح بالإشعارات")
                        } else {
                            print("تم رفض الإذن للإشعارات")
                        }
                    }
                    showFullScreen.toggle()
                    
                }, label: {
                    Text("Allow Permissions")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 330, height: 55)
                        .background(Color("background"))
                        .cornerRadius(20)
                    .foregroundColor(.primary) })
                
            }.padding(.top, 60)
            
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Allow Permissions")
                            .font(.largeTitle.bold())
                            .accessibilityAddTraits(.isHeader)
                            .padding(.top, 90)
                    }
                }
        }.fullScreenCover(isPresented: $showFullScreen) {
            LoginView()
        }
    }
}

struct Permission_Previews: PreviewProvider {
    static var previews: some View {
        Permission()
    }
}
