//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 18.05.2021.
//

import Foundation
import UIKit

enum Section: Int, CaseIterable {
    case todo
    case done
}

class DataProvider: NSObject {
    var taskManager: TaskManager?
}

extension DataProvider: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForDeleteConfirmationButtonForRowAt indexPath: IndexPath) -> String? {
        
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section num")
        }
        
        switch section {
        case .todo:
            return "Done"
        case .done:
            return "Undone"
        }
    }
}

extension DataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else {
            fatalError("Unexpected section num")
        }
        
        guard let taskManager = taskManager else {
            return 0
        }
        
        switch section {
            case .todo: return taskManager.tasksCount
            case .done: return taskManager.doneTasksCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: indexPath) as? TaskCell else {
            fatalError("couldn't cast cell to TaskCell")
        }
        guard let section = Section(rawValue: indexPath.section) else {
            fatalError("Unexpected section num")
        }
        guard let taskManager = taskManager else {
            fatalError("couldn't get task manager")
        }
        
        var task: Task
        switch section {
        case .todo:
            task = taskManager.task(at: indexPath.row)
        case .done:
            task = taskManager.doneTask(at: indexPath.row)
        }
        
        cell.configure(withTask: task)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        guard let section = Section(rawValue: indexPath.section) else { fatalError("Unexpected section num") }
        guard let taskManager = taskManager else { fatalError("couldn't get task manager") }
        
        switch section {
        case .todo:
            taskManager.checkTask(at: indexPath.row)
        case .done:
            taskManager.uncheckTask(at: indexPath.row)
        }
        
        tableView.reloadData()
    }
}
