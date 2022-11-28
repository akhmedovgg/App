//
//  AFTIconButton.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import PinLayout

class AFTIconButton: AFTScaleableControl {
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let imageViewEdgeInsets: UIEdgeInsets
    
    init(frame: CGRect = .zero, imageViewEdgeInsets: UIEdgeInsets) {
        self.imageViewEdgeInsets = imageViewEdgeInsets
        
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setupAppearance() {
        
    }
    
    override func setupViewHierarchy() {
        addSubview(imageView)
    }
    
    override func setupLayout() {
        imageView.pin
            .top(imageViewEdgeInsets.top)
            .left(imageViewEdgeInsets.left)
            .right(imageViewEdgeInsets.right)
            .bottom(imageViewEdgeInsets.bottom)
    }
}
