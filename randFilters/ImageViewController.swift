//
//  ImageViewController.swift
//  randFilters
//
//  Created by vbox on 2018-12-05.
//  Copyright © 2018 vbox. All rights reserved.
//

import UIKit
import Photos
import AssetsLibrary

class ImageViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePickerController = UIImagePickerController()
    
    var context = CIContext(options: nil)
    var filter : CIFilter!
    var beginImage : CIImage!
    
    @IBAction func applyFilter(_ sender: Any) {
        
        let inputImage = CIImage(image: myImageView.image!)
        let randomColor = [kCIInputAngleKey: (Double(arc4random_uniform(314)) / 100)]
        let filteredImage = inputImage?.applyingFilter("CIHueAdjust", parameters: randomColor)
        let renderedImage = context.createCGImage(filteredImage!, from: filteredImage!.extent)
        self.myImageView.image = UIImage(cgImage: renderedImage!)
        
    }
    
    @IBOutlet weak var myImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
        // Do any additional setup after loading the view.
    }

    
    @IBAction func saveImage(_ sender: Any) {
        
        let imageData = UIImagePNGRepresentation(myImageView.image!)
        let compressedImage = UIImage(data: imageData!)
        UIImageWriteToSavedPhotosAlbum(compressedImage!, nil, nil, nil)
        
        let alert = UIAlertController(title: "Saved", message: "Your image has been saved", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
        
    }
    @IBAction func chooseImage(_ sender: Any) {
        
        let actionSheet = UIAlertController(title: "Photo source", message: "Image source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action:UIAlertAction) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                self.imagePickerController.sourceType = .camera
                self.present(self.imagePickerController, animated: true, completion: nil)
            } else {
                print("Camera is not available")
            }
            }))
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action:UIAlertAction) in
            self.imagePickerController.sourceType = .photoLibrary
            self.present(self.imagePickerController, animated: true, completion: nil)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil
        ))
        
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image = info[UIImagePickerControllerOriginalImage] as? UIImage
        myImageView.image = image
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
