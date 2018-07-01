//
//  MasterViewController.swift
//  Zad
//
//  Created by Sha on 8/31/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MasterVC: UIViewController, ViewModelProtocol {
    
    @IBOutlet weak var tableView: UITableView!
    var viewModel = MasterVM()
    private let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        tableView.estimatedRowHeight = tableView.rowHeight
        tableView.rowHeight = UITableViewAutomaticDimension
      
        setupCellConfiguration()
        setupCellTapHandling()
    }
    
    // MARK: - Segues
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = identifierForSegue(segue: segue)
        switch identifier{
        case .showDetail:
            if let indexPath = tableView.indexPathForSelectedRow {
                let category = viewModel.lectutesCategories[indexPath.row]
                let controller = segue.destination as! DetailVC
                controller.detailItem = (category.title, indexPath.row)
                controller.navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        RawDataLoader.load()
    }
    
    private func setupCellConfiguration() {
        //Equivalent of cell for row at index path
        viewModel.observedCategories
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: UITableViewCell.self)) {
                (row, category, cell) in
                 cell.textLabel!.text = category.title
            }
            .disposed(by: disposeBag)
    }
    
    private func setupCellTapHandling() {
        //Equivalent of did select row at index path
        tableView
            .rx
            .modelSelected(Category.self)
            .subscribe(onNext: {
                category in
                
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
 
    
    
}




