//
//  VCFractal.swift
//  FractalMan
//
//  Created by Berto on 12/08/2021.
//

import UIKit
import SpriteKit





class VCFractal: UIViewController, UIScrollViewDelegate, ParentDelegate  {

    

    // *************** PARAMETERS ***************
    
    
    
    
    //Reference to the content of the subpanel
    
    @IBOutlet weak var panelParent: UIView!
    
   
    @IBOutlet weak var panelContent: SidePanelMandelbrot!
    
    var newPanelContent : UIView!
    
    @IBOutlet weak var panelLabel: UILabel!
    
    
    @IBOutlet weak var photoButton: UIButton!
    
    
    //Subpanel outlets for styling and opening mainly
    @IBOutlet weak var handleBlurView: UIVisualEffectView!
    
    @IBOutlet weak var panelBlurView: UIVisualEffectView!
    
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var panelView: UIView!
    
    // Detector van het pannen op het scherm
    @IBOutlet var panner: UIPanGestureRecognizer!
    
    
    // Fractalmanager die de correcte fractal bijhoudt en beheert
    var fractalManager : FractalManager? = nil
    // De sprite uit de scene waarop de shader werkt
    var node: SKSpriteNode!
    // De scrollview die toelaat om te pannen en zoomen
    @IBOutlet weak var scrollView: UIScrollView!
    // De container in de scrollview
    @IBOutlet weak var contentView: UIView!
    
    
    // *************** CONSTRUCTOR ***************
    
    
    // *************** METHODS ***************
    
    
    
    /**
     * Methode opgeroepen wanneer de view volledig in memory geladen werd
     */
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.handleBlurView.addGestureRecognizer(panner)
        
        //Enhance panel graphically
        self.handleBlurView.roundCorners(corners: [.bottomRight, .topRight], radius: 5.0)
        self.handleBlurView.layer.shadowColor = UIColor.black.cgColor
        self.handleBlurView.layer.shadowOpacity = 1
        self.handleBlurView.layer.shadowOffset = CGSize(width: 30.0, height: 0.0)
        
        self.viewConstraint.constant = -175
        
        
        // Boolean value ter verberging van de statusbar -> fullscreen
        self.modalPresentationCapturesStatusBarAppearance = true
        
        // Delegate instellen op zichzel
        self.scrollView.delegate = self
    
