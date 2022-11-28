//
//  AFTTagButton.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import PinLayout

class AFTTagButton: AFTScaleableControl {
    
    var appearance: AFTTagButtonAppearance = .primary {
        didSet {
            setupAppearance()
        }
    }
    
    let titleLabel: UILabel = {
        return UILabel()
    }()
    
    var titleLabelEdgeInsets: UIEdgeInsets = .zero {
        didSet {
            setupLayout()
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let labelSize = titleLabel.sizeThatFits(size)
        let size = CGSize(width: labelSize.width + titleLabelEdgeInsets.left + titleLabelEdgeInsets.right,
                      height: labelSize.height + titleLabelEdgeInsets.top + titleLabelEdgeInsets.bottom)
        return size
    }
    
    override func setupAppearance() {
        layer.borderColor = appearance.borderColor
        layer.borderWidth = appearance.borderWidth
        
        backgroundColor = appearance.backgroundColor
        
        titleLabel.textColor = appearance.textColor
        titleLabel.font = appearance.titleFont
    }
    
    override func setupViewHierarchy() {
        addSubview(titleLabel)
    }
    
    override func setupLayout() {
        titleLabel.pin
            .top(titleLabelEdgeInsets.top)
            .left(titleLabelEdgeInsets.left)
            .right(titleLabelEdgeInsets.right)
            .bottom(titleLabelEdgeInsets.bottom)
    }
}
