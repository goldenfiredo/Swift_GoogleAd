//
//  CoreDataDAO.swift
//
//
//  Created by Limin Du on 1/22/15.
//  Copyright (c) 2015 . All rights reserved.
//

import Foundation
import CoreData

class CoreDataDAO {
    var context:CoreDataContext!
    
    init() {
        context = CoreDataContext()
    }
    
    func getEntities()->[NSManagedObject] {
        var entity = [NSManagedObject]()
        
        let managedContext = context.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Person")
        
        do {
            try entity = managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        } catch {
            
        }
        
        return entity
    }
    
    func queryEntityByName(name:String)->NSManagedObject?{
        var entity = [NSManagedObject]()
        
        let managedContext = context.managedObjectContext!
        
        let fetchRequest = NSFetchRequest(entityName:"Person")
        let predicate = NSPredicate(format: "%K = %@", "name", name)
        fetchRequest.predicate = predicate
        
        do {
            try entity = managedContext.executeFetchRequest(fetchRequest) as! [NSManagedObject]
        } catch {
            return nil
        }
        
        if entity.count == 0 {
            return nil
        }
        
        return entity[0]
    }
    
    func saveEntity(name:String)->NSManagedObject? {
        if let _ = queryEntityByName(name) {
            return nil
        }
        
        let managedContext = context.managedObjectContext!
        
        let entity =  NSEntityDescription.entityForName("Person", inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:managedContext)
        
        person.setValue(name, forKey: "name")
        
        var error: NSError?
        do {
            try managedContext.save()
        } catch let error1 as NSError {
            error = error1
            print("Could not save \(error), \(error?.userInfo)")
            return nil
        }
        
        return person
    }
    
    func deleteEntity(name:String)->Bool {
        let managedContext = context.managedObjectContext!
        
        let entityToDelete = queryEntityByName(name)
        if let entity = entityToDelete {
            managedContext.deleteObject(entity)
            
            do {
                try managedContext.save()
                return true
            } catch {
                return false
            }
        }
        
        return false
    }
    
    func saveContext() {
        context.saveContext()
    }
}