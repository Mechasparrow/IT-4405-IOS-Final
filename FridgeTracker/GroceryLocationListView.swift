//
//  GroceryLocationListView.swift
//  FridgeTracker
//
//  Created by Michael Navazhylau on 4/24/22.
//

import SwiftUI
import CoreData

struct GroceryLocationListView: View {
    var filteringLocation: FoodLocation?
    var groceries: [GroceryItem]
        
    func getLocationString() -> String {
        if let location = filteringLocation {
            return location.name!
        }else {
            return "Undefined location"
        }
    }
    
    init (locationToView: FoodLocation?, viewContext: NSManagedObjectContext){
        
        self.filteringLocation = locationToView
        
        self.groceries = []
        
        do {
            let fetchRequest = GroceryItem.fetchRequest()
            
            let fetchedGroceries = try viewContext.fetch(fetchRequest)
            
            self.groceries = fetchedGroceries.filter {$0.groceryLocation == self.filteringLocation}
        }catch {
            
        }
    }
    
    var body: some View {
        List {
            ForEach (self.groceries) { grocery in
                Text("\(grocery.name!)")
            }
        }
        .navigationTitle("Viewing \(getLocationString())")
    }
}

struct GroceryLocationListView_Previews: PreviewProvider {
    static var previews: some View {
        GroceryLocationListView(locationToView: nil, viewContext: PersistenceController.preview.container.viewContext)
    }
}
