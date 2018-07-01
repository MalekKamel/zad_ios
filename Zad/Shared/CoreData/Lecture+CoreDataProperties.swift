//
//  Lecture+CoreDataProperties.swift
//  Zad
//
//  Created by Sha on 9/2/17.
//  Copyright © 2017 A. All rights reserved.
//
//

import Foundation
import CoreData


extension Lecture{

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Lecture> {
        return NSFetchRequest<Lecture>(entityName: "Lecture")
    }

    @NSManaged public var categoryId: Int
    @NSManaged public var details: String?
    @NSManaged public var id: Int
    @NSManaged public var isFavorite: Bool
    @NSManaged public var title: String?

}
