//
//  AFTMenuView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import PinLayout
import Rswift

class AFTMenuView: AFTView {
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionHeadersPinToVisibleBounds = true
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.register(AFTMenuAdressDetailsReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSectionHeaders.addressDetailsHeader)
        collectionView.register(AFTMenuRecentOrdersReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSectionHeaders.recentOrdersHeader)
        collectionView.register(AFTMenuTagCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: CollectionViewSectionHeaders.productsHeader)
        collectionView.register(AFTMenuProductSectionHeaderCell.self, forCellWithReuseIdentifier: CollectionViewCells.productHeader)
        collectionView.register(AFTMenuProductCollecitonViewCell.self, forCellWithReuseIdentifier: CollectionViewCells.product)
        return collectionView
    }()
    
    var tagCollectionReusableView: AFTMenuTagCollectionReusableView? {
        return collectionView.supplementaryView(forElementKind: UICollectionView.elementKindSectionHeader, at: IndexPath(row: 0, section: CollectionViewSections.products)) as? AFTMenuTagCollectionReusableView
    }
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView()
        return view
    }()
    
    struct CollectionViewSections {
        static let addressDetails = 0
        static let recentOrders = 1
        static let products = 2
    }
    
    struct CollectionViewSectionHeaders {
        static let addressDetailsHeader = "section.addressdetails.header"
        static let recentOrdersHeader = "section.recentorders.header"
        static let productsHeader = "section.products.header"
    }
    
    struct CollectionViewCells {
        static let productHeader = "cell.productheader"
        static let product = "cell.product"
    }
    
    let cartSummaryView: AFTCartSummaryView = {
        let view = AFTCartSummaryView()
        view.isHidden = true
        return view
    }()
    
    override func setupAppearance() {
        backgroundColor = R.color.background()
    }
    
    override func setupViewHierarchy() {
        addSubview(collectionView)
        addSubview(cartSummaryView)
        addSubview(activityIndicatorView)
    }
    
    override func setupLayout() {
        cartSummaryView.pin.horizontally().height(64 + pin.safeArea.bottom).bottom()
        
        if cartSummaryView.isHidden {
            collectionView.pin.all()
        } else {
            collectionView.pin.top().left().right().bottom(to: cartSummaryView.edge.top)
        }
        
        activityIndicatorView.pin.center()
    }
}
