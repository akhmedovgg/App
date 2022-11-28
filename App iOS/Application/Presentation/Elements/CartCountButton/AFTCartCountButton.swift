//
//  AFTCartCountButton.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 27/11/22.
//

import UIKit
import PinLayout
import Rswift

class AFTCartCountButton: AFTScaleableControl {
    
    let imageView: UIImageView = {
        let imageView = UIImageView(image: R.image.icons.custom.cart()!.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = R.color.primary()
        return imageView
    }()
    
    let countLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsSemiBold(size: 13)
        label.textAlignment = .center
        label.textColor = R.color.background()
        return label
    }()
    
    override func setupAppearance() {
        
    }
    
    override func setupViewHierarchy() {
        addSubview(imageView)
        addSubview(countLabel)
    }
    
    override func setupLayout() {
        imageView.pin.all(8)
        countLabel.pin.sizeToFit().center().marginBottom(2).marginLeft(1)
    }
}
