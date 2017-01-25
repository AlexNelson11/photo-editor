//
//  ViewController.swift
//  TechtaGram
//
//  Created by Alex Nelson on 6/8/16.
//  Copyright © 2016 Alex Nelson. All rights reserved.
//

import UIKit

import AssetsLibrary

import Accounts


class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet var cameraImageView: UIImageView!
    
    var originalImage : UIImage!
    
    var filter : CIFilter!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        originalImage = UIImage(named: "hoshi.png")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if image != nil {
            cameraImageView.image = image
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func takePhoto(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.camera
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
            
        }else{
            print("error")
        }
    }
    @IBAction func savePhoto(){
  
        /*let imageToSave = CIImage(image:originalImage)
        let softwareContext = CIContext(options: [kCIContextUseSoftwareRenderer: true])
        let cgimg = softwareContext.createCGImage(imageToSave!, fromRect: imageToSave!.extent)
        let library = ALAssetsLibrary()
        library.writeImageToSavedPhotosAlbum(cgimg, metadata: imageToSave!.properties, completionBlock: nil)
        
        let alert = UIAlertController(title: "Image sucessfully saved", message: "", preferredStyle: UIAlertControllerStyle.Alert)
        
        alert.addAction(UIAlertAction(title: "Image sucessfully saved", style: .Default, handler: { action in self.dismissViewControllerAnimated(true, completion: nil)}))*/
    }
    @IBAction func colorFilter(){
       
    }
    @IBAction func openAlbum(){
        
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary){
            
            let picker = UIImagePickerController()
            picker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            picker.delegate = self
            
            picker.allowsEditing = true
            
            present(picker, animated: true, completion: nil)
            
        }else{
            print("error")
        }
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]){
        
        cameraImageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        originalImage = cameraImageView.image
        image = cameraImageView.image
        
        dismiss(animated: true, completion: nil)
    }
    @IBAction func snsPost(){
        
        let shareText = "I took this picture"
        
        let shareImage = cameraImageView.image!
        
        let activityItems = [shareText, shareImage] as [Any]
        
        let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
        
        let excludedActivityTypes = [UIActivityType.postToWeibo]
        
        activityVC.excludedActivityTypes = excludedActivityTypes
        
        self.present(activityVC, animated: true, completion: nil)
        
        
        
        
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let filterViewController = segue.destination as! FilterViewController
        
        filterViewController.originalImage = self.originalImage
        //filterViewController.filterImageView.image = self.cameraImageView.image
        //filterViewController.filter = self.filter
    
    }
    
}







//<#§1234567890’^°+”*ç%&/()=??`ﬁ±“#Ç[]|{}≠¿´‰∞”‹⁄[]\ÒÔÚ^qwertzuiopü¨QWERTZUIOPè!œ∑€®†Ω°¡øπ§’ŒÁËÈÎÍÙıØ∏ÿasdfghjklöä$ASDFGHJKLéà£åß∂ƒ@ªº∆¬¢æ¶Åﬁﬂ‡‚·˜¯ˆ˘Æ•<yxcvbnm,.->YXCVBNM;:_≤¥≈©√∫~µ«…–≥Ÿ™◊˙˚»÷—#>


//<#code#>.



