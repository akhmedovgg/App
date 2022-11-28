//
//  ExperimentalView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import PinLayout

class ExperimentalView: AFTView {
    
    let recentOrderView: AFTRecentOrderView = {
        let view = AFTRecentOrderView()
        return view
    }()
    
    override func setupAppearance() {
        backgroundColor = R.color.extraLowContrast()
    }
    
    override func setupViewHierarchy() {
        addSubview(recentOrderView)
    }
    
    override func setupLayout() {
        recentOrderView.pin.center().size(recentOrderView.sizeThatFits(CGSize(width: bounds.width - 128, height: bounds.height)))
    }
}
