//
//  UIViewController+ContentVc.swift
//  Zad
//
//  Created by Sha on 9/2/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit
extension UIViewController {
    var contentViewController: UIViewController{
        if let navCon  = self as? UINavigationController{
            return navCon.visibleViewController ?? self
        }
        else{
            return self
        }
    }
}
