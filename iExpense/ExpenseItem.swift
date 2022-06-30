//
//  ExpenseItem.swift
//  iExpense
//
//  Created by Derya Antonelli on 13/06/2022.
//

import Foundation

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    var type: String
    let amount: Double
}
