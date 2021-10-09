//
//  TaskListViewControllerTest.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 17.05.2021.
//

import XCTest
@testable import ToDoApp

class TaskListViewControllerTest: XCTestCase {
    
    var sut: TaskListViewController!
    
    override func setUp() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut = vc as? TaskListViewController
        let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = sut
            window.makeKeyAndVisible()
        sut.loadViewIfNeeded()
    }

    func testWhenViewIsLoadedTableViewNotNil() {
        XCTAssertNotNil(sut.tableView)
    }
    
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        XCTAssertNotNil(sut.dataProvider)
    }

    func testWhenViewIsLoadedTableViewDelegetIsSet() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenViewIsLoadedTableDataSourceIsSet() {
        XCTAssertNotNil(sut.tableView.dataSource)
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    func testWhevViewIsLoadedTableViewDelegeteEqualsTableViewDataSource() {
        XCTAssertEqual(sut.tableView.delegate as? DataProvider, sut.tableView.dataSource as? DataProvider)
    }
    
    func testTaskListVCHasAddBarButtonWithSelfAsTarget() {
        let target = sut.navigationItem.rightBarButtonItem?.target
        XCTAssertEqual(target as? TaskListViewController, sut)
    }
    
    func testAddNewTaskPresentsNewTaskViewController() {
        XCTAssertNil(sut.presentedViewController)
        guard let newTaskButton = sut.navigationItem.rightBarButtonItem,
              let action = newTaskButton.action
        else {
            XCTFail()
            return
        }
        
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        XCTAssertNotNil(sut.presentedViewController)
        XCTAssertTrue(sut.presentedViewController is NewTaskViewController)
        
        let newTaskViewController = sut.presentedViewController as! NewTaskViewController
        XCTAssertNotNil(newTaskViewController.titleTextfield)
        
    }
}
