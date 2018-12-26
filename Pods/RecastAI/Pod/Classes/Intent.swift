//
//  Intent.swift
//  Pods
//
//  Created by PE on 29/09/2016.
//
//

import Foundation

/**
 Class Response
 
 Return from the Recast API call
 */
public class Intent : CustomStringConvertible
{
    public var confidence : Float?
    public var slug : String?
    
    /**
     Init class with JSON
     
     - parameter raw : JSON object to init with
     */
    init (intent: [String : AnyObject])
    {
        confidence = intent["confidence"] as? Float
        slug = intent["slug"] as? String
        
    }
    
    public var description: String {
        return slug!
    }
}
