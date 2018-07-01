//
//  SubcategoryTableViewModel.swift
//  Zad
//
//  Created by Sha on 9/8/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit
class SubcategoryVM: TableViewCompatible {
    var reuseIdentifier: String {
       return "Cell"
    }
    
    func cellForTableView(tableView: UITableView, atIndexPath indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
