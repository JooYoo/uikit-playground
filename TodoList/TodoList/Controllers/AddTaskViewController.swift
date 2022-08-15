//
//  AddTaskViewController.swift
//  TodoList
//
//  Created by Yu on 15.08.22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class AddTaskViewController: UIViewController {
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var taskTitleTextField: UITextField!
    @IBAction func save(){
        // get Task data
        guard let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex) else {
            return
        }
        guard let title = self.taskTitleTextField.text else {
            return
        }
        // init Task
        let task = Task(title: title, priority: priority)
        
        print(task)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
