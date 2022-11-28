//
//  AFTRecentOrdersViewDelegate.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import Foundation

protocol AFTRecentOrdersViewDelegate: AnyObject {
    func recentOrders(_ recentOrders: AFTRecentOrdersView, didSelectItemAt index: Int)
}

extension AFTTagCollectionViewDelegate {
    func recentOrders(_ recentOrders: AFTRecentOrdersView, didSelectItemAt index: Int) { }
}
