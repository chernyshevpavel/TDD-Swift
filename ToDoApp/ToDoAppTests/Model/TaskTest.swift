//
//  TaskTest.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 28.04.2021.
//

import XCTest
@testable import ToDoApp

class TaskTests: XCTestCase {

    func testInitTaskWithTitle() {
        let task = Task(title: "Bar")
       
        XCTAssertNotNil(task)
    }

    func testInitWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
       
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Bar")
        
        XCTAssertEqual(task.title, "Bar")
    }
    
    func testWhenGiveTitleAndDescriptionSetTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")
       
        XCTAssertEqual(task.title, "Foo")
        XCTAssertEqual(task.description, "Bar")
    }
    
    func testTaskInitsWishDate() {
        let task = Task(title: "Foo")
        XCTAssertNotNil(task.date)
    }
    
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        
        let task = Task(title: "Bar", description: "Baz", location: location)
        
        XCTAssertEqual(location, task.location)
    }
}
