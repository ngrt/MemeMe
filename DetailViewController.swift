//
//  DetailViewController.swift
//  MemeMe
//
//  Created by Nawfal on 28/06/2015.
//  Copyright (c) 2015 Noufel Gouirhate. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var meme: Meme!
    
    @IBOutlet weak var imageMeme: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
        self.tabBarController?.tabBar.hidden = true
        self.imageMeme!.image = meme.memedImage
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(true)
        self.tabBarController?.tabBar.hidden = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func edit() {
        let editorController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditorViewController") as! MemeEditorViewController
        editorController.topTextField!.text = meme.topString
        editorController.bottomTextField!.text = meme.bottomString
        editorController.pickedImage!.image = meme.memedImage
        
        self.navigationController!.pushViewController(editorController, animated: true)
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
