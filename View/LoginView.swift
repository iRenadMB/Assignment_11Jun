
import SwiftUI
import Firebase
import FirebaseStorage
import FirebaseAuth

struct LoginView: View {
    
    @State var email: String = ""
    @State var password: String = ""
    @State var userName: String = ""
    @State var isShowingImagePicker: Bool = false
    @State var profileImage: UIImage?
    @State var profileImageUrl: URL?
    @State var showFullScreen: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 15) {
                
                if let profileImage = profileImage {
                    Image(uiImage: profileImage)
                        .resizable()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                } else {
                    Image(systemName: "person.circle.fill")
                        .resizable()
                        .frame(width: 200, height: 200)
                        .foregroundColor(.gray)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                }
                
                Button(action: {
                    self.isShowingImagePicker = true
                }) {
                    Text("Change Profile Picture")
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$profileImage)
                }
                Text("Name")
                TextField("Enter your name", text: $userName)
                    .padding()
                    .overlay(RoundedRectangle(
                        cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                    .frame(width: 350)
//
//                TextField("User Name", text: $userName)
//                    .foregroundColor(.white)
//                    .textFieldStyle(.plain)
//                    .placeholder(when: email.isEmpty) {
//                        Text("User Name")
//                            .foregroundColor(.white)
//                            .bold()
//                    }
                
//                TextField("Email", text: $email)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//
                Text("Email")
                TextField("Enter your email", text: $email)
                    .padding()
                    .overlay(RoundedRectangle(
                        cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                    .frame(width: 350)
                
                Text("Password")
                SecureField("Enter your password", text: $password)
                    .padding()
                    .overlay(RoundedRectangle(
                        cornerRadius: 10.0).strokeBorder(Color.gray, style: StrokeStyle(lineWidth: 1.0)))
                    .frame(width: 350)
  
//                SecureField("Password", text: $password)
//                    .textFieldStyle(RoundedBorderTextFieldStyle())
//                    .padding()
//
                Button(action: {
                    Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
                        if let error = error {
                            print("Error signing in: \(error.localizedDescription)")
                        } else {
                            print("User signed in successfully.")
                            
                            if let user = Auth.auth().currentUser {
                                updateUser(user, photoURL: profileImageUrl) { (result) in
                                    switch result {
                                    case .success:
                                        print("User profile updated successfully.")
                                    case .failure(let error):
                                        print("Error updating user profile: \(error.localizedDescription)")
                                    }
                                }
                            }
                        }
                    }
                }) {
                    Button(action: {
                        register()
                        showFullScreen.toggle()
                        
                    }, label: {
                        Text("Sign in")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .frame(width: 330, height: 55)
                            .background(Color("background"))
                            .cornerRadius(20)
                        .foregroundColor(.primary) })
                }
            }
        }.fullScreenCover(isPresented: $showFullScreen) {
            SignalView()
        }
    }
    
    func loadImage() {
        guard let image = profileImage else { return }
        
        uploadImage(image) { (result) in
            switch result {
            case .success(let url):
                self.profileImageUrl = url
            case .failure(let error):
                print("Error uploading image: \(error.localizedDescription)")
            }
        }
    }
    
    func login() {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if error != nil {
                print (error!.localizedDescription)
            }
        }
    }
    
    func register() {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if error != nil {
                print(error!.localizedDescription)
            }
        }
    }
    
    func signIn() {
        if !email.hasSuffix(".com") {
            print("Invalid email format")
        } else {
            Auth.auth().signIn(withEmail: email, password: password) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        }
    }

    func registeration() {
        if !email.hasSuffix(".com") {
            print("Invalid email format")
        } else {
            Auth.auth().createUser(withEmail: email, password: password) { result, error in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        }
    }

}
