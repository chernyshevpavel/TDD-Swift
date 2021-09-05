//
//  TaskCellTests.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 03.09.2021.
//

import XCTest
@testable import ToDoApp

class TaskCellTests: XCTestCase {
    
    var cell: TaskCell!
    
    override func setUpWithError() throws {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as! TaskListViewController
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = FakeDataSource()
        
        tableView?.dataSource = dataSource
        cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as? TaskCell
    }
    
    func testCellHasTitleLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testCellHasTitleLabelInContentView() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasLocationLabel() {
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testCellHasTitleLocationInContentView() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))
    }
    
    func testCellHasDateLabel() {
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testCellHasDateLocationInContentView() {
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))
    }
    
    func configureCellWithTask(done: Bool = false) -> Task {
        let task = Task(title: "Foo")
        cell.configure(withTask: task, done: done)
        return task
    }
    
    func testConfigureSetsTitle() {
        let task = configureCellWithTask()
        XCTAssertEqual(cell.titleLabel.text, task.title)
    }
    
    func testConfigureSetsLocation() {
        let task = Task(title: "Foo", location: Location(name: "Bar", coordinate: nil))
        cell.configure(withTask: task)
        XCTAssertEqual(cell.locationLabel.text, task.location?.name)
    }
    
    func testConfiguteSetsDate() {
        let task = configureCellWithTask()
        
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "dd.MM.yy"
        
        XCTAssertEqual(cell.dateLabel.text, dateFormater.string(from: task.date))
    }
    
    func testDoneTaskShouldStrikeThrough() {
        _ = configureCellWithTask(done: true)
        
        let attributedString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
        XCTAssertEqual(cell.titleLabel.attributedText, attributedString)
    }
    
    func testDoneTaskDateLabelEqualsNil() {
        _ = configureCellWithTask(done: true)
        XCTAssertNil(cell.dateLabel)
    }
    
    func testDoneTaskLocationLabelEqualsNil() {
        _ = configureCellWithTask(done: true)
        XCTAssertNil(cell.locationLabel)
    }
}

extension TaskCellTests {
    class FakeDataSource: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            UITableViewCell()
        }
        
        
    }
}
