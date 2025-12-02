//
//  CoreDataManager.swift
//  PetresTestTask
//
//  Created by DimaTru on 02.12.2025.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() {}
    
    lazy var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "PetresTestTask")
        container.loadPersistentStores { _, error in
            if let error {
                fatalError(error.localizedDescription)
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        container.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            try? context.save()
        }
    }
}
