//
//  MemeTableViewController.swift
//  MemeMe
//
//  Created by Nawfal on 26/06/2015.
//  Copyright (c) 2015 Noufel Gouirhate. All rights reserved.
//

import Foundation
import UIKit

class MemeTableViewController: UITableViewController, UITableViewDataSource, UITableViewDelegate {

    var memes : [Meme]!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)

        let object = UIApplication.sharedApplication().delegate
        let appDelegate = object as! AppDelegate
        memes = appDelegate.memes
        tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    @IBAction func editeMeme(sender: AnyObject) {
        
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("memedImage") as! UITableViewCell
        let meme = memes[indexPath.row]
        cell.imageView?.image = meme.memedImage
        cell.textLabel?.text = "\(meme.topString)...\(meme.bottomString)"
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailController = self.storyboard!.instantiateViewControllerWithIdentifier("DetailViewController") as! DetailViewController
        detailController.meme = self.memes[indexPath.row]
        self.navigationController!.pushViewController(detailController, animated: true)
    }
    
    @IBAction func goToEditor(sender: AnyObject) {
        performSegueWithIdentifier("editorView", sender: sender)
    }
}
