//
//  AFTProductView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 27/11/22.
//

import UIKit
import PinLayout
import Rswift
import Kingfisher

class AFTProductView: AFTView {
    
    private let borderLeftView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.primary()
        view.isHidden = true
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsMedium(size: 16)
        label.textColor = R.color.highContrast()
        label.numberOfLines = 0
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsRegular(size: 13)
        label.textColor = R.color.bodyText()
        label.numberOfLines = 0
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.backgroundColor = R.color.extraLowContrast()
        return imageView
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsMedium(size: 16)
        label.textColor = R.color.highContrast()
        label.numberOfLines = 1
        return label
    }()
    
    private let priceChevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.icons.custom.right()
        imageView.contentMode = .scaleAspectFill
        imageView.isHidden = true
        return imageView
    }()
    
    let subtractButton: AFTIconButton = {
        let button = AFTIconButton(imageViewEdgeInsets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        button.imageView.image = R.image.icons.custom.minus()
        button.layer.cornerRadius = 18
        button.backgroundColor = R.color.extraLowContrast()
        button.isHidden = true
        return button
    }()
    
    private let counterLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsRegular(size: 13)
        label.textColor = R.color.highContrast()
        label.numberOfLines = 1
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    let addButton: AFTIconButton = {
        let button = AFTIconButton(imageViewEdgeInsets: UIEdgeInsets(top: 6, left: 6, bottom: 6, right: 6))
        button.imageView.image = R.image.icons.custom.plus()?.withRenderingMode(.alwaysTemplate)
        button.imageView.tintColor = R.color.background()
        button.layer.cornerRadius = 18
        button.backgroundColor = R.color.primary()
        return button
    }()
    
    private let borderBottomView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.lowContrast()
        return view
    }()
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 8)
        let frameSize = CGSize(width: size.width - insets.left - insets.right, height: size.height - insets.top - insets.bottom)
        
        let imageSize = CGSize(width: 112, height: 112)
        let titleSize = titleLabel.sizeThatFits(CGSize(width: frameSize.width - imageSize.width - 12, height: frameSize.height))
        
        let descriptionSize = descriptionLabel.sizeThatFits(CGSize(width: frameSize.width - imageSize.width - 12, height: frameSize.height))
        
        let countButtonSize = CGSize(width: 36, height: 36)
        let countButtonRowSize = CGSize(width: frameSize.width, height: countButtonSize.height)
        
        let contentHeight = CGFloat.maximum(imageSize.height, titleSize.height + 8 + descriptionSize.height)
        
        let width = size.width
        let height = contentHeight + 12 + countButtonRowSize.height + insets.top + insets.bottom
        
        return CGSize(width: width, height: height)
    }
    
    override func setupAppearance() {
        backgroundColor = R.color.background()
    }
    
    override func setupViewHierarchy() {
        addSubview(borderLeftView)
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(descriptionLabel)
        addSubview(priceLabel)
        addSubview(priceChevronImageView)
        addSubview(subtractButton)
        addSubview(counterLabel)
        addSubview(addButton)
        addSubview(borderBottomView)
    }
    
    override func setupLayout() {
        borderLeftView.pin.vertically().left().width(3)
        imageView.pin.top(8).right(8).size(CGSize(width: 112, height: 112))
        titleLabel.pin.top(16).left(16).right(to: imageView.edge.left).marginRight(12).sizeToFit(.width)
        descriptionLabel.pin.below(of: titleLabel).left(16).width(of: titleLabel).sizeToFit(.width).marginTop(8)
        priceLabel.pin.bottom(16).left(16).height(22).sizeToFit(.height)
        priceChevronImageView.pin.after(of: priceLabel).size(CGSize(width: 16, height: 16)).vCenter(to: priceLabel.edge.vCenter)
        addButton.pin.bottom(to: priceLabel.edge.bottom).right(16).size(CGSize(width: 36, height: 36))
        counterLabel.pin.before(of: addButton).bottom(to: priceLabel.edge.bottom).marginRight(10).height(36).sizeToFit(.height)
        subtractButton.pin.before(of: counterLabel).bottom(to: counterLabel.edge.bottom).marginRight(10).size(CGSize(width: 36, height: 36))
        borderBottomView.pin.horizontally().bottom().height(1)
    }
    
    // MARK: Public API
    
    var count: UInt = 0 {
        didSet {
            let isHidden = count < 1
            
            borderLeftView.isHidden = isHidden
            
            subtractButton.isHidden = isHidden
            
            counterLabel.text = String(count)
            counterLabel.isHidden = isHidden
        }
    }
    
    func setTitle(_ text: String?) {
        self.titleLabel.text = text
    }
    
    func setDescription(_ text: String?) {
        self.descriptionLabel.text = text
    }
    
    func setPrice(_ text: String?) {
        self.priceLabel.text = text
        self.priceChevronImageView.isHidden = text == nil || (text?.isEmpty ?? true)
    }
    
    func setImage(_ data: Data) {
        self.imageView.image = UIImage(data: data)
    }
    
    func setImage(_ url: URL?) {
        self.imageView.kf.setImage(with: url)
    }
    
    func applyWith(title: String?, description: String?, price: String?, image: URL?, count: UInt) {
        self.setTitle(title)
        self.setDescription(description)
        self.setPrice(price)
        self.setImage(image)
        self.count = count
    }
}
