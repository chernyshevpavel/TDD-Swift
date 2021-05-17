//
//  TaskListViewControllerTest.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 17.05.2021.
//

import XCTest
@testable import ToDoApp

class TaskListViewControllerTest: XCTestCase {

    func testTableViewNotNilWhenViewIsLoaded() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        
        let sut = vc as! TaskListViewController
        
        sut.loadViewIfNeeded()
        
        XCTAssertNotNil(sut.tableView)
    }

}
