//
//  Task.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 28.04.2021.
//

import Foundation

struct Task: Equatable {
    let title: String
    var description: String?
    var location: Location?
    private(set) var date = Date()
    
    var dict: [String : Any] {
        var dict: [String : Any] = [:]
        dict["title"] = title
        dict["description"] = description
        dict["date"] = date
        if let location = location {
            dict["location"] = location.dict
        }
        return dict
    }
    
    static func == (lhs: Task, rhs: Task) -> Bool {
        let topDateBorder = lhs.date.addingTimeInterval(10)
        let bottomDateBorder = lhs.date.addingTimeInterval(-10)
        return lhs.title == rhs.title &&
            lhs.description == rhs.description &&
            lhs.location == rhs.location &&
            (rhs.date > bottomDateBorder && rhs.date < topDateBorder)
    }
}

extension Task {
    typealias PlistDictionary = [String : Any]
    init?(dict: PlistDictionary) {
        self.title = dict["title"] as! String
        self.description = dict["description"] as? String
        self.date = dict["date"] as? Date ?? Date()
        if let locationDictionary = dict["location"] as? [String : Any] {
            self.location = Location(dict: locationDictionary)
        } else {
            self.location = nil
        }
    }
}
