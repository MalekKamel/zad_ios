//
//  CustomAlertController.swift
//  Zad
//
//  Created by Sha on 9/9/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit
class CustomAlertController: UIAlertController {
    
    var didDismiss: ((UIAlertController) -> Void)?
    
    deinit {
        didDismiss?(self)
    }
}
