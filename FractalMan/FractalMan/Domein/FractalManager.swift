//
//  FractalManager.swift
//  FractalMan
//
//  Created by Berto on 12/08/2021.
//

import Foundation
import SpriteKit

class FractalManager {
    
    //PARAMETERS
    var fractal : Fractal?
    
    
    
    
    //CONSTRUCTOR
    init (fractal : Fractal){
        self.fractal = fractal
    }
    
    
    //METHODS
    
    /**
     * Haal de shader op , afhankelijk van de fractal
     * en initialiseer enkele default uniforms
     */
    func initializeShaderAndUniforms(node : SKSpriteNode){
        //
        let shader : SKShader = fractal!.getShader()
        shader.addUniform(SKUniform(name: "offset", vectorFloat2: vector_float2(x: 0.0, y: 0.0)))
        shader.addUniform(SKUniform(name:"zoom", float: 1.0))
        //shader.addUniform(SKUniform(name:"iterations", float: 128.0))
        node.shader = shader
    }
    
    
    
    /**
     * Injecteer een custom view in het submenu
     */
    func requestSubmenuView(del : ParentDelegate) -> UIView{
        return self.fractal!.requestSubmenuView(del : del)
    }
    
    

    
    
   


    
}
