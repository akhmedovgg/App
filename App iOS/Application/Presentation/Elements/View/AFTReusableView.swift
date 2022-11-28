//
//  AFTReusableView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import PinLayout

class AFTReusableView<RootView: UIView>: UICollectionReusableView {
    
    let rootView = RootView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupLayout()
    }
    
    func commonInit() {
        setupAppearance()
        setupViewHierarchy()
    }
    
    func setupAppearance() {
    }
    
    func setupViewHierarchy() {
        addSubview(rootView)
    }
    
    func setupLayout() {
        rootView.pin.all()
    }
}
