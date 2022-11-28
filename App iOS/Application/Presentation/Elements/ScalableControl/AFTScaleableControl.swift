//
//  AFTScaleableControl.swift
//  Hemis iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit

class AFTScaleableControl: AFTControl {
    
    override var isHighlighted: Bool {
        didSet {
            guard isHighlighted != oldValue else {
                return
            }
            
            isHighlighted ? scaleIn() : scaleOut()
        }
    }
    
    func scaleIn() {
        UIView.animate(withDuration: 0.072, delay: 0, options: .curveEaseOut) { [weak self] in
            self?.layer.transform = CATransform3DMakeScale(0.94, 0.94, 1);
        }
    }
    
    func scaleOut() {
        UIView.animate(withDuration: 0.072, delay: 0, options: .curveEaseIn) { [weak self] in
            self?.layer.transform = CATransform3DMakeScale(1, 1, 1);
        }
    }
}
