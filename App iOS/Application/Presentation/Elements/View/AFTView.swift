//
//  AFTView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit

class AFTView: UIView {
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
    }
    
    func setupLayout() {
    }
}
