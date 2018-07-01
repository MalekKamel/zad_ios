//
//  DetailVCViewModel.swift
//  Zad
//
//  Created by Sha on 9/2/17.
//  Copyright © 2017 A. All rights reserved.
//

import Foundation
import RxSwift
class DetailVM{
    lazy var observedLectures = Observable.just(lectures)
    
    var categoryId: Int = 0
    
    var lectures: [Lecture]?{
        guard categoryId != 0 else{ fatalError("categoryId not set") }
        return Lecture.fetchLectures(byCategortyId: (categoryId))
    }
    
}
