//
//  ScreenshotExtension.swift
//  FractalMan
//
//  Created by Berto on 13/08/2021.
//

import Foundation
import UIKit
import SpriteKit

extension UIView {
    
    func createImg () -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds : bounds)
        return renderer.image {
            rendererContext in layer.render(in: rendererContext.cgContext)
        }
    }
}





extension SKScene {
    
    
    
    
    
    
    /*
     * Converteert een SKScene naar UIImage
     */
    func toImage(ignoreScreenScale: Bool = false) -> UIImage? {
        guard let device = MTLCreateSystemDefaultDevice(),
              let commandQueue = device.makeCommandQueue(),
              let commandBuffer = commandQueue.makeCommandBuffer() else { return nil }

        let scale = ignoreScreenScale ? 1 : UIScreen.main.scale
        let size = self.size.applying(CGAffineTransform(scaleX: scale, y: scale))
        let renderer = SKRenderer(device: device)
        let renderPassDescriptor = MTLRenderPassDescriptor()

        var r = CGFloat.zero, g = CGFloat.zero, b = CGFloat.zero, a = CGFloat.zero
        backgroundColor.getRed(&r, green: &g, blue: &b, alpha: &a)

        let textureDescriptor = MTLTextureDescriptor()
        textureDescriptor.usage = [.renderTarget, .shaderRead]
        textureDescriptor.width = Int(size.width)
        textureDescriptor.height = Int(size.height)
        let texture = device.makeTexture(descriptor: textureDescriptor)

        renderPassDescriptor.colorAttachments[0].loadAction = .clear
        renderPassDescriptor.colorAttachments[0].texture = texture
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColor(
            red: Double(r),
            green: Double(g),
            blue: Double(b),
            alpha:Double(a)
        )

        renderer.scene = self
        renderer.render(withViewport: CGRect(origin: .zero, size: size), commandBuffer: commandBuffer, renderPassDescriptor: renderPassDescriptor)
        commandBuffer.commit()

        let image = CIImage(mtlTexture: texture!, options: nil)!
        let transformed = image.transformed(by: CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -image.extent.size.height))
        return UIImage(ciImage: transformed)
    }
}
