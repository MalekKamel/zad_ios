//
//  InitViewMedlProtocol.swift
//  MyMVVM
//
//  Created by Sha on 8/31/17.
//  Copyright © 2017 A. All rights reserved.
//

import Foundation

protocol ViewModelProtocol {
    associatedtype T
    var viewModel: T {get}
}

