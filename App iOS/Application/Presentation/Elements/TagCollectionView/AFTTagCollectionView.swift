//
//  AFTTagCollectionView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import PinLayout
import Rswift

fileprivate let cellIdentifier = "cell"

class AFTTagCollectionView: AFTView {
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.register(AFTTagCollectionViewCell.self, forCellWithReuseIdentifier: cellIdentifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return collectionView
    }()
    
    private let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = R.color.lowContrast()
        return view
    }()
    
    private let searchButton: AFTIconButton = {
        let button = AFTIconButton(imageViewEdgeInsets: UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16))
        button.imageView.image = R.image.icons.custom.search()
        return button
    }()
    
    // MARK: Layout system
    
    override func commonInit() {
        super.commonInit()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        searchButton.addTarget(self, action: #selector(didTapSearch(_:)), for: .touchUpInside)
    }
    
    override func setupAppearance() {
        backgroundColor = R.color.background()
    }
    
    override func setupViewHierarchy() {
        addSubview(collectionView)
        addSubview(dividerView)
        addSubview(searchButton)
    }
    
    override func setupLayout() {
        collectionView.pin.top().left().bottom().right(55)
        dividerView.pin.after(of: collectionView).vertically(8).width(1)
        searchButton.pin.after(of: dividerView).left(to: dividerView.edge.right).right().vertically()
    }
    
    // MARK: Other
    
    weak var delegate: AFTTagCollectionViewDelegate?
    weak var dataSource: AFTTagCollectionViewDataSource?
    
    private(set) var selectedItemIndex: Int = 0
    
    func reloadData() {
        let sections = IndexSet(integer: 0)
        collectionView.reloadSections(sections)
    }
    
    func setSelectedItem(at index: Int, scrollToItem: Bool = false, animatedScrollToItem: Bool = false) {
        guard self.selectedItemIndex != index else { return }
        
        self.unhightlightItem(at: self.selectedItemIndex)
        self.hightlightItem(at: index)
        self.selectedItemIndex = index
        
        if scrollToItem {
            collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .centeredHorizontally, animated: animatedScrollToItem)
        }
    }
    
    private func unhightlightItem(at index: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? AFTTagCollectionViewCell else { return }
        cell.isSelectedTag = false
    }
    
    private func hightlightItem(at index: Int) {
        guard let cell = collectionView.cellForItem(at: IndexPath(row: index, section: 0)) as? AFTTagCollectionViewCell else { return }
        cell.isSelectedTag = true
    }
    
    @objc private func didTapSearch(_ sender: AFTIconButton) {
        delegate?.tagCollectionDidTapSearch(self)
    }
}

extension AFTTagCollectionView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let index = indexPath.row
        setSelectedItem(at: index)
        delegate?.tagCollection(self, didSelectItemAt: index)
    }
}

extension AFTTagCollectionView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let title = dataSource?.tagCollection(self, titleForItemAt: indexPath.row) else { return .zero }
        
        let cell = AFTTagCollectionViewCell()
        cell.setTitle(title)
        cell.isSelectedTag = indexPath.row == selectedItemIndex
        
        let sizeThatFits = cell.rootView.sizeThatFits(bounds.size)
        return sizeThatFits
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

extension AFTTagCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let numberOfItems = dataSource?.tagCollectionViewNumberOfItems(self) ?? 0
        return numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let title = dataSource?.tagCollection(self, titleForItemAt: indexPath.row) else { return UICollectionViewCell() }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! AFTTagCollectionViewCell
        cell.setTitle(title)
        cell.isSelectedTag = indexPath.row == selectedItemIndex
        
        return cell
    }
}
