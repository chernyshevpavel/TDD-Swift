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
    
    func testCanBeCreatedFromPlistDictionary() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        let locationDictionary: [String : Any] = ["name" : "Baz"]
        let dictionary: [String : Any] = ["title" : "Foo",
                                          "description" : "Bar",
                                          "date" : date,
                                          "location" : locationDictionary]
        let createdTask = Task(dict: dictionary)
        
        XCTAssertEqual(task, createdTask)
    }
    
    func testCanBeSerializedIntoDictionary() {
        let location = Location(name: "Baz")
        let date = Date(timeIntervalSince1970: 10)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        let generatedTask = Task(dict: task.dict)
        
        XCTAssertEqual(task, generatedTask)
    }
}
