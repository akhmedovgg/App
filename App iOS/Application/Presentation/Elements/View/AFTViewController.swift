//
//  AFTViewController.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import Rswift

class AFTViewController<RootView: UIView>: UIViewController, AFTRootViewProtocol {
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureNavigationItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureNavigationItem()
    }
    
    override func loadView() {
        view = RootView(frame: UIScreen.main.bounds)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func configureNavigationItem() {
        navigationItem.backButtonTitle = String()
    }
}
