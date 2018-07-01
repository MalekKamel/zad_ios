//
//  FavoritesVCViewModel.swift
//  Zad
//
//  Created by Sha on 9/4/17.
//  Copyright © 2017 A. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

class FavoritesVM{
    
    var favoriteLectures: [Lecture]?{
       let data = Lecture.fetchFavortieLectures()
        return data
    }
    
   
    
}
