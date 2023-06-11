
import UIKit
import FirebaseStorage

class ViewControllerr: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load the image from Firebase Storage and display it in the UIImageView
        let storageRef = Storage.storage().reference().child("images/image.jpg")
        storageRef.downloadURL { url, error in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
            } else if let url = url {
                URLSession.shared.dataTask(with: url) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            self.imageView.image = image
                        }
                    }
                }.resume()
            }
        }
    }
}
