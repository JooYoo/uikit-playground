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
            print("\($0.title): \($0.priority)")
        }).disposed(by: bag)
    }
}

