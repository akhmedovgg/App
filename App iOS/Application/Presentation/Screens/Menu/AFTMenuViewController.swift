//
//  AFTMenuViewController.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit

class AFTMenuViewController: AFTViewController<AFTMenuView>, AFTMenuPresenterToView {
    
    // MARK: AFTMenuPresenterToView
    
    func showLoader() {
        rootView.collectionView.isHidden = true
        rootView.cartSummaryView.isHidden = true
        rootView.activityIndicatorView.isHidden = false
        rootView.activityIndicatorView.startAnimating()
    }
    
    func hideLoader() {
        rootView.collectionView.isHidden = false
        rootView.cartSummaryView.isHidden = true
        rootView.activityIndicatorView.isHidden = true
        rootView.activityIndicatorView.stopAnimating()
    }
    
    func displayErrorMessage(_ message: String, onClose: (() -> Void)?) {
        let controller = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Close", style: .cancel) { _ in
            onClose?()
        }
        controller.addAction(cancelAction)
        present(controller, animated: true)
    }
    
    func displayDeliveryDetails(_ deliveryDetails: AFTDeliveryDetails) {
        self.deliveryDetails = deliveryDetails
        self.rootView.collectionView.reloadSections(IndexSet(integer: RootView.CollectionViewSections.addressDetails))
    }
    
    func displayRecentOrders(_ recentOrders: [AFTRecentOrder]) {
        self.recentOrders = recentOrders
        self.rootView.collectionView.reloadSections(IndexSet(integer: RootView.CollectionViewSections.recentOrders))
    }
    
    func displayCollectionViewData(_ data: [AFTMenuCollectionData]) {
        self.actualData = data
        self.rootView.collectionView.reloadSections(IndexSet(integer: RootView.CollectionViewSections.products))
    }
    
    func displayCheckoutDetails(productCount: UInt, totalPrice: String?) {
        guard productCount > 0 else {
            rootView.cartSummaryView.isHidden = true
            rootView.setupLayout()
            return
        }
        
        rootView.cartSummaryView.isHidden = false
        rootView.setupLayout()
        rootView.cartSummaryView.applyWith(quantity: productCount, price: totalPrice)
    }
    
    // MARK: Lifecycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        presenter?.fetchScreenDetails()
    }
    
    override func configureNavigationItem() {
        super.configureNavigationItem()
        
        let rightBarButton = UIBarButtonItem(image: R.image.icons.custom.textAlignLeft(), style: .plain, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightBarButton
        title = "Pizza Cafe Stillorgan"
        
        rootView.collectionView.delegate = self
        rootView.collectionView.dataSource = self
    }
    
    // MARK: Other
    
    var presenter: AFTMenuViewToPresenter?
    private var deliveryDetails: AFTDeliveryDetails?
    private var recentOrders: [AFTRecentOrder] = []
    
    private var actualData: [AFTMenuCollectionData] = [] {
        didSet {
            self.displayedData = actualData
            self.sectionHeaders = actualData.filter({ $0.type == .sectionHeader }).compactMap({ $0.sectionHeader })
        }
    }
    private var displayedData: [AFTMenuCollectionData] = []
    private var sectionHeaders: [AFTMenuCollectionData.SectionHeader] = []
    private var collapsedSections = Set<AFTMenuCollectionData>()
    
    private func toggle(sectionAt index: Int) {
        let section = self.displayedData[index]
        
        if collapsedSections.contains(section) {
            expand(sectionAt: index)
            collapsedSections.remove(section)
        } else {
            collapse(sectionAt: index)
            collapsedSections.insert(section)
        }
    }
    
    private func collapse(sectionAt index: Int) {
        guard self.displayedData.count >= index + 1 else { return }
        
        let startIndex = index + 1
        let endIndex = displayedData[startIndex...].firstIndex(where: { $0.type == .sectionHeader }) ?? displayedData.endIndex
        let range = startIndex..<endIndex
        
        displayedData.removeSubrange(range)

        let indexPaths: [IndexPath] = Array(range).map({ IndexPath(row: $0, section: RootView.CollectionViewSections.products) })
        rootView.collectionView.deleteItems(at: indexPaths)
        
        guard let cell = rootView.collectionView.cellForItem(at: IndexPath(row: index, section: RootView.CollectionViewSections.products)) as? AFTMenuProductSectionHeaderCell else { return }
        cell.rootView.setCollapsed(collapsed: true, animated: true)
    }
    
    private func expand(sectionAt index: Int) {
        guard let actualStartIndex = actualData.firstIndex(of: displayedData[index]), self.actualData.count >= actualStartIndex + 1 else { return }
        
        let actualEndIndex = actualData[(actualStartIndex + 1)...].firstIndex(where: { $0.type == .sectionHeader }) ?? actualData.endIndex
        let range = (actualStartIndex + 1)..<actualEndIndex
        displayedData.insert(contentsOf: actualData[range], at: index + 1)

        let indexPaths: [IndexPath] = Array((index + 1)..<(index + 1 + range.count)).map({ IndexPath(row: $0, section: RootView.CollectionViewSections.products) })
        rootView.collectionView.insertItems(at: indexPaths)
        
        guard let cell = rootView.collectionView.cellForItem(at: IndexPath(row: index, section: RootView.CollectionViewSections.products)) as? AFTMenuProductSectionHeaderCell else { return }
        cell.rootView.setCollapsed(collapsed: false, animated: true)
    }
    
    @objc private func didTapSubtractProduct(_ sender: AFTIconButton) {
        guard let displayedItemIndex = sender.superview?.tag, let product = displayedData[displayedItemIndex].product else { return }
        product.quantity -= 1
        setProductCount(forCellAt: displayedItemIndex, count: product.quantity)
        presenter?.setProductQuantity(for: product, quantity: product.quantity)
    }
    
    @objc private func didTapAddProduct(_ sender: AFTIconButton) {
        guard let displayedItemIndex = sender.superview?.tag, let product = displayedData[displayedItemIndex].product else { return }
        product.quantity += 1
        setProductCount(forCellAt: displayedItemIndex, count: product.quantity)
        presenter?.setProductQuantity(for: product, quantity: product.quantity)
    }
    
    private func setProductCount(forCellAt index: Int, count: UInt) {
        guard let cell = rootView.collectionView.cellForItem(at: IndexPath(row: index, section: RootView.CollectionViewSections.products)) as? AFTMenuProductCollecitonViewCell else { return }
        cell.rootView.count = count
    }
    
    private func calculateTagCollectionShadow(from offset: CGPoint) {
        let maximumOffset: CGFloat = 84 + 160
        let minimumOffset: CGFloat = maximumOffset - 5
        let currentOffset = CGFloat.minimum(CGFloat.maximum(minimumOffset, offset.y + abs(rootView.pin.safeArea.top)), maximumOffset)
        let fractionComplete: CGFloat = (currentOffset - maximumOffset - (minimumOffset - maximumOffset)) / (maximumOffset - minimumOffset)
        rootView.tagCollectionReusableView?.shadowAnimator?.fractionComplete = fractionComplete
    }
}

