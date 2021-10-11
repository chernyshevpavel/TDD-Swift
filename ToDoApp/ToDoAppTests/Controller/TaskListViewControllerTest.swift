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
        try? super.setUpWithError()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut = vc as? TaskListViewController
        let window = UIWindow(frame: UIScreen.main.bounds)
            window.rootViewController = sut
            window.makeKeyAndVisible()
        sut.loadViewIfNeeded()
    }
    
    override func tearDown() {
        sut.dataProvider?.taskManager?.removeAll()
        sut = nil
        super.tearDown()
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
    
    func pressAddTaskBarButton() -> NewTaskViewController {
        guard let newTaskButton = sut.navigationItem.rightBarButtonItem,
              let action = newTaskButton.action
        else {
            return NewTaskViewController()
        }
        
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        
        return sut.presentedViewController as! NewTaskViewController
    }
    
    func testAddNewTaskPresentsNewTaskViewController() {
        let newTaskViewController = pressAddTaskBarButton()
        XCTAssertNotNil(newTaskViewController.titleTextfield)
    }
    
    func testSharesSameTaskManagerWithNewTaskVC() {
        
        let newTaskViewController = pressAddTaskBarButton()
        XCTAssertNotNil(sut.dataProvider.taskManager)
        XCTAssertTrue(newTaskViewController.taskManager === sut.dataProvider.taskManager)
    }
    
    func testWhenViewAppearedTableViewRealoded() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView
        
        sut.beginAppearanceTransition(true, animated: true)
        sut.viewWillAppear(true)
        sut.endAppearanceTransition()
        
        XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
    }
    
    func testTappingCellSendsNotification() {
        let task = Task(title: "Foo")
        sut.dataProvider.taskManager!.add(task: task)
        
        expectation(forNotification: NSNotification.Name(rawValue: "DidSelectRow notification"), object: nil) { notification -> Bool in
            
            guard let taskFromNotification = notification.userInfo?["task"] as? Task else {
                return false
            }
            
            return task == taskFromNotification
        }
        
        let tableView = sut.tableView
        tableView?.delegate?.tableView!(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testSelectedCelNotificationPushesDetailVC() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let sut = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as! TaskListViewController
        
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.keyWindow?.rootViewController = mockNavigationController
        
        sut.loadViewIfNeeded()
    
        let task = Task(title: "Foo")
        let task1 = Task(title: "Bar")
        
        sut.dataProvider.taskManager?.add(task: task)
        sut.dataProvider.taskManager?.add(task: task1)
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidSelectRow notification"), object: self, userInfo: ["task" : task1])
        
        guard let detailViewController = mockNavigationController.pushedViewController as? DetailViewController else {
            XCTFail()
            return
        }
            
        detailViewController.loadViewIfNeeded()
        XCTAssertNotNil(detailViewController.titleLabel)
        XCTAssertTrue(detailViewController.task == task1)
    }
}

extension TaskListViewControllerTest {
    class MockTableView: UITableView {
        var isReloaded = false
        override func reloadData() {
            isReloaded = true
        }
    }
}

extension TaskListViewControllerTest {
    class MockNavigationController: UINavigationController {
        var pushedViewController: UIViewController?
        
        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            super.pushViewController(viewController, animated: animated)
            pushedViewController = viewController
        }
    }
}
