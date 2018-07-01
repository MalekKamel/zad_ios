//
//  FavoritesViewController.swift
//  Zad
//
//  Created by Sha on 9/4/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class FavoritesVC: UIViewController, ViewModelProtocol{

    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.estimatedRowHeight = tableView.rowHeight
            tableView.rowHeight = UITableViewAutomaticDimension
            
            tableView.register(
                UINib(nibName: "SubcategoryCell", bundle: nil),
                forCellReuseIdentifier: "Cell")
        }
    }
    let viewModel = FavoritesVM()
    let disposeBag = DisposeBag()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupCellConfiguration()
        setupCellTapHandling()
    }
    
    var favortieLectures: [Lecture]?
    
    private func setupCellConfiguration() {
        //Equivalent of cell for row at index path
        guard let favorties = viewModel.favoriteLectures else { return }
        favortieLectures = favorties
        
        tableView.dataSource = nil
        
        Observable.just(favorties)
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
                lecture in
                
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.performSegueSafely(withIdentifier: .showContent)
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
            .disposed(by: disposeBag)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = identifierForSegue(segue: segue)
        switch identifier {
        case .showContent:
            if let destination = segue.destination.contentViewController as? ContentVC{
                destination.lecture = favortieLectures![(tableView.indexPathForSelectedRow?.row)!]
            }
            
        case .editContent:
            if let destination = segue.destination.contentViewController as? EditVC{
                destination.lecture = favortieLectures![(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }

}
