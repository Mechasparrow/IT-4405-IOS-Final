//
//  LocationListCellView.swift
//  FridgeTracker
//
//  Created by Michael Navazhylau on 4/24/22.
//

import SwiftUI

struct LocationListCellView: View {
    private var location: FoodLocation
    
    init(foodLocation: FoodLocation) {
        location = foodLocation
    }
    
    var body: some View {
        HStack {
            Text("\(location.name!)")
                .font(.system(size: 20))
        }
    }
}

struct LocationListCellView_Previews: PreviewProvider {
    static func getDummyLocation() -> FoodLocation {
        var newFoodLocation = FoodLocation()
        newFoodLocation.name = "Pasta"
        return newFoodLocation
    }
    
    static var previews: some View {
        LocationListCellView(foodLocation: getDummyLocation())
    }
}
