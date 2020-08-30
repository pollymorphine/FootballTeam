//
//  CoreDataManager.swift
//  FootballTeam
//
//  Created by Polina on 14.08.2020.
//  Copyright © 2020 SergeevaPolina. All rights reserved.
//

import CoreData

final class CoreDataManager {
    
    private let modelName: String
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: modelName)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func getContext() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func save(context: NSManagedObjectContext) {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func createObject<T: NSManagedObject> (from entity: T.Type) -> T {
        let context = getContext()
        let object = NSEntityDescription.insertNewObject(forEntityName: String(describing: entity), into: context) as! T
        return object
    }
    
    func delete(object: NSManagedObject) {
        let context = getContext()
        context.delete(object)
        save(context: context)
    }
    

    func fetchData<T: NSManagedObject>(for entity: T.Type, predicate: NSCompoundPredicate? = nil) -> [T] {
        let context = getContext()
        let request: NSFetchRequest<T>
        var fetchedResult = [T]()
       
       request = entity.fetchRequest() as! NSFetchRequest<T>
   
        let priceSortDescriptor = NSSortDescriptor(key: "fullName", ascending: true, selector: #selector(NSString.localizedStandardCompare(_:)))
        
        request.predicate = predicate
        request.sortDescriptors = [priceSortDescriptor]
        
        do {
            fetchedResult = try context.fetch(request)
        } catch {
            debugPrint("Could not fetch: \(error.localizedDescription)")
        }
        return fetchedResult
    }
}
