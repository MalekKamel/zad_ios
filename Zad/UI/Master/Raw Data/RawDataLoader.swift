//
//  RawDataLoader.swift
//  Zad
//
//  Created by Sha on 9/1/17.
//  Copyright © 2017 A. All rights reserved.
//

import UIKit
import CoreData

class RawDataLoader {
    static var managedObjectContext: NSManagedObjectContext? = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
    
    class func load() {
        if let _ = Lecture.fetchLecture(){
            // We found data in database, no need to save again.
            return
        }
        
        let items = self.items
        
        self.managedObjectContext?.perform{
            for item in items{
                _ = Lecture.saveItem(item)
            }
        }
    }
    
    static var items: [RawLecture]{
        if let file = Bundle.main.url(forResource: "lectures", withExtension: "json") {
            let data = try? Data(contentsOf: file)
            if let jsonData = data{
                let decoder = JSONDecoder()
                let lectures = try! decoder.decode(RawLectures.self, from: jsonData)
                return lectures.lectures
            }
        }
        return []
    }
    
}
