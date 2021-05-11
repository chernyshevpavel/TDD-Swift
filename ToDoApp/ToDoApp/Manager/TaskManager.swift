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
    
    var doneTasksCount: Int {
        doneTasks.count
    }
    
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    func add(task: Task) {
        tasks.append(task)
    }
    
    func task(at index: Int) -> Task {
        assert(index >= 0, "Index can not be less than zero")
        return tasks[index]
    }
    
    func checkTask(at index: Int) {
        let checkedTask = tasks.remove(at: index)
        doneTasks.append(checkedTask)
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTasks[index]
    }
}
