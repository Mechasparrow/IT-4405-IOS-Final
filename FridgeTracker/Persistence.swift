//
//  Persistence.swift
//  FridgeTracker
//
//  Created by Michael Navazhylau on 4/24/22.
//

import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    private static func seedContext(viewContext: NSManagedObjectContext, local: Bool){
        let fridgeLocations: [String] = ["Pantry", "Freezer", "Refridgerator"]
        
        let savedLocations: [FoodLocation] = []
        
        let pantryLocation = FoodLocation(context: viewContext)
        pantryLocation.name = "Pantry"
        
        let freezerLocation = FoodLocation(context: viewContext)
        freezerLocation.name = "Freezer"
        
        let refridgeratorLocation = FoodLocation(context: viewContext)
        refridgeratorLocation.name = "Refridgerator"
                
        if (local == true){
            let newGrocery = GroceryItem(context: viewContext)
            newGrocery.name = "Carrots"
            newGrocery.groceryLocation = refridgeratorLocation
        }
        
        do {
            UserDefaults.standard.set(true, forKey: "data_seeded")
            UserDefaults.standard.synchronize()
            try viewContext.save()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    static var preview: PersistenceController = {
        var result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        PersistenceController.seedContext(viewContext: viewContext, local: true)
        return result
    }()

    func clearLocations(viewContext: NSManagedObjectContext){
        let fetchRequest: NSFetchRequest<FoodLocation>
        fetchRequest = FoodLocation.fetchRequest()
        
        fetchRequest.includesPropertyValues = false
        
        do {
            let objects = try viewContext.fetch(fetchRequest)
            
            for object in objects {
                viewContext.delete(object)
            }
            
            try viewContext.save()
        }catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nsError = error as NSError
            fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
        }
    }
    
    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "FridgeTracker")
                
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        
        
        //Seed Data
        if (UserDefaults.standard.bool(forKey: "data_seeded") != true){
            PersistenceController.seedContext(viewContext: container.viewContext, local: false)
        }
    }
}
