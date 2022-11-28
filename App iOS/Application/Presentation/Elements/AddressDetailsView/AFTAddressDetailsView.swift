//
//  AFTAddressDetailsView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 27/11/22.
//

import UIKit
import PinLayout
import Rswift

class AFTAddressDetailsView: AFTView {
    
    private let cartImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = R.image.icons.custom.order()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Collect at"
        label.font = R.font.poppinsMedium(size: 16)
        label.textColor = R.color.highContrast()
        return label
    }()
    
    let addressLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsRegular(size: 13)
        label.textColor = R.color.bodyText()
        return label
    }()
    
    let minOrderLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsRegular(size: 13)
        label.textColor = R.color.bodyText()
        return label
    }()
    
    let workTimeLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsRegular(size: 13)
        label.textColor = R.color.bodyText()
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.font = R.font.poppinsRegular(size: 13)
        label.textColor = R.color.bodyText()
        return label
    }()
    
    override func setupAppearance() {
        
    }
    
    override func setupViewHierarchy() {
        addSubview(cartImageView)
        addSubview(titleLabel)
        addSubview(addressLabel)
        addSubview(minOrderLabel)
        addSubview(workTimeLabel)
        addSubview(distanceLabel)
    }
    
    override func setupLayout() {
        cartImageView.pin.top(8).left(16).width(24).height(24)
        titleLabel.pin.after(of: cartImageView).marginLeft(8).top(to: cartImageView.edge.top).right(16).sizeToFit(.width)
        addressLabel.pin.below(of: titleLabel).marginTop(8).horizontally(16).sizeToFit(.width)
        minOrderLabel.pin.sizeToFit().below(of: addressLabel).left(to: addressLabel.edge.left)
        workTimeLabel.pin.sizeToFit().after(of: minOrderLabel).top(to: minOrderLabel.edge.top).marginLeft(4)
        distanceLabel.pin.sizeToFit().after(of: workTimeLabel).top(to: workTimeLabel.edge.top).marginLeft(4)
    }
    
    func applyWith(deliveryDetails: AFTDeliveryDetails) {
        self.addressLabel.text = deliveryDetails.address
        self.minOrderLabel.text = "Min order €\(deliveryDetails.minOrderPrice ?? 0)"
        self.workTimeLabel.text = "• Open till \(deliveryDetails.openTill ?? "-")"
        self.distanceLabel.text = "• \(deliveryDetails.distance ?? 0) km"
    }
}
