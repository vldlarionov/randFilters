//
//  ViewController.swift
//  randFilters
//
//  Created by vbox on 2018-10-31.
//  Copyright © 2018 vbox. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var photoImageView: UIImageView!
    
    let contex = CIContext(options: nil)
    
    
    @IBAction func applyFilter(_ sender: Any) {
        
        let inputImage = CIImage(image: photoImageView.image!)
        let randomColor = [kCIInputAngleKey: (Double(arc4random_uniform(314)) / 100)]
        let filteredImage = inputImage?.applyingFilter("CIHueAdjust", parameters: randomColor)
        let renderedImage = contex.createCGImage(filteredImage!, from: filteredImage!.extent)
        photoImageView.image = UIImage(cgImage: renderedImage!)
    }
    
    
 
    @IBAction func showNotFilteredImage(_ sender: Any) {
        
        photoImageView.image = #imageLiteral(resourceName: "cat.jpg")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

