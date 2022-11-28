//
//  AFTPrimaryNavigationBar.swift
//  App iOS
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import Rswift

class AFTPrimaryNavigationBar: UINavigationBar {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    func commonInit() {
        let titleTextAttibutes: [NSAttributedString.Key: Any] = [
            .font: R.font.poppinsMedium(size: 16)!,
        ]
        
        let largeTitleTextAttibutes: [NSAttributedString.Key: Any] = [
            .font: R.font.poppinsMedium(size: 26)!,
        ]
        
        let backIndicatorImage: UIImage = R.image.icons.custom.left()!
        
        self.backgroundColor = R.color.background()
        self.titleTextAttributes = titleTextAttibutes
        self.largeTitleTextAttributes = largeTitleTextAttibutes
        self.tintColor = R.color.highContrast()
        self.backIndicatorImage = backIndicatorImage
        self.backIndicatorTransitionMaskImage = backIndicatorImage
        self.shadowImage = UIImage()
        
        if #available(iOS 13, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = R.color.background()
            appearance.titleTextAttributes = titleTextAttibutes
            appearance.largeTitleTextAttributes = largeTitleTextAttibutes
            appearance.setBackIndicatorImage(backIndicatorImage, transitionMaskImage: backIndicatorImage)
            appearance.shadowImage = UIImage()
            appearance.shadowColor = .clear
            
            scrollEdgeAppearance = appearance
            compactAppearance = appearance
            standardAppearance = appearance
        }
    }
}
