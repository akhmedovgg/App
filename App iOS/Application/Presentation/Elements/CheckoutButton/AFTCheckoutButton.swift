//
//  AFTCheckoutButton.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 27/11/22.
//

import UIKit
import PinLayout
import Rswift

class AFTCheckoutButton: AFTScaleableControl {
    
    let checkoutLabel: UILabel = {
        let label = UILabel()
        label.text = "Checkout"
        label.font = R.font.poppinsSemiBold(size: 18)
        label.textColor = R.color.background()
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsSemiBold(size: 18)
        label.textColor = R.color.background()
        return label
    }()
    
    override func setupAppearance() {
        layer.cornerRadius = 4
        backgroundColor = R.color.primary()
    }
    
    override func setupViewHierarchy() {
        addSubview(checkoutLabel)
        addSubview(priceLabel)
    }
    
    override func setupLayout() {
        priceLabel.pin.sizeToFit().vCenter().right(12)
        checkoutLabel.pin.sizeToFit().vCenter().left(12 + 8).right(to: priceLabel.edge.left).marginRight(8)
    }
}
