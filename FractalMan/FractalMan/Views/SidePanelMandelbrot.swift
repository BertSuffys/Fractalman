//
//  SidePanelMandelbrot.swift
//  FractalMan
//
//  Created by Berto on 18/08/2021.
//

import SwiftUI

class SidePanelMandelbrot: UIView {
 
     var delegate : ParentDelegate?
    
    
    override init(frame : CGRect){
        super.init(frame:frame)
       // self.commonInit()
    }
    
    
 
    
    required init(del : ParentDelegate){
        super.init(frame: .zero)
        print("init", del==nil)
        self.delegate = del
        print("post init", self.delegate == nil)
        self.commonInit()
    }
    
    required init?(coder : NSCoder){
        super.init(coder : coder)
        
    }
    
    
    
    
    
    func commonInit(){
        let viewFromXib = Bundle.main.loadNibNamed("SidePanelMandelbrot", owner: self, options: nil)![0] as! UIView
        viewFromXib.frame = self.bounds
        addSubview(viewFromXib)
    }
    
    
    
    
    /**
     * Initialiseert de parent delegate voor subpanel signaling
     */
    func setParentDelegate (parentDelegate : ParentDelegate) {
        self.delegate = parentDelegate
    }
    
    
    @IBAction func zoom(_ sender: UISlider) {
        self.delegate?.changeZoom(val: CGFloat(sender.value))
    }
    
    
    
    @IBAction func panX(_ sender: UISlider) {
        print("pqn1")
        self.delegate?.changeOffsetX(val: CGFloat(sender.value))
    }
    
    @IBAction func panY(_ sender: UISlider) {
        self.delegate?.changeOffsetY(val: CGFloat(sender.value))
    }
    
}

