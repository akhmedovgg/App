//
//  AFTRecentOrdersDataSource.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import Foundation

protocol AFTRecentOrdersDataSource: AnyObject {
    func recentOrdersNumberOfItems(_ recentOrders: AFTRecentOrdersView) -> Int
    func recentOrders(_ recentOrders: AFTRecentOrdersView, recentOrderForItemAt index: Int) -> AFTRecentOrder
}
