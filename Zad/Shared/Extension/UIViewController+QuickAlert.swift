//
//  UIViewController+QuickAlert.swift
//  Zad
//
//  Created by Sha on 9/2/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit

extension UIViewController {
    func showAlert(title: String? = nil, message: String? = nil, handler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel) { _ in
            handler?()
        })
        present(alert, animated: true, completion: nil)
    }
}
