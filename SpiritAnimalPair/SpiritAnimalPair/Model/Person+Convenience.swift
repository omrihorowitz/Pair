//
//  Object+Convenience.swift
//  SpiritAnimalPair
//
//  Created by Omri Horowitz on 2/13/21.
//

import CoreData

extension Person {
    
    @discardableResult convenience init(name: String, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
    }
}
