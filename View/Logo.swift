
import SwiftUI

struct Logo: View {
    
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    
    var body: some View {
        
        NavigationView{
            
            if isActive {
                PrivacyPage()
                
            } else {
                
                ZStack{
                    
                    Color("background").edgesIgnoringSafeArea(.all)
                    
                    Image("AppLogo")
                        .resizable()
                        .frame(width: 160, height: 140)
                    
                }.onAppear{
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct Logo_Previews: PreviewProvider {
    static var previews: some View {
        Logo()
    }
}
