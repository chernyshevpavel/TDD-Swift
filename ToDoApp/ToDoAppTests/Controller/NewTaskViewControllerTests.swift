//
//  NewTaskViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 06.09.2021.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class NewTaskViewControllerTests: XCTestCase {
    
    var sut: NewTaskViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testHasTitleTextField() {
        XCTAssertTrue(sut.titleTextfield.isDescendant(of: sut.view))
    }
    
    func testHasLocationTextField() {
        XCTAssertTrue(sut.locationTextfield.isDescendant(of: sut.view))
    }
    
    func testHasDateTextField() {
        XCTAssertTrue(sut.dateTextfield.isDescendant(of: sut.view))
    }
    
    func testHasAddressTextField() {
        XCTAssertTrue(sut.addressTextfield.isDescendant(of: sut.view))
    }
    
    func testHasDesctiptionTextField() {
        XCTAssertTrue(sut.descriptionTextfield.isDescendant(of: sut.view))
    }
    
    func testHasSaveButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    
    func testHasCancelButton() {
        XCTAssertTrue(sut.cancelButton.isDescendant(of: sut.view))
    }
    
    func testSaveUsesGeocoderToConverCoordinateFromAddress() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "06.09.21")!
        
        sut.titleTextfield.text = "Foo"
        sut.locationTextfield.text = "Bar"
        sut.dateTextfield.text = "06.09.21"
        sut.addressTextfield.text = "Saint-Petersburg"
        sut.descriptionTextfield.text = "Baz"
        sut.taskManager = TaskManager()
        
        sut.save { [unowned self] in
            let task = self.sut.taskManager.task(at: 0)
            let coordinate = CLLocationCoordinate2D(latitude: 27.773083, longitude: -82.640205)
            let location = Location(name: "Bar", coordinate: coordinate)
            let generatedTask = Task(title: "Foo", description: "Baz", location: location, date: date)
            
            XCTAssertEqual(task, generatedTask)
        }
    }
}
