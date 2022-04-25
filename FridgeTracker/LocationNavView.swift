//
//  LocationNavView.swift
//  FridgeTracker
//
//  Created by Michael Navazhylau on 4/24/22.
//

import SwiftUI
import CoreData



struct LocationNavView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FoodLocation.entity(), sortDescriptors: [])
    var locations: FetchedResults<FoodLocation>
    
    var body: some View {
        NavigationView {
            List {
                ForEach (locations) { location in
                    NavigationLink(destination: GroceryLocationListView(locationToView: location, viewContext: viewContext))
                    {
                        LocationListCellView(foodLocation: location)
                    }
                }
            }
            .navigationTitle("Pick Food Location")
        }
    }
}

struct LocationNavView_Previews: PreviewProvider {
    static var previews: some View {
        LocationNavView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
