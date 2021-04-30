//
//  Task.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 28.04.2021.
//

import Foundation

struct Task {
    let title: String
    var description: String?
    var location: Location?
    private(set) var date = Date()
}
