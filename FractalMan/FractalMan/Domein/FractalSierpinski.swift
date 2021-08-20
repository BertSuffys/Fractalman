//
//  FractalMandelbrot.swift
//  FractalMan
//
//  Created by Berto on 13/08/2021.
//

import Foundation
import SpriteKit


class FractalSierpinski : Fractal {
    
    //PARAMETERS
    
    
    
    //CONSTRUCTOR
    
    init(){
        super.init(fractalType : FractalType.SIERPINSKI)
    }
    
    
    //METHODS
    
    
    override func getShader() -> SKShader{
        return SKShader(fileNamed: "SierpinskyJulia")
     }
    
    
    override func requestSubmenuView(del : ParentDelegate) -> UIView{
        let view = Bundle.main.loadNibNamed("SidePanelSirpinski", owner: del, options:nil)
        let q = view?.first as! SidePanelSirpinski
        return q
        //return view
    }
}
