//
//  AFTFetchError.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 28/11/22.
//

import Foundation

enum AFTNetworkError: Error {
    case unknownError
    case cannotDecode
}

extension AFTNetworkError {
    func message() -> String {
        switch self {
        case .unknownError: return "🤷‍♂️ Unknown error"
        case .cannotDecode: return "🚜 Cannot decode"
        }
    }
}
