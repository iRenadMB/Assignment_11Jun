
import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var imagePickerController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a UIButton and add it to the view
        let cameraButton = UIButton(type: .system)
        cameraButton.setTitle("Open Camera", for: .normal)
        cameraButton.addTarget(self, action: #selector(openCamera), for: .touchUpInside)
        view.addSubview(cameraButton)
        
        // Configure the UIButton constraints
        cameraButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            cameraButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            cameraButton.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        // Configure the UIImagePickerController
        imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .camera
        imagePickerController.allowsEditing = false
    }
    
    @objc func openCamera() {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    // Implement the UIImagePickerControllerDelegate method to handle image selection
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.originalImage] as? UIImage else {
            dismiss(animated: true, completion: nil)
            return
        }
        
        // Handle the selected image
        // ...
        
        dismiss(animated: true, completion: nil)
    }
}
