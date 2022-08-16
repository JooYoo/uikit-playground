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
    // Rx
    private let subject = PublishSubject<Task>()
    var taskSubjectObservable: Observable<Task> {
        return subject.asObservable()
    }
    
    // IBs
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
        
        // Rx: publish event
        subject.onNext(task)
        
        // dismiss modal
        self.dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
