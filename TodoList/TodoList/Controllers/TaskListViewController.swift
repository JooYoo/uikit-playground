//
//  TodoListViewController.swift
//  TodoList
//
//  Created by Yu on 15.08.22.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class TaskListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    // Rx
    let bag = DisposeBag()
    let tasks = BehaviorRelay<[Task]>(value: [])
    // IBs
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set TaskListView to a large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskTableViewCell", for: indexPath)
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationController = segue.destination as? UINavigationController else {
            fatalError("get navigationController error")
        }

        guard let addTaskViewController = navigationController.viewControllers.first as? AddTaskViewController else{
            fatalError("get AddTaskViewController error")
        }
        
        // Rx: subscribe to Subject to get notified when Task update
        addTaskViewController.taskSubjectObservable.subscribe(onNext: {
            // get new Task priority
            /// -1: the amount of Segments in TaskListViewController is one less than in AddTaskViewController
            let priority = Priority(rawValue: self.prioritySegmentedControl.selectedSegmentIndex - 1)
            
            // Rx: BehaviorRelay holds a list of Tasks
            var existTasks = self.tasks.value
            existTasks.append($0)
            self.tasks.accept(existTasks)
            
            print(existTasks)
        }).disposed(by: bag)
    }
}

