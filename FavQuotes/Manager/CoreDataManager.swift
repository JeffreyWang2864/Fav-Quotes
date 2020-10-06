//
//  CoreDataManager.swift
//  FavQuotes
//
//  Created by Jeffery Wang on 10/5/20.
//  Copyright © 2020 eagersoft.io. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager{
    public static let shared = CoreDataManager()
    enum Entity: String{
        case Quote = "QuoteEntity"
    }
    var context: NSManagedObjectContext
    var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FavQuotes")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    private init(){
        self.context = self.persistentContainer.viewContext
    }
    
    func saveContext() {
        let context = self.persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func saveObject(to entityName: Entity, with items: Array<Any>){
        let entity = NSEntityDescription.entity(forEntityName: entityName.rawValue, in: self.context)
        let manager = NSManagedObject(entity: entity!, insertInto: self.context)
        switch entityName{
        case .Quote:
            assert(items.count == 2)
            manager.setValue(items[0] as! String, forKey: "author")
            manager.setValue(items[1] as! String, forKey: "quote")
        }
        try! self.context.save()
    }
    
    func fetchObject(with entityName: Entity) -> Array<Any>{
        switch entityName{
        case .Quote:
            let items = try! self.context.fetch(QuoteEntity.fetchRequest())
            return items
        }
    }
    
    func deleteObject(of entityName: Entity, with item: Any){
        switch entityName{
        case .Quote:
            self.context.delete(item as! QuoteEntity)
            try! self.context.save()
        }
    }
    
}
