//
//  Meme.swift
//  MemeMe
//
//  Created by Nawfal on 25/06/2015.
//  Copyright (c) 2015 Noufel Gouirhate. All rights reserved.
//

import Foundation
import UIKit

struct Meme {
    
    var topString : String!
    var bottomString : String!
    var originalImage : UIImage!
    var memedImage : UIImage!
    
    init(topString : String, bottomString : String, originalImage : UIImage, memedImage : UIImage){
        self.topString = topString
        self.bottomString = bottomString
        self.originalImage = originalImage
        self.memedImage = memedImage
    }

}
