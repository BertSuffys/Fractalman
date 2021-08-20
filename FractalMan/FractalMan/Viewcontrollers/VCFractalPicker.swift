//
//  VCFractalPicker.swift
//  FractalMan
//
//  Created by Berto on 12/08/2021.
//

import UIKit



/**
  Viewcontroller voor het navigeren naar de effectieve fractal displayer
 */
class VCFractalPicker: UIViewController {

    //PARAMETERS
    
    //Alle buttons met fractal opties
    @IBOutlet var fractalPickerButtons: [UIButton]!

    @IBOutlet weak var scroller: UIScrollView!
    
    
    //METHODS
    
    
    /**
     * De view is volledig in memory geladen
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        self.scroller.contentSize = CGSize(width:300.0, height:700.0)
    }
    
    
    
    /**
     * Voorbereidende methode bij het overgaan naar de volgende viewcontroller
     */
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Stel de fractalManager op
        var fractalManager : FractalManager
        // Afhankelijk van de fractalkeuze instantieren we de fractal in de manager
        
        // MANDELBROT
        if(segue.identifier == "SEGMandelbrot"){
            let mandelbrot : Fractal = FractalMandelbrot()
            fractalManager = FractalManager(fractal : mandelbrot)
        }
        // JULIA
        else if(segue.identifier == "SEGJulia"){
            let julia : Fractal = FractalJulia()
            fractalManager = FractalManager(fractal : julia)
        }
        // BURNING SHIP
        else if(segue.identifier == "SEGBurningShip"){
            let ship : Fractal = FractalBurningShip()
            fractalManager = FractalManager(fractal : ship)
        }
        // SIERPINSKI JULIA
        else if(segue.identifier == "SEGSierpinski"){
            let ship : Fractal = FractalSierpinski()
            fractalManager = FractalManager(fractal : ship)
        }
        // CUSTOM
        else{
            let ship : Fractal = FractalSierpinski()
            fractalManager = FractalManager(fractal : ship)
        }

        // Initialize de fractalmanager in de volgende  viewcontroller
        guard let vc_fractal = segue.destination as? VCFractal else{return}
        vc_fractal.fractalManager = fractalManager
    }
    
    
    
    
    



}
