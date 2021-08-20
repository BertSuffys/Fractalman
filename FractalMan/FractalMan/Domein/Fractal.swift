//
//  Fractal.swift
//  FractalMan
//
//  Created by Berto on 12/08/2021.
//

import Foundation
import SpriteKit


class Fractal : ShaderGenerator{
    
    //PARAMETERS
    var fractalType : FractalType?
    
    
    //CONSTRUCTOR

    init(fractalType : FractalType){
        self.fractalType = fractalType
    }
    
    //METHODS
    
    func getShader() -> SKShader {
        preconditionFailure("getShader() in Fractal must be overridden.")
    }
    
    
    
    
    /**
     * Injecteer een custom view in het submenu
     */
    func requestSubmenuView(del:ParentDelegate) -> UIView{
        preconditionFailure("requestSidepanelView() in Fractal must be overridden.")
    }
    

    
    
}



protocol ShaderGenerator {
    func getShader() -> SKShader
}


