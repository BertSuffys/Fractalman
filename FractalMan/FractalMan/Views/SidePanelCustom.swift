//
//  SidePanelMandelbrot.swift
//  FractalMan
//
//  Created by Berto on 18/08/2021.
//

import SwiftUI

class SidePanelCustom: UIView {
 
    var parentDelegate : ParentDelegate?
    
    
    
    override init(frame : CGRect){
        super.init(frame:frame)
        self.commonInit()
    }
    
    required init?(coder : NSCoder){
        super.init(coder : coder)
        
    }
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("SidePanelCustom", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    /**
     * Initialiseert de parent delegate voor subpanel signaling
     */
    func setParentDelegate (parentDelegate : ParentDelegate) {
        self.parentDelegate = parentDelegate
    }
}

