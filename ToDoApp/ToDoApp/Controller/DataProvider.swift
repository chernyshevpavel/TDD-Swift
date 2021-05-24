//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 18.05.2021.
//

import Foundation
import UIKit

enum Section: Int {
    case todo
    case done
}

class DataProvider: NSObject {
    var taskManager: TaskManager?
}

extension DataProvider: UITableViewDelegate {
    
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
        if let task = taskManager?.task(at: indexPath.row) {
            cell.configure(withTask: task)
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
}
