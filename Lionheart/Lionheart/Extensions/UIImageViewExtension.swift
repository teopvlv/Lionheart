//
//  UIImageViewExtension.swift
//  Lionheart
//
//  Created by Teodor Pavlov on 4.08.21.
//

import Foundation
import UIKit

extension UIImageView {
    var contentClippingRect: CGRect {
        guard let image = image else { return bounds }
        guard contentMode == .scaleAspectFit else { return bounds }
        guard image.size.width > 0 && image.size.height > 0 else { return bounds }

        let scale = bounds.width / image.size.width
        
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)

        let x = (bounds.width - size.width) / 2.0
        let y = (bounds.height - size.height) / 2.0

        return CGRect(x: x, y: y, width: size.width, height: size.height)
    }
    
    var transformScale: CGFloat {
        return sqrt(CGFloat(self.transform.a * self.transform.a + self.transform.c * self.transform.c))
    }
}
