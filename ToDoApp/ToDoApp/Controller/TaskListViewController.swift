//
//  ViewController.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 28.04.2021.
//

import UIKit

class TaskListViewController: UIViewController {
    
    private lazy var taskManager = TaskManager()

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var dataProvider: DataProvider!
    @IBAction func addNewTask(_ sender: UIBarButtonItem) {
        if let viewController = storyboard?.instantiateViewController(identifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController {
            viewController.taskManager = taskManager
            present(viewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataProvider.taskManager = taskManager
    }

}

