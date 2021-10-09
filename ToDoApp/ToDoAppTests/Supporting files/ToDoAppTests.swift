//
//  ToDoAppTests.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 28.04.2021.
//

import XCTest
@testable import ToDoApp

class ToDoAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInitialViewControllerIsTaskListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let navigationController = storyboard.instantiateInitialViewController() as? UINavigationController else {
            XCTFail("Couldn't cast initial vc to navigation vc")
            return
        }
        guard let rootViewController = navigationController.viewControllers.first as? TaskListViewController else {
            XCTFail("Couldn't cast root vc to navigation vc")
            return
        }
        
        
    }

}
