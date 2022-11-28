//
//  AFTTagCollectionViewDelegate.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import Foundation

protocol AFTTagCollectionViewDelegate: AnyObject {
    func tagCollection(_ tagCollectionView: AFTTagCollectionView, didSelectItemAt index: Int)
    func tagCollectionDidTapSearch(_ tagCollectionView: AFTTagCollectionView)
}

extension AFTTagCollectionViewDelegate {
    func tagCollection(_ tagCollectionView: AFTTagCollectionView, didSelectItemAt index: Int) { }
    func tagCollectionDidTapSearch(_ tagCollectionView: AFTTagCollectionView) { }
}
