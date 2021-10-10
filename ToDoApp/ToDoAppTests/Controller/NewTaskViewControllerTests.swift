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
    var placemark: MockCLPlacemark!

    override func setUpWithError() throws {
        try? super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(identifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        try? super.tearDownWithError()
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
        
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        
        sut.save()
        
        
        let coordinate = CLLocationCoordinate2D(latitude: 27.773083, longitude: -82.640205)
        let location = Location(name: "Bar", coordinate: coordinate)
        let generatedTask = Task(title: "Foo", description: "Baz", location: location, date: date)
        
        placemark = MockCLPlacemark()
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        let task = self.sut.taskManager.task(at: 0)

        
        XCTAssertEqual(task, generatedTask)
        
    }
    
    func testSaveButtonHasSaveMethod() {
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail("Action didn't find")
            return
        }
        
        XCTAssertTrue(actions.contains("save"))
    }
    
    func testGeocoderFetchesCorrectCoordinate() {
        let geocoderAnswer = expectation(description: "geocoder answer")
        
        let addressString = "Saint-Petersburg"
        let geocoder = CLGeocoder()
        
        geocoder.geocodeAddressString(addressString) { placemarks, error in
            guard error == nil else {
                XCTFail(error!.localizedDescription)
                return
            }
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            guard let lattitude = coordinate?.latitude, let longitude = coordinate?.longitude else {
                XCTFail("location doesn't found")
                return
            }
            
            XCTAssertEqual(lattitude, 27.773083)
            XCTAssertEqual(longitude, -82.640205)
            geocoderAnswer.fulfill()
        }
        
        waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testSaveDismisesNewNaskViewController() {
        // given
        let mockNewTaskViewController = MockNewTaskViewController()
        let mockGeocoder = MockCLGeocoder()
        mockNewTaskViewController.geocoder = mockGeocoder
        mockNewTaskViewController.taskManager = TaskManager()
        
        mockNewTaskViewController.titleTextfield = UITextField()
        mockNewTaskViewController.titleTextfield.text = "Foo"
        mockNewTaskViewController.locationTextfield = UITextField()
        mockNewTaskViewController.locationTextfield.text = "Bar"
        mockNewTaskViewController.dateTextfield = UITextField()
        mockNewTaskViewController.dateTextfield.text = "Baz"
        mockNewTaskViewController.addressTextfield = UITextField()
        mockNewTaskViewController.addressTextfield.text = "Saint-Petersburg"
        mockNewTaskViewController.descriptionTextfield = UITextField()
        mockNewTaskViewController.descriptionTextfield.text = "01.02.21"
        
        mockNewTaskViewController.saveButton = UIButton()
        mockNewTaskViewController.cancelButton = UIButton()
    
        // when
        mockNewTaskViewController.save()
        
        let coordinate = CLLocationCoordinate2D(latitude: 27.773083, longitude: -82.640205)
    
        placemark = MockCLPlacemark()
        placemark.mockCoordinate = coordinate
        mockGeocoder.completionHandler?([placemark], nil)
        
        let expect = expectation(description: "dismis")
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.05) {
            XCTAssertTrue(mockNewTaskViewController.isDismissed)
            expect.fulfill()
        }
        waitForExpectations(timeout: 0.06, handler: nil)
    }
}

extension NewTaskViewControllerTests {
    class MockCLGeocoder: CLGeocoder {
        var completionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.completionHandler = completionHandler
        }
    }
    
    class MockCLPlacemark: CLPlacemark {
        var mockCoordinate: CLLocationCoordinate2D!
        
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
}

extension NewTaskViewControllerTests {
    class MockNewTaskViewController: NewTaskViewController {
        var isDismissed = false
        
        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDismissed = true
        }
    }
}
