//
//  MasterVCViewModel.swift
//  Zad
//
//  Created by Sha on 9/2/17.
//  Copyright © 2017 A. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class MasterVM{
    lazy var observedCategories = Observable.just(lectutesCategories)
    var lectutesCategories = [
        Category(title: "العقيدة الإسلامية"),
        Category(title: "الزهد والرقائق"),
        Category(title: "الآداب والأخلاق"),
        Category(title: "الفقه"),
        Category(title: "التربية والأسرة المسلمة"),
        Category(title: "قضايا إسلامية معاصرة"),
        Category(title: "موضوعات متنوعة"),
        Category(title:  "مناسبات دورية")
    ]
    
}
