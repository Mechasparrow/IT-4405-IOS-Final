//
//  ContentView.swift
//  FridgeTracker
//
//  Created by Michael Navazhylau on 4/24/22.
//

import SwiftUI
import CoreData

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: FoodLocation.entity(), sortDescriptors: [])
    var locations: FetchedResults<FoodLocation>
    
    var body: some View {
        VStack {
            Text("Locations below")
            ForEach (locations) {location in
                Text("\(location.name!)")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}
