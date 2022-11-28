//
//  AFTDefaultMainRepository.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 28/11/22.
//

import Foundation

class AFTDefaultMainRepository: AFTMainRepository {
    
    let session: URLSession
    
    init(session: URLSession) {
        self.session = session
    }
    
    func fetchMainScreenData(completionHandler: @escaping (Result<AFTMainScreenData, AFTNetworkError>) -> Void) {
        guard let url = URL(string: "https://akhmedovgg.com/public/test_task.json") else { return }
        let request = URLRequest(url: url)
        let task = session.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data else {
                    completionHandler(.failure(AFTNetworkError.unknownError))
                    return
                }
                
                guard let dto = try? JSONDecoder().decode(AFTMainScreenResponseDTO.self, from: data) else {
                    completionHandler(.failure(AFTNetworkError.cannotDecode))
                    return
                }
                        
                let mainScreenData = dto.toDomain()
                completionHandler(.success(mainScreenData))
            }
        }
        task.resume()
    }
}
