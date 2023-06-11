
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        
        Main()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Main : View {
    
    @ObservedObject var obser = Observer()
    
    var body : some View {
        
        NavigationView {
            
            List(obser.users) { i in
                
                Text(i.name).padding(.leading, 10)
            }.navigationBarTitle("Users")
        }
    }
}
