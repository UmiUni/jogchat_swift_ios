//
//  ApplyRootViewController.swift
//  ReferHelper
//
//  Created by XMZ on 08/11/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit
import Material

class ReferRootViewController: UIViewController {
    fileprivate var postButton: IconButton!
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        preparePostButton()
        prepareNavigationItem()
    }

}

extension ReferRootViewController {
    fileprivate func preparePostButton() {
        postButton = IconButton(title: "+", titleColor: .white)
    }
    
    fileprivate func prepareNavigationItem() {
        navigationItem.titleLabel.text = "Refer"
        navigationItem.titleLabel.textColor = .white
        
        navigationItem.rightViews = [postButton]
    }
}
