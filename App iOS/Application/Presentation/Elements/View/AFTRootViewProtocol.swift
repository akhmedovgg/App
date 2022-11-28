//
//  AFTView.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit

protocol AFTRootViewProtocol {
    associatedtype RootView
    
    var rootView: RootView { get }
}

extension AFTRootViewProtocol where Self: UIViewController {
    var rootView: RootView {
        guard let view = view as? RootView else {
            fatalError(
                """
                Unable to cast '\(String(describing: view))' to the type '\(RootView.self)', \
                check 'loadView()' method implementation.
                """
            )
        }
        return view
    }
}
