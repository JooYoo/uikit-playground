//
//  Task.swift
//  TodoList
//
//  Created by Yu on 15.08.22.
//

import Foundation

enum Priority: Int {
    case High
    case Medium
    case Low
}

struct Task {
    let title:String
    let priority: Priority
}
