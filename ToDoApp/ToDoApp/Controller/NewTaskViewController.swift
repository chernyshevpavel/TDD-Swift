//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 06.09.2021.
//

import UIKit
import CoreLocation

class NewTaskViewController: UIViewController {
    
    var taskManager: TaskManager!
    var geocoder = CLGeocoder()
    var dateFormater: DateFormatter?
    
    @IBOutlet var titleTextfield: UITextField!
    @IBOutlet var locationTextfield: UITextField!
    @IBOutlet var dateTextfield: UITextField!
    @IBOutlet var addressTextfield: UITextField!
    @IBOutlet var descriptionTextfield: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
    
    @IBAction func save() {
        let titleString = titleTextfield.text ?? ""
        let locationString = locationTextfield.text ?? ""
        let df = dateFormater ?? getDefaultDateFormater()
        let date = df.date(from: dateTextfield.text ?? "")
        let descriptionString = descriptionTextfield.text
        let addressString = addressTextfield.text ?? ""
        
        geocoder.geocodeAddressString(addressString) { [unowned self] placemarks, error in
            guard error == nil else {
                print(error ?? "")
                return
            }
            let placemark = placemarks?.first
            let coordinate = placemark?.location?.coordinate
            let location = Location(name: locationString, coordinate: coordinate)
            if let date = date {
                let task = Task(title: titleString, description: descriptionString, location: location, date: date)
                self.taskManager.add(task: task)
            } else {
                let task = Task(title: titleString, description: descriptionString, location: location)
                self.taskManager.add(task: task)
            }
        }
    }
    
    private func getDefaultDateFormater() -> DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        return df
    }
}
