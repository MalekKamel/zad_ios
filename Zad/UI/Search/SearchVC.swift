//
//  SearchViewController.swift
//  Zad
//
//  Created by Sha on 9/6/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift

class SearchVC: UIViewController, ViewModelProtocol {
    
    let viewModel = SearchVM()
    private let disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!{
        didSet{
            tableView.estimatedRowHeight = tableView.rowHeight
            tableView.rowHeight = UITableViewAutomaticDimension
            
            tableView.register(
                UINib(nibName: "SubcategoryCell", bundle: nil),
                forCellReuseIdentifier: "Cell")
        }
    }
    
    @IBOutlet weak var searchTexField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearch()
        setupCellTapHandling()
    }
    private var searchResults: Observable<[Lecture]> = Observable.just([])
    private func setupSearch(){
        searchResults = searchTexField
            .rx
            .text
            .orEmpty
            .debounce(0.3, scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Lecture]> in
                if query.isEmpty {
                    return .just([])
                }
                if let lectures = self.viewModel.searchDatabae(query){
                    return lectures
                }
                return .just([])
            }
            .observeOn(MainScheduler.instance)
        
        searchResults
            .bind(to: tableView.rx.items(cellIdentifier: "Cell")) {
                (row, model, cell: SubcategoryCell) in
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let identifier = identifierForSegue(segue: segue)
        switch identifier {
        case .showContent:
            if let destination = segue.destination.contentViewController as? ContentVC{
                destination.lecture = viewModel.items?[(tableView.indexPathForSelectedRow?.row)!]
            
            }
            
        case .editContent:
            if let destination = segue.destination.contentViewController as? EditVC{
                destination.lecture = viewModel.items?[(tableView.indexPathForSelectedRow?.row)!]
            }
        }
    }
   
    
}
