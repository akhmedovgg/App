//
//  AFTRecentOrderView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 27/11/22.
//

import UIKit
import PinLayout
import Rswift

class AFTRecentOrderView: AFTView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsRegular(size: 13)
        label.textColor = R.color.highContrast()
        label.numberOfLines = 2
        return label
    }()
    
    let reorderButton: AFTTagButton = {
        let button = AFTTagButton()
        button.appearance = .outlined
        button.titleLabel.text = "Reorder"
        button.titleLabelEdgeInsets = UIEdgeInsets(top: 8, left: 12, bottom: 8, right: 12)
        button.layer.cornerRadius = 4
        return button
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsRegular(size: 12)
        label.textColor = R.color.bodyText()
        return label
    }()
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let frameSize = CGSize(width: size.width - 12 - 12, height: bounds.height - 12 - 12)
        let titleSize = titleLabel.sizeThatFits(frameSize)
        let reorderButtonSize = reorderButton.sizeThatFits(frameSize)
        return CGSize(width: size.width, height: titleSize.height + 12 + reorderButtonSize.height + 12 + 12)
    }
    
    override func setupAppearance() {
        layer.cornerRadius = 8
        backgroundColor = R.color.background()
    }
    
    override func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(reorderButton)
        addSubview(priceLabel)
    }
    
    override func setupLayout() {
        titleLabel.pin.top(12).horizontally(12).sizeToFit(.width)
        reorderButton.pin.bottom(12).right(12).size(reorderButton.sizeThatFits(bounds.size))
        priceLabel.pin.sizeToFit().bottom(to: reorderButton.edge.bottom).left(12)
    }
    
    func applyWith(title: String, price: String) {
        self.titleLabel.text = title
        self.priceLabel.text = price
    }
}
