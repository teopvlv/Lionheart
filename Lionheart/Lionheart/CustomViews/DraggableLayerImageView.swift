//
//  DraggableLayerImageView.swift
//  Lionheart
//
//  Created by Teodor Pavlov on 3.08.21.
//

import UIKit

class DraggableLayerImageView: UIImageView {
    
    
    var dragStartPositionRelativeToCenter : CGPoint?
    
    override init(image: UIImage!) {
        super.init(image: image)
        
        self.isUserInteractionEnabled = true
        addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:))))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handlePan(recognizer: UIPanGestureRecognizer!) {
        if recognizer.state == UIGestureRecognizer.State.began {
            let locationInView = recognizer.location(in: superview)
            dragStartPositionRelativeToCenter = CGPoint(x: locationInView.x - center.x, y: locationInView.y - center.y)
            
            return
        }
        
        if recognizer.state == UIGestureRecognizer.State.ended {
            dragStartPositionRelativeToCenter = nil
            
            return
        }
        
        let locationInView = recognizer.location(in: superview)
        
        UIView.animate(withDuration: 0.1) {
            self.center = CGPoint(x: locationInView.x - self.dragStartPositionRelativeToCenter!.x,
                                  y: locationInView.y - self.dragStartPositionRelativeToCenter!.y)
        }
    }
    
    func enableZoom() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(startZooming(_:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(pinchGesture)
    }
    
    @objc
    private func startZooming(_ sender: UIPinchGestureRecognizer) {
        let scaleResult = sender.view?.transform.scaledBy(x: sender.scale, y: sender.scale)
        guard let scale = scaleResult, scale.a > 1, scale.d > 1 else { return }
        sender.view?.transform = scale
        sender.scale = 1
    }
}