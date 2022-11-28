//
//  AFTCartSummaryView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 27/11/22.
//

import UIKit
import PinLayout
import Rswift

class AFTCartSummaryView: AFTView {
    
    let borderTopView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.lowContrast()
        return view
    }()
    
    private let cartButton: AFTCartCountButton = {
        let button = AFTCartCountButton()
        return button
    }()
    
    private let checkoutButton: AFTCheckoutButton = {
        let control = AFTCheckoutButton()
        return control
    }()
    
    override func setupAppearance() {
        backgroundColor = R.color.background()
    }
    
    override func setupViewHierarchy() {
        addSubview(borderTopView)
        addSubview(cartButton)
        addSubview(checkoutButton)
    }
    
    override func setupLayout() {
        borderTopView.pin.top().horizontally().height(1)
        cartButton.pin.top(8).left(8).size(CGSize(width: 48, height: 48))
        checkoutButton.pin.after(of: cartButton).marginLeft(12).right(8).top(8).height(48)
    }
    
    func applyWith(quantity: UInt, price: String?) {
        self.cartButton.countLabel.text = quantity < 9 ? String(quantity) : "9+"
        self.cartButton.setupLayout()
        
        self.checkoutButton.priceLabel.text = price
        self.checkoutButton.setupLayout()
        
    }
}
