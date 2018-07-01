//
//  DetailViewController.swift
//  Zad
//
//  Created by Sha on 8/31/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DetailVC: UIViewController, ViewModelProtocol {
    
    internal var viewModel = DetailVM()
    
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.estimatedRowHeight = tableView.rowHeight
            tableView.rowHeight = UITableViewAutomaticDimension
            
            tableView.register(
                UINib(nibName: "SubcategoryCell", bundle: nil),
                forCellReuseIdentifier: "Cell")
        }
    }
    
    private let disposeBag = DisposeBag()
    var detailItem: (title: String?, index: Int)? {
        willSet {
            title = newValue?.title
            viewModel.categoryId = newValue!.index + 1
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupCellConfiguration()
        setupCellTapHandling()
    }
    
    private var lectures: [Lecture]?
    
    private func setupCellConfiguration() {
        //Equivalent of cell for row at index path
        guard let lects = viewModel.lectures else { return }
        lectures = lects
        
        Observable.just(lects)
            .bind(to: tableView.rx.items(cellIdentifier: "Cell", cellType: SubcategoryCell.self)) {
                (row, model, cell) in
                cell.configure(with: model, inController: self, inTableView: self.tableView)
            }
            .disposed(by: disposeBag)
    }
    
    private func setupCellTapHandling() {
        //Equivalent of did select row at index path
        tableView
            .rx
            .modelSelected(Lecture.self)
            .subscribe(onNext: {
                lectue in
                
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.performSegueSafely(withIdentifier: .showContent)
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    // MARK: Segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = identifierForSegue(segue: segue)
        switch identifier {
        case .showContent:
            if let destination = segue.destination.contentViewController as? ContentVC{
                destination.lecture = lectures![(tableView.indexPathForSelectedRow?.row)!]
            }
            
        case .editContent:
            if let destination = segue.destination.contentViewController as? EditVC{
                destination.lecture = lectures![(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
    
}
