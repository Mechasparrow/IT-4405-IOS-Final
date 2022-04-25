//
//  LocationListCellView.swift
//  FridgeTracker
//
//  Created by Michael Navazhylau on 4/24/22.
//

import SwiftUI
import CoreData

struct LocationListCellView: View {
    private var location: FoodLocation
    
    private var viewContext: NSManagedObjectContext
    
    init(foodLocation: FoodLocation, context: NSManagedObjectContext) {
        viewContext = context
        location = foodLocation
    }
    
    func getGroceryCountString() -> String {
        return "0"
    }
    
    var body: some View {
        HStack {
            Text("\(location.name!)")
                .font(.system(size: 20))
            Spacer()
            ZStack{
                Circle()
                    .frame(width: 40.0, height: 40.0)
                    .foregroundColor(.blue)
                Text("\(getGroceryCountString())")
                    .font(.system(size: 16))
                    .foregroundColor(.white)
                    .fontWeight(.bold)
            }
        }
    }
}

struct LocationListCellView_Previews: PreviewProvider {
    static func getDummyLocation() -> FoodLocation {
        var newFoodLocation = FoodLocation(context: PersistenceController.preview.container.viewContext)
        
        newFoodLocation.name = "Refridgerator"
        
        return newFoodLocation
    }
    
    static var previews: some View {
        LocationListCellView(foodLocation: getDummyLocation(), context: PersistenceController.preview.container.viewContext)
    }
}
