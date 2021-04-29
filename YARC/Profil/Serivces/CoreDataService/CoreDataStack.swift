//
//  CoreDataStack.swift
//  YARC
//
//  Created by Michael Kroneder on 20/04/2021.
//

import CoreData

struct CoreDataStack {
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Yarc")

        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        return container
    }()
}
