//
//  FractalMandelbrot.swift
//  FractalMan
//
//  Created by Berto on 13/08/2021.
//

import Foundation
import SpriteKit


class FractalJulia : Fractal {
    
    //PARAMETERS
    
    
    
    //CONSTRUCTOR
    
    init(){
        super.init(fractalType : FractalType.JULIA)
    }
    
    
    //METHODS
    override func getShader() -> SKShader{
        return SKShader(fileNamed: "Julia")
     }
    
    
    override func requestSubmenuView(del : ParentDelegate) -> UIView{
        let view = Bundle.main.loadNibNamed("SidePanelJulia", owner: del, options:nil)
        let q = view?.first as! SidePanelJulia
        
        return q
        //return view
    }

}
