//
//  AFTTagCollectionViewDataSource.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import Foundation

protocol AFTTagCollectionViewDataSource: AnyObject {
    func tagCollectionViewNumberOfItems(_ tagCollectionView: AFTTagCollectionView) -> Int
    func tagCollection(_ tagCollectionView: AFTTagCollectionView, titleForItemAt index: Int) -> String
}
