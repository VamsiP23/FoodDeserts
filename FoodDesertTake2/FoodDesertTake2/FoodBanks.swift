//
//  FoodBanks.swift
//  FoodDesertTake2
//
//  Created by Vamsi Putti on 2/21/22.
//

import Foundation
import MapKit

class FoodBanks : NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let title: String?
    let subtitle: String?
    
    init(coordinate : CLLocationCoordinate2D, title : String, subtitle : String) {
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
    }
}
