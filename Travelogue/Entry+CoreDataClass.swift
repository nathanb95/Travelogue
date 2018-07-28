//
//  Entry+CoreDataClass.swift
//  Travelogue
//
//  Created by Nathaniel Banderas on 7/27/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//
//

import UIKit
import CoreData

@objc(Entry)
public class Entry: NSManagedObject {
    var date: Date? {
        get {
            return rawDate as Date?
        } set {
            rawDate = newValue as NSDate?
        }
    }
    
    convenience init?(name: String?, desc: String?, rawDate: Date?) {
        let appDelegate = UIApplication.shared.delegate as? AppDelegate
        
        guard let context = appDelegate?.persistentContainer.viewContext else {
            return nil
        }
        
        self.init(entity: Entry.entity(), insertInto: context)
        
        self.name = name
        self.desc = desc
        self.date = rawDate
    }
}
