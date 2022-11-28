//
//  AFTProductSectionHeaderView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 28/11/22.
//

import UIKit
import PinLayout
import Rswift

class AFTProductSectionHeaderView: AFTView {
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.highContrast()
        label.font = R.font.poppinsMedium(size: 22)
        return label
    }()
    
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.textColor = R.color.bodyText()
        label.font = R.font.poppinsRegular(size: 12)
        return label
    }()
    
    let arrowImageView: UIImageView = {
        let view = UIImageView()
        view.image = R.image.icons.custom.up()
        return view
    }()
    
    private let borderBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.lowContrast()
        return view
    }()
    
    private(set) var isCollapsed = false
    
    override func setupAppearance() {
        
    }
    
    override func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(arrowImageView)
        addSubview(borderBottomView)
    }
    
    override func setupLayout() {
        descriptionLabel.pin.bottom(20).horizontally(16).sizeToFit(.width)
        titleLabel.pin.horizontally(16).sizeToFit(.width).above(of: descriptionLabel)
        arrowImageView.pin.size(CGSize(width: 24, height: 24)).right(16).vCenter()
        borderBottomView.pin.horizontally().bottom().height(1)
    }
    
    func setCollapsed(collapsed: Bool, animated: Bool = false) {
        guard collapsed != self.isCollapsed else { return }
        
        self.isCollapsed.toggle()
        
        let degree: CGFloat = isCollapsed ? CGFloat.pi : -0.999 * .pi * 2
        
        guard animated else {
            arrowImageView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1)
            return
        }
        
        UIView.animate(withDuration: 0.256, delay: 0) { [weak self] in
            self?.arrowImageView.layer.transform = CATransform3DMakeRotation(degree, 0, 0, 1)
        }
    }
    
    func applyWith(title: String?, description: String?) {
        self.titleLabel.text = title
        self.descriptionLabel.text = description
    }
}