extension AFTMenuViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard displayedData[indexPath.row].type == .sectionHeader else { return }
        toggle(sectionAt: indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let sectionHeader = displayedData[indexPath.row].sectionHeader, let visibleSectionHeaderIndex = sectionHeaders.firstIndex(of: sectionHeader) else { return }
        rootView.tagCollectionReusableView?.rootView.setSelectedItem(at: visibleSectionHeaderIndex, scrollToItem: true, animatedScrollToItem: true)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        calculateTagCollectionShadow(from: scrollView.contentOffset)
    }
    
}

extension AFTMenuViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        switch section {
        case RootView.CollectionViewSections.addressDetails: return CGSize(width: rootView.bounds.width, height: 84)
        case RootView.CollectionViewSections.recentOrders:
            guard !recentOrders.isEmpty else {
                return CGSize(width: rootView.bounds.width, height: 0)
            }
            return CGSize(width: rootView.bounds.width, height: 160)
        case RootView.CollectionViewSections.products: return CGSize(width: rootView.bounds.width, height: 56)
        default: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch indexPath.section {
        case RootView.CollectionViewSections.products:
            let data = displayedData[indexPath.row]
            
            if data.type == .product {
                let product = data.product
                
                let cell = AFTMenuProductCollecitonViewCell()
                cell.rootView.applyWith(title: product?.name, description: product?.description, price: product?.formattedPrice, image: product?.image, count: 0)
                return cell.sizeThatFits(rootView.bounds.size)
            } else {
                return CGSize(width: rootView.bounds.width, height: 80)
            }
        default:
            return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        switch section {
        case RootView.CollectionViewSections.products: return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
        default: return .zero
        }
    }
}

