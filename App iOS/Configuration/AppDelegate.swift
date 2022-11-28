//
//  AppDelegate.swift
//  App
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let controller: UIViewController = {
            let navigationController = UINavigationController(navigationBarClass: AFTPrimaryNavigationBar.self, toolbarClass: nil)
            
            let repository = AFTDefaultMainRepository(session: .init(configuration: .ephemeral))
            let useCase = AFTFetchMainScreenDataUseCaseImpl(repository: repository)
            
            let presenter = AFTMenuPresenter()
            presenter.fetchMainScreenDataUseCase = useCase
            
            let controller = AFTMenuViewController()
            controller.presenter = presenter
            
            presenter.view = controller
            
            navigationController.setViewControllers([
//                AFTMenuViewController(),
                controller,
            ], animated: false)
            
            navigationController.navigationBar.prefersLargeTitles = true
            
            return navigationController
        }()
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.rootViewController = controller
        window.makeKeyAndVisible()
        self.window = window
        
        return true
    }
}

