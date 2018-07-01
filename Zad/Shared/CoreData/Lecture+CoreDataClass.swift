//
//  Lecture+CoreDataClass.swift
//  Zad
//
//  Created by Sha on 9/1/17.
//  Copyright © 2017 A. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Lecture)
public class Lecture: NSManagedObject {
    static var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    static var Name = String(describing: Lecture.self)
    
    class func saveItem(_ info: RawLecture) -> Lecture?{
        
        if let lecture = NSEntityDescription.insertNewObject(forEntityName: Name, into: managedObjectContext!) as? Lecture{
            lecture.title = info.title
            lecture.id = info.id
            lecture.categoryId = info.categoryId
            lecture.isFavorite = info.isFavorite
            lecture.details = info.details
            
            // Must save explicitly to persist data
            try? managedObjectContext?.save()
            
            return lecture
        }
        return nil
    }
    
    class func fetchLectures(byCategortyId id : Int) -> [Lecture]{
        var lectures: [Lecture]?
        
        managedObjectContext?.performAndWait {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Name)
            
            request.predicate = NSPredicate(format: "categoryId = \(id)")
            
            lectures = (try? managedObjectContext?.fetch(request)) as? [Lecture]
        }
        if let lects = lectures{
            return lects
        }
        return []
    }
    
    class func fetchLecture() -> Lecture?{
        return fetchLectures(byCategortyId: 1).first
    }
    
    class func fetchFavortieLectures() -> [Lecture]?{
        var lectures: [Lecture]?
        
        managedObjectContext?.performAndWait {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Name)
            
            request.predicate = NSPredicate(format: "isFavorite = \(1)")
            
            lectures = (try? managedObjectContext?.fetch(request)) as? [Lecture]
        }
       return lectures
    }
    
   class func search(query: String) -> [Lecture]?{
        var lectures: [Lecture]?
        
        managedObjectContext?.performAndWait {
            let request = NSFetchRequest<NSFetchRequestResult>(entityName: Name)
            
            request.predicate = NSPredicate(format: "title contains[c] %@", query)
            
            lectures = (try? managedObjectContext?.fetch(request)) as? [Lecture]
        }
        return lectures
    }
}
