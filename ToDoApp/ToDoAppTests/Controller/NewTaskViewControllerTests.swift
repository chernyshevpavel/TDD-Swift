//
//  NewTaskViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 06.09.2021.
//

import XCTest
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
}
