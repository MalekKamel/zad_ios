//
//  SearchVCViewModel.swift
//  Zad
//
//  Created by Sha on 9/8/17.
//  Copyright © 2017 A. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
class SearchVM{
    
    var items: [Lecture]?
    func searchDatabae(_ query: String) -> Observable<[Lecture]>?
    {
        if let items = Lecture.search(query: query){
            self.items = items
            return Observable.just(items)
        }
        return nil
    }
}
