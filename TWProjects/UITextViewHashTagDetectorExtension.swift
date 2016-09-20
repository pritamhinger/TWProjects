//
//  UITextViewHashTagDetectorExtension.swift
//  TWProjects
//
//  Created by Pritam Hinger on 19/09/16.
//  Copyright © 2016 AppDevelapp. All rights reserved.
//

import Foundation
import UIKit

extension UITextField{
    func detectHashTags() -> String? {
        
        var tags:String = ""
        
        // turn string in to NSString
        let nsText:NSString = self.text!
        
        // this needs to be an array of NSString.  String does not work.
        let words:[NSString] = nsText.componentsSeparatedByString(" ")
        
        // tag each word if it has a hashtag
        for word in words {
            
            // found a word that is prepended by a hashtag!
            // homework for you: implement @mentions here too.
            if word.hasPrefix("#") && word.length > 1{
                tags = "\(word),\(tags)"
            }
        }
        
        if tags.characters.count > 0{
            tags = tags.stringByReplacingOccurrencesOfString("#", withString: "")
            
            let length = tags.characters.count
            if( length > 0){
                tags = tags.substringToIndex(tags.endIndex.predecessor())
            }
        }
        
        if tags.characters.count == 0{
            return nil
        }
        
        return tags
    }
}