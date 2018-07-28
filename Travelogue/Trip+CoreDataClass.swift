//
//  Trip+CoreDataClass.swift
//  Travelogue
//
//  Created by Nathaniel Banderas on 7/27/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Trip)
public class Trip: NSManagedObject {
    var trips: [Trip]? {
        return self.rawEntries?.array as? [Trip]
    }
    
    convenience init?(title: String) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Trip.entity(), insertInto: context)
        
        self.title = title
    }
}
