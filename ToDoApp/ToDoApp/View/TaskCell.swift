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
    
    func configure(withTask task: Task, done: Bool = false) {
        
        if done {
            let attributedString = NSAttributedString(string: task.title, attributes: [NSAttributedString.Key.strikethroughStyle: NSUnderlineStyle.single.rawValue])
            titleLabel.attributedText = attributedString
            locationLabel.text = ""
            dateLabel.text = ""
        } else {
            let df = dateFormater ?? getDefaultDateFormater()
            dateLabel.text = df.string(from: task.date)
            titleLabel.attributedText = nil
            titleLabel.text = task.title
            locationLabel.text = task.location?.name
        }
    }

    
    private func getDefaultDateFormater() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
}