        // Controle op het bestaan van de scene
        self.checkOpBestaanVanScene()
        
        
        // Haal de Scene uit FractalScene.sks op
        if let scene = SKScene(fileNamed: "FractalScene") as? FractalScene {

            // Haal eigen view op en cast naar SKView
            let skView = self.view as! SKView
            skView.ignoresSiblingOrder = true
            
            // Zet de SKScene op fullscreen
            scene.scaleMode = .fill
            scene.size = skView.bounds.size
            
            // Includeer shaders
            scene.shouldEnableEffects = true
            
            // Haal de sprite (Kind) van de scene op
            node = scene.childNode(withName: "FractalSprite") as? SKSpriteNode
            
            // Laat de fractalmanager de shader opvullen
            self.fractalManager!.initializeShaderAndUniforms(node:node)

            // Presenteer de SKScene in onze controllers view
            skView.presentScene(scene)
        }
        // Initialiseer de titel
        self.title = self.fractalManager?.fractal?.fractalType?.rawValue
        // Gegeven de initiele scrollview eigenschappen, update de shader eens.
        self.updateShader(scrollView : self.scrollView)
        // Initialiseer de inhoud van het submenu
        self.injectSidepanel()
    
    }
    
    
    
    /**
     * Setup side panel
     */
    func injectSidepanel(){
        // Steek een custom view in het sidepanel
        let v = self.fractalManager?.requestSubmenuView(del:self)
        
        
        let view = Bundle.main.loadNibNamed("SidePanelMandelbrot", owner: self, options:nil)
        let q = view?.first as! SidePanelMandelbrot
        
        q.delegate = self
        self.newPanelContent = v
        
       // self.newPanelContent.setpar
        
        
        

        


        
        self.panelContent.removeFromSuperview()
        
        self.panelParent.addSubview(newPanelContent)

        newPanelContent.translatesAutoresizingMaskIntoConstraints = false
        
        let r = newPanelContent.rightAnchor.constraint(equalTo: self.panelParent.rightAnchor)
        let l = newPanelContent.leftAnchor.constraint(equalTo: self.panelParent.leftAnchor)
        //let h = newPanelContent.heightAnchor.constraint(equalToConstant: 100)
        
        let b = newPanelContent.bottomAnchor.constraint(equalTo: self.photoButton.topAnchor)
        let t = newPanelContent.topAnchor.constraint(equalTo: self.panelLabel.bottomAnchor)
        self.panelParent.addConstraints([r,l, t, b])
    }
    
    
    

    /**
     * Methode opgeroepen wanneer de view volledig weergegeven werd
     */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //
        scrollView.setNeedsLayout()
        
        //
        scrollView.layoutIfNeeded()
        
        //
        //self.scrollView.contentSize = CGSize(width: 2000.0, height: 4000.6)
        self.updateShader(scrollView : self.scrollView)
        
        
        
        
    }
    

    
 
    /**
     * Handler voor het open trekken van het submenu
     */
    @IBAction func pan(_ sender: UIPanGestureRecognizer) {
        
        // Beginnen draggen of verder draggen
        if(sender.state == .began || sender.state == .changed){
            let translation = sender.translation(in: self.handleBlurView).x
            
            // DRAG OPEN
            if(translation > 0){
                let limiet : CGFloat = -5.0
                if(self.viewConstraint.constant < limiet){
                    self.viewConstraint.constant = min(self.viewConstraint.constant + translation, -0.5 )
                }
            }
            // DRAG CLOSE
            else{
                let limiet : CGFloat = -175.0
                if(self.viewConstraint.constant > limiet){
                    self.viewConstraint.constant = max(self.viewConstraint.constant + translation , -175.0)
                }
            }
   
        }
        // Stoppen met draggen
        else if(sender.state == .ended){
            let limitBehaviorSplit : CGFloat = -130
            // POP CLOSED
            if(self.viewConstraint.constant <  limitBehaviorSplit){
                self.viewConstraint.constant = -175
            }
            //
            else{
                UIView.animate(withDuration: 0.2, animations: {
                    self.viewConstraint.constant = -5
                    self.view.layoutIfNeeded()
                })
            }
        }
    }
    

    /**
     * Methode die de shader uniforms updatet en de fractal hertekent
     */
    func updateShader(scrollView: UIScrollView) {

        // Haal de general zoom uniform op
        let zoomUniform = node.shader!.uniformNamed("zoom")!
        // Haal de general offset uniform op
        var offsetUniform = node.shader!.uniformNamed("offset")!
        
        var offset = scrollView.contentOffset
        
        offset.x /= scrollView.contentSize.width
        offset.y /= scrollView.contentSize.height
        

        
        zoomUniform.floatValue = Float(scrollView.zoomScale)
        
        //SKUniform

        offsetUniform.floatVector2Value = GLKVector2Make(Float(offset.x), Float(offset.y))
        
    }

    /**
     * De foto button werd aangeklikt
     */
    
    @IBAction func photoButton(_ sender: Any) {
        
        // Haal de Scene uit FractalScene.sks op
        if let scene = SKScene(fileNamed: "FractalScene") as? FractalScene {

            // Haal eigen view op en cast naar SKView
            let skView = self.view as! SKView
            skView.ignoresSiblingOrder = true
            
            // Zet de SKScene op fullscreen
            scene.scaleMode = .fill
            scene.size = skView.bounds.size
            
            // Includeer shaders
            scene.shouldEnableEffects = true
            
            // Haal de sprite (Kind) van de scene op
            node = scene.childNode(withName: "FractalSprite") as? SKSpriteNode
            
            // Laat de fractalmanager de shader opvullen
            self.fractalManager!.initializeShaderAndUniforms(node:node)

            self.updateShader(scrollView: self.scrollView)
            self.takePicture(img: scene.toImage()!)
        }
 
   
    }
    
    
    

    /**
     * Methode die een UIImage, gegenereerd uit een view lokaal opslaat
     */
    func takePicture(img : UIImage) -> String {
        print(" .. BEGIN SAVING PICTURE .. ")
        
        // Stel de directory op
        let paths : [URL] = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        //let dir = paths[0].absoluteString.appending("/Fractals/")
        //let dir = NSHomeDirectoryForUser("berto")!.appending("/Fractals/")
        //var dir : String! = (NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true) as [String]).first
        
        var dir = "Users/berto/Fractals/"
        
        // Indien bovenstaande directory nog niet bestaat, tracht het te maken.
        if !FileManager.default.fileExists(atPath: dir){
            print(" .. CREATING : \(dir)")
            do {
                try FileManager.default.createDirectory(at: NSURL.fileURL(withPath: dir), withIntermediateDirectories: true, attributes: nil)
            }catch{
                print(error)
            }
        }
        
        // Maak een dateformatter
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        // Stel de filenaam op (datum.jpg)
        let fileNaam = dateFormatter.string(from: Date()).appending(".jpg")
        // Stel de filenaam + pad op
        let filePad = dir.appending(fileNaam)
        // Maak van fileNaam + Pad een URL
        let url : URL = NSURL.fileURL(withPath: filePad)
        // Tracht de afbeelding op te slaan op de URL
        
        
        do {
            try img.jpegData(compressionQuality: 1.0)!.write(to: url, options: .atomic)
            self.showToast(message: "Image saved.")
            return String.init("/Documents/\(fileNaam)")
            
        }catch{
            print(error)
            print("Bestand kan niet worden opgeslaan naar \(filePad)")
            return filePad
        }
    }
    
    
    
    
    /**
     * Toon een toaster
     */
    func showToast(message: String) {
                let toastContainer = UIView(frame: CGRect())
                toastContainer.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                toastContainer.alpha = 0.0
                toastContainer.layer.cornerRadius = 20;
                toastContainer.clipsToBounds  =  true

                let toastLabel = UILabel(frame: CGRect())
                toastLabel.textColor = UIColor.white
                toastLabel.textAlignment = .center;
                toastLabel.font.withSize(12.0)
                toastLabel.text = message
                toastLabel.clipsToBounds  =  true
                toastLabel.numberOfLines = 0

                toastContainer.addSubview(toastLabel)
                self.view.addSubview(toastContainer)

                toastLabel.translatesAutoresizingMaskIntoConstraints = false
                toastContainer.translatesAutoresizingMaskIntoConstraints = false

                let centerX = NSLayoutConstraint(item: toastLabel, attribute: .centerX, relatedBy: .equal, toItem: toastContainer, attribute: .centerXWithinMargins, multiplier: 1, constant: 0)
                let lableBottom = NSLayoutConstraint(item: toastLabel, attribute: .bottom, relatedBy: .equal, toItem: toastContainer, attribute: .bottom, multiplier: 1, constant: -15)
                let lableTop = NSLayoutConstraint(item: toastLabel, attribute: .top, relatedBy: .equal, toItem: toastContainer, attribute: .top, multiplier: 1, constant: 15)
                toastContainer.addConstraints([centerX, lableBottom, lableTop])

                let containerCenterX = NSLayoutConstraint(item: toastContainer, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
                let containerTrailing = NSLayoutConstraint(item: toastContainer, attribute: .width, relatedBy: .equal, toItem: toastLabel, attribute: .width, multiplier: 1.1, constant: 0)
                let containerBottom = NSLayoutConstraint(item: toastContainer, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -75)
                self.view.addConstraints([containerCenterX,containerTrailing, containerBottom])

                UIView.animate(withDuration: 0.5, delay: 0.0, options: .curveEaseIn, animations: {
                    toastContainer.alpha = 1.0
                }, completion: { _ in
                    UIView.animate(withDuration: 0.5, delay: 1.5, options: .curveEaseOut, animations: {
                        toastContainer.alpha = 0.0
                    }, completion: {_ in
                        toastContainer.removeFromSuperview()
                    })
                })
            }
    
    
    
    func scrollViewDidScroll(_ scrollView : UIScrollView){
        self.updateShader(scrollView : self.scrollView)
    }
    
    
    
    func scrollViewDidZoom(_ scrollView : UIScrollView){
        self.updateShader(scrollView : self.scrollView)
    }

    
    
    func viewForZooming(in scrollView : UIScrollView) -> UIView?{
        return self.contentView
    }
    
    
    
    
    /**
     * Ter verbergen statusbar
     */
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    
    
    
    
    /**
     * Methode die het bestaan van een SKScene na gaat
     */
    func checkOpBestaanVanScene(){
        if let nodePath = Bundle.main.path(forResource: "FractalScene", ofType: "sks"){
            print("FILE IS FOUND !!")
        }else{print("FILE IS NOT FOUND !!")}
    }
    
    
    
    
    
    
    /**
     * delegate methods
     */
    func changeZoom(val: CGFloat) {
        print(val)
        scrollView.zoomScale = val
        self.updateShader(scrollView: scrollView)
    }
    
    
    
    
    
    func changeOffsetX(val: CGFloat) {
        self.scrollView.contentOffset.x = val
           self.updateShader(scrollView: scrollView)
    }
    
    
    
    
    func changeOffsetY(val: CGFloat) {
     self.scrollView.contentOffset.y = val
        self.updateShader(scrollView: scrollView)
    }
    
    func changeIterations(val: CGFloat) {
        
    }

    
    
 
}
