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

class TaskListViewController: UIViewController, UITableViewDelegate {
    // Rx
    let bag = DisposeBag()
    let tasks = BehaviorRelay<[Task]>(value: [])
    var filteredTasks = BehaviorRelay<[Task]>(value: [])
    // IBs
    @IBOutlet weak var prioritySegmentedControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBAction func priorityValueChanged(segmentedControl: UISegmentedControl){
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex - 1)
        filterTasks(by: priority)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // set TaskListView to a large title
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        bindTableView()
    }
    
    private func getEmoji(by priority: Priority)->String{
        switch priority {
        case .High:
            return "🥵"
        case .Medium:
            return "😐"
        case .Low:
            return "🥱"
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard segue.identifier == "addTaskSegue", let addTaskViewController = segue.destination as? AddTaskViewController else {
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
            
            // filter tasks
            self.filterTasks(by: priority)
        }).disposed(by: bag)
    }
    
    func bindTableView() {
        // Set tableview delegate. (for setting table view cell height)
        tableView.rx
            .setDelegate(self)
            .disposed(by: bag)
            
        // Bind tasks with tableview
        filteredTasks.asObservable()
            .bind(to: tableView.rx
                .items(cellIdentifier: "TaskTableViewCell", cellType: UITableViewCell.self)){ index, element, cell in
                // Write data for cell label.
                cell.textLabel?.text = "\(self.getEmoji(by: element.priority)): \(element.title)"
        }.disposed(by: bag)
    }
    
    private func filterTasks(by priority: Priority?) {
        if priority == nil {
            // segmentedControl: 'All' selected
            filteredTasks.accept(tasks.value)
        } else {
            // segmentedControl: other selected
            filteredTasks.accept(tasks.value.filter{ $0.priority == priority})
        }
    }
}