extension AFTMenuViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case RootView.CollectionViewSections.products: return displayedData.count
        default: return .zero
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.section {
        case RootView.CollectionViewSections.products:
            
            let data = displayedData[indexPath.row]
            
            if data.type == .product {
                guard let product = data.product else { fallthrough }
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RootView.CollectionViewCells.product, for: indexPath) as! AFTMenuProductCollecitonViewCell
                cell.rootView.applyWith(title: product.name, description: product.description, price: product.formattedPrice, image: product.image, count: product.quantity)
                cell.rootView.subtractButton.addTarget(self, action: #selector(didTapSubtractProduct(_:)), for: .touchUpInside)
                cell.rootView.addButton.addTarget(self, action: #selector(didTapAddProduct(_:)), for: .touchUpInside)
                cell.rootView.tag = indexPath.row
                cell.rootView.setupLayout()
                return cell
            } else {
                let section = data.sectionHeader
                let isCollapsed = collapsedSections.contains(data)
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RootView.CollectionViewCells.productHeader, for: indexPath) as! AFTMenuProductSectionHeaderCell
                cell.rootView.applyWith(title: section?.title, description: section?.description)
                cell.rootView.setCollapsed(collapsed: isCollapsed, animated: false)
                cell.rootView.setupLayout()
                return cell
            }
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch indexPath.section {
        case RootView.CollectionViewSections.addressDetails:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RootView.CollectionViewSectionHeaders.addressDetailsHeader, for: indexPath) as! AFTMenuAdressDetailsReusableView
            
            if let deliveryDetails = deliveryDetails {
                reusableView.rootView.applyWith(deliveryDetails: deliveryDetails)
            }
            
            return reusableView
        case RootView.CollectionViewSections.recentOrders:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RootView.CollectionViewSectionHeaders.recentOrdersHeader, for: indexPath) as! AFTMenuRecentOrdersReusableView
            reusableView.rootView.delegate = self
            reusableView.rootView.dataSource = self
            return reusableView
        case RootView.CollectionViewSections.products:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: RootView.CollectionViewSectionHeaders.productsHeader, for: indexPath) as! AFTMenuTagCollectionReusableView
            reusableView.rootView.delegate = self
            reusableView.rootView.dataSource = self
            return reusableView
        default:
            return UICollectionReusableView()
        }
    }
}

extension AFTMenuViewController: AFTTagCollectionViewDelegate {
    func tagCollection(_ tagCollectionView: AFTTagCollectionView, didSelectItemAt index: Int) {
        print(index)
    }
}

extension AFTMenuViewController: AFTTagCollectionViewDataSource {
    func tagCollectionViewNumberOfItems(_ tagCollectionView: AFTTagCollectionView) -> Int {
        return self.sectionHeaders.count
    }
    
    func tagCollection(_ tagCollectionView: AFTTagCollectionView, titleForItemAt index: Int) -> String {
        return self.sectionHeaders[index].title
    }
}

extension AFTMenuViewController: AFTRecentOrdersViewDelegate {
    
}

extension AFTMenuViewController: AFTRecentOrdersDataSource {
    func recentOrdersNumberOfItems(_ recentOrders: AFTRecentOrdersView) -> Int {
        return self.recentOrders.count
    }
    
    func recentOrders(_ recentOrders: AFTRecentOrdersView, recentOrderForItemAt index: Int) -> AFTRecentOrder {
        return self.recentOrders[index]
    }
}
