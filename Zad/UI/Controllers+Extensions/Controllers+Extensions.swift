//
//  Controllers+Extensions.swift
//  Zad
//
//  Created by Sha on 9/2/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit
extension MasterVC: SegueHandler {
    enum SegueIdentifier: String {
        case showDetail
    }
}

extension DetailVC: SegueHandler {
    enum SegueIdentifier: String {
        case showContent
        case editContent
    }
}

extension FavoritesVC: SegueHandler {
    enum SegueIdentifier: String {
        case showContent
        case editContent
    }
}

extension SearchVC: SegueHandler {
    enum SegueIdentifier: String {
        case showContent
        case editContent
    }
}

extension UIViewController{
    
    
    
}

