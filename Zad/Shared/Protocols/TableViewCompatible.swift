//
//  TableViewCompatible.swift
//  Zad
//
//  Created by Sha on 9/8/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit

protocol TableViewCompatible {

    var reuseIdentifier: String { get }
    
    func cellForTableView(
        tableView: UITableView,
        atIndexPath indexPath: IndexPath
        ) -> UITableViewCell
    
    
    
}
