//
//  AFTRecentOrdersView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 27/11/22.
//

import UIKit
import PinLayout
import Rswift

class AFTRecentOrdersView: AFTView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recent collection orders"
        label.textColor = R.color.highContrast()
        label.font = R.font.poppinsRegular(size: 12)
        return label
    }()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsVerticalScrollIndicator = false
        view.showsHorizontalScrollIndicator = false
        view.backgroundColor = .clear
        view.register(AFTRecentOrderCollectionViewCell.self, forCellWithReuseIdentifier: CollectionViewCells.orderCell)
        view.contentInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return view
    }()
    
    weak var delegate: AFTRecentOrdersViewDelegate?
    weak var dataSource: AFTRecentOrdersDataSource?
    
    struct CollectionViewCells {
        static let orderCell = "orderCell"
    }
    
    override func commonInit() {
        super.commonInit()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: size.width, height: 160)
    }
    
    override func setupAppearance() {
        backgroundColor = R.color.extraLowContrast()
    }
    
    override func setupViewHierarchy() {
        addSubview(titleLabel)
        addSubview(collectionView)
    }
    
    override func setupLayout() {
        titleLabel.pin.horizontally(16).top(16).sizeToFit(.width)
        collectionView.pin.below(of: titleLabel).horizontally().bottom(16).marginTop(8)
    }
}

extension AFTRecentOrdersView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.recentOrders(self, didSelectItemAt: indexPath.row)
    }
}

extension AFTRecentOrdersView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard (dataSource?.recentOrdersNumberOfItems(self) ?? 0) > 1 else {
            return CGSize(width: bounds.width - 32, height: collectionView.bounds.height)
        }
        
        return CGSize(width: 280, height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension AFTRecentOrdersView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataSource?.recentOrdersNumberOfItems(self) ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCells.orderCell, for: indexPath) as! AFTRecentOrderCollectionViewCell
        
        if let recentOrderData = dataSource?.recentOrders(self, recentOrderForItemAt: indexPath.row) {
            cell.rootView.applyWith(title: recentOrderData.title.joined(separator: ", "), price: "€\(recentOrderData.price)")
        }
        
        return cell
    }
}
