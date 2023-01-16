//
//  ContentView.swift
//  iExpense
//
//  Created by Derya Antonelli on 06/06/2022.
//

import SwiftUI




struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type  == "Personal"}
    }
    
    
    var body: some View {
        NavigationView {
            List {
                ForEach(Sections.allCases, id: \.self) { section in
                    Section(header: Text(section.rawValue)) {
                        let filteredExpenses = section == .business ? businessExpenses : personalExpenses
                        
                        if filteredExpenses.isEmpty {
                            Text("No expenses available")
                        }
                        
                        ForEach(filteredExpenses) { item in
                            ExpenseViewCell(item: item)
                                .accessibilityLabel("\(item.name)")
                                .accessibilityValue("\(item.amount)")
                                .accessibilityHint("\(item.type)")
                        }
                        .onDelete {indexSet in
                            indexSet.forEach { index in
                                let expenseToDelete = filteredExpenses[index]
                                expenses.items = expenses.items.filter { $0.id != expenseToDelete.id }
                            }
                            
                            
                        }
                        
                        
                    }
                    
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $showingAddExpense) {
            AddView(expenses: expenses)
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
