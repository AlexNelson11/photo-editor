//
//  FilterViewController.swift
//  TechtaGram
//
//  Created by Alex Nelson on 6/29/16.
//  Copyright © 2016 Alex Nelson. All rights reserved.
//

import UIKit

import AssetsLibrary

var image: UIImage!

class FilterViewController: UIViewController {
    
    @IBOutlet var filterImageView: UIImageView!
    
    @IBOutlet var brightnessSlider: UISlider!
    @IBOutlet var saturationSlider: UISlider!
    @IBOutlet var contrastSlider: UISlider!
    
    @IBOutlet var brightnessLabel: UILabel!
    @IBOutlet var saturationLabel: UILabel!
    @IBOutlet var contrastLabel: UILabel!
    
    var originalImage : UIImage!;
    
    var filter : CIFilter!;
    
    var inverted : Float = 1;
    var invertedColor : Float = 1;
    var edited = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad();
        
        brightnessSlider.isContinuous = false;
        saturationSlider.isContinuous = false;
        contrastSlider.isContinuous = false;
        
        brightnessSlider.minimumValue = -1
        brightnessSlider.maximumValue = 1
        saturationSlider.minimumValue = -0
        saturationSlider.maximumValue = 2
        contrastSlider.minimumValue = -0
        contrastSlider.maximumValue = 2.5
        
        brightnessSlider.value = 0
        saturationSlider.value = 1
        contrastSlider.value = 1.25
        
        brightnessSlider.addTarget(self, action: #selector(self.editImage), for: .valueChanged)
        saturationSlider.addTarget(self, action: #selector(self.editImage), for: .valueChanged)
        contrastSlider.addTarget(self, action: #selector(self.editImage), for: .valueChanged)
        
        filterImageView.image = originalImage
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image != nil {
            print("image is not nil")
            filterImageView.image = image
            //originalImage = filterImageView.image
        }else{
            image = originalImage
            print("image is nil")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func editImage(){
        
        edited = true
        
        let filterImage : CIImage = CIImage(image:originalImage)! //else { return }
        filter = CIFilter(name: "CIColorControls")
        filter.setValue(filterImage, forKey: kCIInputImageKey)
        filter.setValue((toPower(base: saturationSlider.value, exponent: 4) - 0) * inverted, forKey: "inputSaturation")
        filter.setValue((brightnessSlider.value - 0) * invertedColor, forKey: "inputBrightness")
        filter.setValue((contrastSlider.value - 0) * invertedColor, forKey: "inputContrast")
        
        saturationLabel.text = String(saturationSlider.value)
        brightnessLabel.text = String(brightnessSlider.value)
        contrastLabel.text = String(contrastSlider.value)
        
        let ctx = CIContext(options: nil)
        let cgImage = ctx.createCGImage(filter.outputImage!, from:filter.outputImage!.extent)
        filterImageView.image = UIImage(cgImage: cgImage!)
        
        //filterImageView.image = UIImage(ciImage: filter.outputImage!)

        originalImage = UIImage(cgImage: cgImage!)//ciImage: filter.outputImage!)
    }
    
    @IBAction func invert(){
        inverted = inverted * -1
        editImage()
    }
    @IBAction func invertColor(){
        invertedColor = invertedColor * -1
        editImage()
    }
    
    @IBAction func cancel(){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(){
        /*originalImage = filterImageView.image
         var image = ViewController().originalImage
         image = self.originalImage*/
        
        if edited == true {
            let imageToSave = filter.outputImage
            let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer: true])
            let cgimg = softwareContext.createCGImage(imageToSave!, from: imageToSave!.extent)
            let library = ALAssetsLibrary()
            library.writeImage(toSavedPhotosAlbum: cgimg, metadata: imageToSave!.properties, completionBlock: nil)
            
            originalImage = filterImageView.image
            image = filterImageView.image
            self.dismiss(animated: true, completion: nil)
            
        }else{
            let imageToSave = CIImage(image:originalImage)
            let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer: true])
            let cgimg = softwareContext.createCGImage(imageToSave!, from: imageToSave!.extent)
            let library = ALAssetsLibrary()
            library.writeImage(toSavedPhotosAlbum: cgimg, metadata: imageToSave!.properties, completionBlock: nil)
            
            originalImage = filterImageView.image
            image = filterImageView.image
            self.dismiss(animated: true, completion: nil)
            
        }
    }
    
    func toPower(base: Float, exponent: Int)-> Float{
   
        
        var result: Float = 1.0
        
        for _ in 0 ..< exponent {
            result = result * base
        }
        
        return result
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        originalImage = UIImage(ciImage: filter.outputImage!)
        
        let originalViewController = segue.destination as! ViewController
        
        originalViewController.originalImage = self.originalImage
        originalViewController.filter = self.filter
        originalViewController.cameraImageView.image = self.filterImageView.image
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
