//
//  NewTaskViewController.swift
//  ToDoApp
//
//  Created by Павел Чернышев on 06.09.2021.
//

import UIKit

class NewTaskViewController: UIViewController {
    @IBOutlet var titleTextfield: UITextField!
    @IBOutlet var locationTextfield: UITextField!
    @IBOutlet var dateTextfield: UITextField!
    @IBOutlet var addressTextfield: UITextField!
    @IBOutlet var descriptionTextfield: UITextField!
    
    @IBOutlet var saveButton: UIButton!
    @IBOutlet var cancelButton: UIButton!
}
