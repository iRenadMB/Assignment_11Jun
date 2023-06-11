
import SwiftUI
import Firebase
import SDWebImageSwiftUI
import FirebaseStorage


struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self, presentationMode: presentationMode)
    }
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        let presentationMode: Binding<PresentationMode>
        
        init(_ parent: ImagePicker, presentationMode: Binding<PresentationMode>) {
            self.parent = parent
            self.presentationMode = presentationMode
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            
            presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            presentationMode.wrappedValue.dismiss()
        }
    }
}

func uploadImage(_ image: UIImage, completion: @escaping (Result<URL, Error>) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.5) else {
        completion(.failure(MyError.imageUploadFailed))
        return
    }
    
    let storageRef = Storage.storage().reference().child("profileImages/\(UUID().uuidString).jpg")
    storageRef.putData(imageData, metadata: nil) { (metadata, error) in
        if let error = error {
            completion(.failure(error))
            return
        }
        
        storageRef.downloadURL { (url, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let downloadURL = url else {
                completion(.failure(MyError.imageDownloadURLFailed))
                return
            }
            
            completion(.success(downloadURL))
        }
    }
}

func updateUser(_ user: User, photoURL: URL?, completion: @escaping (Result<Void, Error>) -> Void) {
    var changeRequest = user.createProfileChangeRequest()
    
    if let photoURL = photoURL {
        changeRequest.photoURL = photoURL
    }
    
    changeRequest.commitChanges { (error) in
        if let error = error {
            completion(.failure(error))
        } else {
            completion(.success(()))
        }
    }
}

enum MyError: Error {
    case imageUploadFailed
    case imageDownloadURLFailed
}
