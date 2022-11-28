//
//  ExperimentalViewController.swift
//  App
//
//  Created by Sherzod Akhmedov on 26/11/22.
//

import UIKit
import Rswift

class ExperimentalViewController: AFTViewController<ExperimentalView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rootView.recentOrderView.applyWith(title: "Mexican pizza + free coke, Cheesy Garlic Bread, 2x Peach Smoothie", price: "€16.00")
    }
}
