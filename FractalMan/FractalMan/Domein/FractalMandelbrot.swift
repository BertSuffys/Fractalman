//
//  FractalMandelbrot.swift
//  FractalMan
//
//  Created by Berto on 13/08/2021.
//

import Foundation
import SpriteKit


class FractalMandelbrot : Fractal {
    
    //PARAMETERS
    
    
    
    //CONSTRUCTOR
    
    init(){
        super.init(fractalType : FractalType.MANDELBROT)
    }
    
    
    //METHODS
    
    
    override func getShader() -> SKShader {
       return SKShader(fileNamed: "Mandelbrot")
    }
    
    
    override func requestSubmenuView(del:ParentDelegate) -> UIView{
        let view = Bundle.main.loadNibNamed("SidePanelMandelbrot", owner: del, options:nil)
        let q = view?.first as! SidePanelMandelbrot
        
        q.delegate = del
        
        return q
        //return view
    }
    
    
}
