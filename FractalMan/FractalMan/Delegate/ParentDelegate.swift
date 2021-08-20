//
//  ParentDelegate.swift
//  FractalMan
//
//  Created by Berto on 20/08/2021.
//

import Foundation
import UIKit

/**
  Dewe klasse fungeert als delegate voor achterwaardse communicatie van subview naar controller
 */
   protocol ParentDelegate{
    
    
    func changeZoom(val : CGFloat)
    func changeOffsetX(val : CGFloat)
    func changeOffsetY(val : CGFloat)
    func changeIterations(val : CGFloat)
    
    
}
