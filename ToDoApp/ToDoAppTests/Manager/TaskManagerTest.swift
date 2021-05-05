//
//  TaskManagerTest.swift
//  ToDoAppTests
//
//  Created by Павел Чернышев on 03.05.2021.
//

import XCTest
@testable import ToDoApp


class TaskManagerTest: XCTestCase {

    var sut: TaskManager!
    
    override func setUp() {
        sut = TaskManager()
        super.setUp()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testCreateManagerWithZeroTask() {
        XCTAssertEqual(sut.tasksCount, 0)
    }
    
    func testCreateManagerWithZeroDoneTask() {
        XCTAssertEqual(sut.doneTasksCount, 0)
    }
    
    func testAddTaskIncrementTasksCount() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        XCTAssertEqual(sut.tasksCount, 1)
    }
    
    func testTaskAtIndexIsAddadTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        let returnedTask = sut.task(at: 0)
        
        XCTAssertEqual(task.title, returnedTask.title)
    }
}
