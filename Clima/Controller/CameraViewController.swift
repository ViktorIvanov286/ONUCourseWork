import UIKit
import JGProgressHUD

class CameraViewController: UIViewController, UIImagePickerControllerDelegate {
    
    var myFileManager = MyFileManager()
    var index: IndexPath?
    var nameForImage: String = ""
    var counter: Int = 0
    var hud = JGProgressHUD(style: .light)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var saveButtonOutlet: UIButton!
    @IBOutlet weak var chooseButtonOutlet: UIButton!    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var chooseButtonConstraint: NSLayoutConstraint!
    @IBOutlet weak var saveButtonConstraint: NSLayoutConstraint!
    
    @IBAction func saveButton(_ sender: UIButton) {
        
        let generator = UINotificationFeedbackGenerator()
        
        if imageView.image != nil {
            myFileManager.saveImage(imageName: nameForImage, image: imageView.image!)
        } else {
            let alert = UIAlertController(title: "Warning", message: "You did not select a photo. Please pick an image.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
        
        
        
        let bounds = sender.bounds
        
        UIView.animate(withDuration: 1, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 10, options: .curveEaseInOut, animations: {
            sender.bounds = CGRect(x: bounds.origin.x - 20, y: bounds.origin.y, width: bounds.size.width + 60, height: bounds.size.height)
            generator.notificationOccurred(.success)
        }) { (success: Bool) in
            if success {
                sender.bounds = bounds
                
                UIView.animate(withDuration: 0.1) {
                    self.hud.textLabel.text = "Success"
                    self.hud.indicatorView = JGProgressHUDSuccessIndicatorView()
                }
            }
        }
    }
    
    @IBAction func chooseImageButton(_ sender: UIButton) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Photo Source", message: "Choose a source", preferredStyle: .actionSheet)
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action: UIAlertAction) in
            
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                imagePickerController.sourceType = .camera
                self.present(imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera not available!")
            }
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action: UIAlertAction) in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .cancel, handler: nil))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func animations() {
        UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseOut, animations: {
            self.chooseButtonConstraint.constant -= self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0.25, options: .curveEaseOut, animations: {
            self.saveButtonConstraint.constant += self.view.bounds.width
            self.view.layoutIfNeeded()
        }, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    
        titleLabel.layer.cornerRadius = 10
        titleLabel.layer.masksToBounds = true
        
        saveButtonOutlet.layer.cornerRadius = 10
        saveButtonOutlet.layer.masksToBounds = true
        
        chooseButtonOutlet.layer.cornerRadius = 10
        chooseButtonOutlet.layer.masksToBounds = true
        
        
        chooseButtonConstraint.constant += view.bounds.width
        saveButtonConstraint.constant -= view.bounds.width
        
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        imageView.alpha = 0.5
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if counter == 0 {
            animations()
            counter += 1
        } 
    }
}

extension CameraViewController: UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            imageView.alpha = 1
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
