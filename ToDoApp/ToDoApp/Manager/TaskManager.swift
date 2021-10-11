//
//  TaskManager.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 03.05.2021.
//

import UIKit

class TaskManager  {
    private var tasks: [Task] = []
    private var doneTasks: [Task] = []
    
    var tasksCount: Int {
        tasks.count
    }
    
    var doneTasksCount: Int {
        doneTasks.count
    }
    
    var tasksURL: URL {
        let fileURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        guard let documentURL = fileURLs.first else {
            fatalError()
        }
        
        return documentURL.appendingPathComponent("tasks.plist")
    }
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(save), name: UIApplication.willResignActiveNotification, object: nil)
        
        if let data = try? Data(contentsOf: tasksURL) {
            let dictionaries = try? PropertyListSerialization.propertyList(from: data,
                                                                           options: [],
                                                                           format: nil) as! [[String : Any]]
            for dict in dictionaries! {
                if let task = Task(dict: dict) {
                    tasks.append(task)
                }
            }
        }
    }
    
    deinit {
        save()
    }
    
    @objc
    func save() {
        let taskDictionaries = self.tasks.map { $0.dict }
        guard taskDictionaries.count > 0 else {
            removeSavedTasks()
            return
        }
        
        let plistData = try? PropertyListSerialization.data(fromPropertyList: taskDictionaries,
                                                            format: .xml,
                                                            options: PropertyListSerialization.WriteOptions(0))
        try? plistData?.write(to: tasksURL, options: .atomic)
    }
    
    func removeSavedTasks() {
        try? FileManager.default.removeItem(at: tasksURL)
    }
    
    func add(task: Task) {
        guard !tasks.contains(task) else {
            return
        }
        tasks.append(task)
    }
    
    func task(at index: Int) -> Task {
        assert(index >= 0, "Index can not be less than zero")
        return tasks[index]
    }
    
    func doneTask(at index: Int) -> Task {
        return doneTasks[index]
    }
    
    func checkTask(at index: Int) {
        let checkedTask = tasks.remove(at: index)
        doneTasks.append(checkedTask)
    }
    
    func uncheckTask(at index: Int)  {
        let uncheckedTask = doneTasks.remove(at: index)
        tasks.append(uncheckedTask)
    }
    
    func removeAll() {
        tasks.removeAll()
        doneTasks.removeAll()
    }
}
