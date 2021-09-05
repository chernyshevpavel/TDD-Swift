//
//  TaskCell.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 19.05.2021.
//

import UIKit

class TaskCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var dateFormater: DateFormatter?
    
    func configure(withTask task: Task) {
        titleLabel.text = task.title
        if let location = task.location {
            locationLabel.text = location.name
        }
        
        let df = dateFormater ?? getDefaultDateFormater()
        dateLabel.text = df.string(from: task.date)
    }
    
    private func getDefaultDateFormater() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
}
