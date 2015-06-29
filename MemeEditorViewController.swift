//
//  ViewController.swift
//  MemeMe
//
//  Created by Nawfal on 25/06/2015.
//  Copyright (c) 2015 Noufel Gouirhate. All rights reserved.
//

import UIKit

class MemeEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate{

    
    
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    @IBOutlet weak var cameraBtn: UIBarButtonItem!
    @IBOutlet weak var shareBtn: UIBarButtonItem!
    
    var madeChoice = false
    
    var memedImage : UIImage!
    
    let picker = UIImagePickerController()
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),
        NSForegroundColorAttributeName : UIColor.whiteColor(),
        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -1
    ]
    
    
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var toolbarTop: UIToolbar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        picker.delegate = self
        self.topTextField.delegate = self
        self.bottomTextField.delegate = self
        topTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.textAlignment = NSTextAlignment.Center
        topTextField.textAlignment = NSTextAlignment.Center
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
        
    }
    
    func hideBars(response : Bool) {
        self.toolbar.hidden = response
        self.toolbarTop.hidden = response
    }
    
    override func viewWillAppear(animated: Bool) {
        self.cameraBtn.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        self.subcribeToKeyboardNotifications()
        self.shareBtn.enabled = madeChoice
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.unsubscribeFromKeyboardNotifications()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func pickPhotoAlbum(sender: AnyObject) {
        picker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        self.presentViewController(picker, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        if let chosenImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.pickedImage.image = chosenImage
            self.pickedImage.contentMode = UIViewContentMode.ScaleAspectFill
            self.dismissViewControllerAnimated(true, completion: nil)
        }
        madeChoice = true
    }
    
    @IBAction func pickPhotoCamera(sender: AnyObject) {
        picker.sourceType = UIImagePickerControllerSourceType.Camera
        self.presentViewController(picker, animated: true, completion: nil)
    
    }
    
    func textFieldDidBeginEditing(textField: UITextField) {
        textField.text = ""
        textField.text = ""
        
//        if self.bottomTextField.text = "BOTTOM"{
//            self.bottomTextField.removeFromSuperview()
//        }
//        
//        if self.topTextField.text = "TOP"{
//            self.topTextField.removeFromSuperview()
//        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    func subcribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    func unsubscribeFromKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: nil)
    }
    
    
    func keyboardWillShow(notification : NSNotification) {
        if bottomTextField.isFirstResponder() {
            self.view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    func keyboardWillHide(notification : NSNotification) {
        if bottomTextField.isFirstResponder() {
         self.view.frame.origin.y += getKeyboardHeight(notification)
        }
    }
    
    func getKeyboardHeight(notification : NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.CGRectValue().height
    }
    
    func generateMemedImage() -> UIImage {
        
        //Hide the toolbar and navbar
        self.hideBars(true)
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        self.view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        self.memedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return memedImage
    }
    
    func save() {
        //Create the meme
        var meme = Meme(topString : topTextField.text!, bottomString : bottomTextField.text!, originalImage : pickedImage.image!, memedImage : memedImage)
        
        //Add it to the memes array in the Application Delegate
        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(meme)
    }
    
    @IBAction func share(sender: AnyObject) {
        generateMemedImage()
        let controller = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        self.presentViewController(controller, animated: true, completion : nil)
        
        controller.completionWithItemsHandler = {
            (activity, succes, items, error) in
                if succes {
                    self.save()
                    self.dismissViewControllerAnimated(true, completion: nil)
                    let nextViewTable = self.storyboard?.instantiateViewControllerWithIdentifier("MemeTableViewController") as! MemeTableViewController
                    self.presentViewController(nextViewTable, animated: true, completion: nil)
                } else {
                    self.dismissViewControllerAnimated(true, completion: nil)
                }
            
        }
    }
    
    
    @IBAction func cancelEditorView(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
}

