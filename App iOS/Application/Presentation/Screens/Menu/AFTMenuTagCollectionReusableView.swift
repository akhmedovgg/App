//
//  AFTMenuTagCollectionReusableView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 27/11/22.
//

import UIKit
import PinLayout
import Rswift

class AFTMenuTagCollectionReusableView: AFTReusableView<AFTTagCollectionView> {
    
    private(set) var shadowAnimator: UIViewPropertyAnimator?
    
    private let borderBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.lowContrast()
        return view
    }()
    
    override func commonInit() {
        super.commonInit()
        
        self.shadowAnimator = UIViewPropertyAnimator(duration: 1, curve: .linear) { [weak self] in
            self?.layer.shadowOpacity = 1
            self?.borderBottomView.alpha = 0
        }
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return rootView.sizeThatFits(size)
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        
        layer.shadowColor = UIColor.black.withAlphaComponent(0.15).cgColor
        layer.shadowRadius = 8
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0
    }
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
        
        addSubview(borderBottomView)
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        borderBottomView.pin.horizontally().bottom().height(1)
    }
}
