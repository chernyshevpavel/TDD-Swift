//
//  LocationTest.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 30.04.2021.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class LocationTest: XCTestCase {
     
    func testInitSetsCoordinates() {
        let coordinate = CLLocationCoordinate2D(latitude: 1, longitude: 2)
        let location = Location(name: "Foo", coordinate: coordinate)
        
        XCTAssertEqual(location.coordinate?.longitude, coordinate.longitude)
        XCTAssertEqual(location.coordinate?.latitude, coordinate.latitude)
    }
    
    func testInitSetsName() {
        let location = Location(name: "Foo")
        
        XCTAssertEqual(location.name, "Foo")
    }
    
    func testCanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Foo", coordinate: CLLocationCoordinate2D(latitude: 10.0,
                                                                                longitude: 10.0))
        let dict: [String : Any] = ["name" : "Foo",
                                    "latitude" : 10.0,
                                    "longitude" : 10.0]
        
        let createdLocation = Location(dict: dict)
        
        XCTAssertEqual(location, createdLocation)
    }
}
