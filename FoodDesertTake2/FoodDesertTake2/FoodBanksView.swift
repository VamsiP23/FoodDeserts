//
//  FoodBanksView.swift
//  FoodDesertTake2
//
//  Created by Vamsi Putti on 2/21/22.
//

import MapKit

class FoodBanksView : MKAnnotationView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        
        guard let foodBank = self.annotation as? FoodBanks else {
            return
        }
        image = UIImage(systemName: "heart.fill")
    }
}
