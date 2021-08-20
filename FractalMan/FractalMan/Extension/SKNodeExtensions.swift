//
//  SKNodeExtensions.swift
//  FractalMan
//
//  Created by Berto on 12/08/2021.
//

import UIKit
import SpriteKit
import Foundation



extension SKNode {
    
    class func unarchiveFromFile (file:String) -> SKNode? {
        if let path = Bundle.main.path(forResource: file, ofType: "sks"){
            
            
            do {
                let sceneData = try NSData(contentsOfFile: path, options: .dataReadingMapped)
                
                let archiver = try NSKeyedUnarchiver(forReadingWith:  sceneData as Data)
                    
                archiver.setClass(self.classForKeyedUnarchiver(), forClassName: "SKScene")
                
                let scene = archiver.decodeObject(forKey: NSKeyedArchiveRootObjectKey) as! FractalScene
                
                archiver.finishDecoding()
            
                
            return scene
                
            }catch{
                return nil
            }
            
        }else{
            return nil
        }
        
    }
}




