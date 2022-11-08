//
//  CountyInfo.swift
//  FoodDesertTake2
//
//  Created by Vamsi Putti on 2/20/22.
//

import Foundation
import MapKit

class CountyInfo : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    let title : String?
    
    init(title : String?, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.coordinate = coordinate
        
        super.init()
    }
    
    var subtitle: String? {
        return title
      }
}
