//
//  AFTMenuPresenter.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 28/11/22.
//

import Foundation

protocol AFTMenuPresenterToView: AnyObject {
    func showLoader()
    func hideLoader()
    func displayErrorMessage(_ message: String, onClose: (() -> Void)?)
    func displayDeliveryDetails(_ deliveryDetails: AFTDeliveryDetails)
    func displayRecentOrders(_ recentOrders: [AFTRecentOrder])
    func displayCollectionViewData(_ data: [AFTMenuCollectionData])
    func displayCheckoutDetails(productCount: UInt, totalPrice: String?)
}

protocol AFTMenuViewToPresenter: AnyObject {
    func fetchScreenDetails()
    func setProductQuantity(for product: AFTMenuCollectionData.Product, quantity: UInt)
}
