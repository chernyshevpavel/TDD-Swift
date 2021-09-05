//
//  DetailViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 05.09.2021.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!

    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }
    
    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    func testHasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }

    
    func testHasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    func setUpTaskANdAppearanceTransition() {
        let coordinte = CLLocationCoordinate2D(latitude: 59.93980483, longitude: 30.31479836)
        let location = Location(name: "Baz", coordinate: coordinte)
        let date = Date(timeIntervalSince1970: 1630789200)
        let task = Task(title: "Foo", description: "Bar", location: location, date: date)
        
        sut.task = task
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
    }
    
    func testSettingTaskSetsTitleLabel() {
        setUpTaskANdAppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    func testSettingTaskSetsDescriptionLabel() {
        setUpTaskANdAppearanceTransition()
        
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    func testSettingTaskSetsLocationLabel() {
        setUpTaskANdAppearanceTransition()
        
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    func testSettingTaskSetsDateLabel() {
        setUpTaskANdAppearanceTransition()
        
        XCTAssertEqual(sut.dateLabel.text, "05.09.21")
    }
    
    func testSettingTaskSetsMapView() {
        setUpTaskANdAppearanceTransition()
        
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 59.93980483, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 30.31479836, accuracy: 0.001)
    }

}
