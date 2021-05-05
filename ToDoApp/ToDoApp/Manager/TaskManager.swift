//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 03.05.2021.
//

import Foundation

class TaskManager  {
    var tasksCount: Int {
        tasks.count
    }
    
    let doneTasksCount = 0
    
    private var tasks: [Task] = []
    
    func add(task: Task) {
        tasks.append(task)
    }
    
    func task(at index: Int) -> Task {
        assert(index >= 0, "Index can not be less than zero")
        return tasks[index]
    }
}
