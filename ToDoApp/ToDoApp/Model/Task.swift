//
//  Task.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 28.04.2021.
//

import Foundation

struct Task {
    var title: String
    var description: String?
    private(set) var date = Date()
}
