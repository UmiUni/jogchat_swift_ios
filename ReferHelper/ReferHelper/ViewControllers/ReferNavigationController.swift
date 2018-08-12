//
//  ApplyNavigationController.swift
//  ReferHelper
//
//  Created by XMZ on 08/11/2018.
//  Copyright © 2018 UmiUmi. All rights reserved.
//

import UIKit
import Material

class ReferNavigationController: NavigationController {
    open override func prepare() {
        super.prepare()
        guard let v = navigationBar as? NavigationBar else {
            return
        }
        v.depthPreset = .none
        v.dividerColor = .black
        v.backgroundColor = .black
    }
}
