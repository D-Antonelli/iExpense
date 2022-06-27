//
//  Expenses.swift
//  iExpense
//
//  Created by Derya Antonelli on 13/06/2022.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [Category]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([Category].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        
        items = []
    }
    
    func add(item: Category) {
        self.items.append(item)
    }
    
}

struct Category: Identifiable, Codable {
    var id = UUID()
    let name: String
    let items: [ExpenseItem]
}
