//
//  ContentView.swift
//  iExpense
//
//  Created by Derya Antonelli on 06/06/2022.
//

import SwiftUI

struct ListRowView: View {
    
    
    var item: ExpenseItem
    
    var body: some View {
        Section(header: Text(item.type)) {
            HStack {
                VStack(alignment: .leading) {
                    Text(item.name)
                        .font(.headline)
                    Text(item.type)
                }
                
                Spacer()
                
                Text(item.amount, format: .currency(code: "USD"))
                
                    .foregroundColor(Color.white)
                    .listRowBackground(getColor(for: item.amount))
            }
            
        }
        
    }
    
    func getColor(for amount: Double) -> some View {
        if(amount < 50.00) {
            return Color.green
        }
        else if(amount < 500.00) {
            return Color.yellow
        }
        
        else if(amount < 1000.00) {
            return Color.orange
        }
        
        else if(amount < 10000.00) {
            return Color.purple
        }
        else if(amount >= 10000.00) {
            return Color.red
        }
        return Color.clear
    }
}


struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var businessExpenses: [Binding<ExpenseItem>] {
        $expenses.items.filter { $0.type.wrappedValue == "Business" }
    }
    
    var personalExpenses: [Binding<ExpenseItem>] {
        $expenses.items.filter { $0.type.wrappedValue == "Personal"}
    }

    
    var body: some View {
        NavigationView {
            List {
                ForEach(Sections.allCases, id: \.self) { section in
                    Section(header: Text(section.rawValue)) {
                        let filteredExpenses = section == .business ? businessExpenses : personalExpenses
                        
                        ForEach(filteredExpenses) { $item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: .currency(code: "USD"))
                                    .foregroundColor(Color.white)
                                    .listRowBackground(getColor(for: item.amount))
                            }
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
    
    
    func getColor(for amount: Double) -> some View {
        if(amount < 30.00) {
            return Color.green
        }
        else if(amount < 100.00) {
            return Color.yellow
        }
        
        else if(amount < 300) {
            return Color.orange
        }
        
        else if(amount < 500) {
            return Color.purple
        }
        else if(amount >= 500) {
            return Color.red
        }
        return Color.clear
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
