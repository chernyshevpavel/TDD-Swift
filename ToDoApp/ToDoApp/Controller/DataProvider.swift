//
//  DataProvider.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 18.05.2021.
//

import Foundation
import UIKit

class DataProvider: NSObject {
    
}

extension DataProvider: UITableViewDelegate {
    
}

extension DataProvider: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        UITableViewCell()
    }
    
    
}
