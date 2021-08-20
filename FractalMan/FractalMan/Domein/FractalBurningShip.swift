//
//  FractalMandelbrot.swift
//  FractalMan
//
//  Created by Berto on 13/08/2021.
//

import Foundation
import SpriteKit


class FractalBurningShip : Fractal {
    
    //PARAMETERS
    
    
    
    //CONSTRUCTOR
    
    init(){
        super.init(fractalType : FractalType.BURNING_SHIP)
    }
    
    
    //METHODS
    
    
   override func getShader() -> SKShader{
       return SKShader(fileNamed: "BurningShip")
    }
    
    override func requestSubmenuView(del:ParentDelegate) -> UIView{
        let view = Bundle.main.loadNibNamed("SidePanelBurningShip", owner: del, options:nil)
        let q = view?.first as! SidePanelBurningShip
        
        
        
        return q
        //return view
    }
    
}
