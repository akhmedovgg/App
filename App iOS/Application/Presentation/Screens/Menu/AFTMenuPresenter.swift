//
//  AFTMenuPresenter.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 28/11/22.
//

import Foundation

class AFTMenuPresenter: AFTMenuViewToPresenter {
    
    weak var view: AFTMenuPresenterToView?
    var fetchMainScreenDataUseCase: AFTFetchMainScreenDataUseCase?
    
    private var lastFetchedMainScreenData: AFTMainScreenData?
    
    func fetchScreenDetails() {
        view?.showLoader()
        
        fetchMainScreenDataUseCase?.execute(completionHandler: { [weak self] result in
            guard let weakSelf = self, let view = weakSelf.view else { return }
            
            switch result {
            case let .success(mainScreenData):
                weakSelf.lastFetchedMainScreenData = mainScreenData
                view.displayDeliveryDetails(mainScreenData.deliveryDetails)
                view.displayRecentOrders(mainScreenData.recentOrders)
                
                var data: [AFTMenuCollectionData] = []
                
                mainScreenData.menu.forEach { section in
                    data.append(AFTMenuCollectionData(id: UUID(), type: .sectionHeader, sectionHeader: .init(id: UUID(), title: section.name ?? "", description: section.description)))
                    
                    section.items.forEach { product in
                        let product = AFTMenuCollectionData.Product(
                            id: product.id,
                            name: product.name ?? String(),
                            description: product.description ?? String(),
                            image: product.image,
                            price: product.price ?? 0,
                            quantity: 0)
                        data.append(AFTMenuCollectionData(id: UUID(), type: .product, product: product))
                    }
                }
                
                view.displayCollectionViewData(data)
                
            case let .failure(error): weakSelf.view?.displayErrorMessage(error.message(), onClose: nil)
            }
            
            weakSelf.view?.hideLoader()
        })
    }
    
    private var cart: [AFTMenuCollectionData.Product: UInt] = [:]
    private var totalPrice: Decimal {
        var price: Decimal = 0
        self.cart.forEach { element in
            price += (Decimal(element.key.quantity) * element.key.price)
        }
        return price
    }
    
    func setProductQuantity(for product: AFTMenuCollectionData.Product, quantity: UInt) {
        
        self.cart[product] = quantity
        
        if quantity == 0 {
            self.cart.removeValue(forKey: product)
        }
        
        view?.displayCheckoutDetails(productCount: UInt(cart.count), totalPrice: "€\(totalPrice)")
    }
}
