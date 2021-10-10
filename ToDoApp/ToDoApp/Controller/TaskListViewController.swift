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
        
        NotificationCenter.default.addObserver(self, selector: #selector(showDetail(withNotification:)), name: NSNotification.Name(rawValue: "DidSelectRow notification"), object: nil)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @objc func showDetail(withNotification notification: Notification) {
        guard let userInfo = notification.userInfo,
              let task = userInfo["task"] as? Task,
              let detailViewController = storyboard?.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController
        else {
            fatalError()
        }
        
        detailViewController.task = task
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}

