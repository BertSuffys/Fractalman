//
//  GraphicalExtensions.swift
//  FractalMan
//
//  Created by Berto on 14/08/2021.
//

import Foundation
import SwiftUI

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
