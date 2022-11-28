//
//  AFTFetchMainScreenDataUseCase.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 28/11/22.
//

import Foundation


protocol AFTFetchMainScreenDataUseCase {
    func execute(completionHandler: @escaping (Result<AFTMainScreenData, AFTNetworkError>) -> Void)
}

class AFTFetchMainScreenDataUseCaseImpl: AFTFetchMainScreenDataUseCase {
    
    private let repository: AFTMainRepository
    
    init(repository: AFTMainRepository) {
        self.repository = repository
    }
    
    func execute(completionHandler: @escaping (Result<AFTMainScreenData, AFTNetworkError>) -> Void) {
        self.repository.fetchMainScreenData(completionHandler: completionHandler)
    }
}
