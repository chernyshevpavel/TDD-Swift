//
//  Location.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 30.04.2021.
//

import Foundation
import CoreLocation

struct Location: Equatable {
    let name: String
    var coordinate: CLLocationCoordinate2D?
    
    static func == (lhs: Location, rhs: Location) -> Bool {
        return lhs.coordinate?.latitude == rhs.coordinate?.latitude &&
            lhs.coordinate?.longitude == rhs.coordinate?.longitude &&
            lhs.name == rhs.name
    }
}
