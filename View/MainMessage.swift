
import SwiftUI
import FirebaseStorage
import FirebaseFirestore

struct MainMessage: View {
    var body: some View {
        Text("Hello, World!")
    }
    // Upload image to Firebase Storage and save the download URL to Firestore
    func uploadImageAndSaveUrl(image: UIImage, completion: @escaping (String?, Error?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.5) else {
            completion(nil, nil)
            return
        }
        
        let storageRef = Storage.storage().reference().child("images/\(UUID().uuidString).jpg")
        let uploadTask = storageRef.putData(imageData, metadata: nil) { metadata, error in
            if let error = error {
                completion(nil, error)
            } else {
                storageRef.downloadURL { url, error in
                    if let error = error {
                        completion(nil, error)
                    } else {
                        let imageUrl = url?.absoluteString ?? ""
                        Firestore.firestore().collection("users").document("user-id").setData(["image_url": imageUrl], merge: true) { error in
                            completion(imageUrl, error)
                        }
                    }
                }
            }
        }
        
        uploadTask.resume()
    }
}

struct MainMessage_Previews: PreviewProvider {
    static var previews: some View {
        MainMessage()
    }
}
