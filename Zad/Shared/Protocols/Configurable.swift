//
//  Configurable.swift
//  Zad
//
//  Created by Sha on 9/8/17.
//  Copyright © 2017 A. All rights reserved.
//

import Foundation
import UIKit
protocol Configurable {
    associatedtype T
    var model: T? { get set }
    
    func configure(with model: T,
                   inController controller: UIViewController,
                   inTableView tableView: UITableView
    )
    
}


