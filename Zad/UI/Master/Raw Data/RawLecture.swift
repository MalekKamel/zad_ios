//
//  RawLecture.swift
//  Zad
//
//  Created by Sha on 9/1/17.
//  Copyright © 2017 A. All rights reserved.
//

import Foundation

struct RawLecture: Codable {

    var id: Int
    var title: String
    var details: String
    var isFavorite: Bool
    var categoryId: Int
}
