//
//  AFTTagCollectionViewCell.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit

class AFTTagCollectionViewCell: AFTCollectionViewCell<AFTTagButton> {
    
    var isSelectedTag: Bool = false {
        didSet {
            rootView.appearance = isSelectedTag ? .primary : .grayOutlined
        }
    }
    
    override func setupAppearance() {
        super.setupAppearance()
        
        rootView.isUserInteractionEnabled = false
        rootView.layer.cornerRadius = 16
        rootView.clipsToBounds = true
        
        rootView.titleLabelEdgeInsets = UIEdgeInsets(top: 7, left: 12, bottom: 7, right: 12)
        rootView.appearance = .grayOutlined
        
    }
    
    override func setupViewHierarchy() {
        super.setupViewHierarchy()
    }
    
    override func setupLayout() {
        super.setupLayout()
    }
    
    func setTitle(_ title: String) {
        rootView.titleLabel.text = title
    }
}
