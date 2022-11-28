//
//  AFTMainRepository.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 28/11/22.
//

import Foundation

protocol AFTMainRepository {
    func fetchMainScreenData(completionHandler: @escaping (Result<AFTMainScreenData, AFTNetworkError>) -> Void)
}
