//
//  Entry+CoreDataProperties.swift
//  Travelogue
//
//  Created by Nathaniel Banderas on 7/27/18.
//  Copyright © 2018 Nathaniel Banderas. All rights reserved.
//
//

import Foundation
import CoreData


extension Entry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Entry> {
        return NSFetchRequest<Entry>(entityName: "Entry")
    }

    @NSManaged public var name: String?
    @NSManaged public var rawDate: NSDate?
    @NSManaged public var desc: String?
    @NSManaged public var image: NSData?
    @NSManaged public var trip: Trip?

}
