//
//  ContentView.swift
//  iExpense
//
//  Created by Derya Antonelli on 06/06/2022.
//

import SwiftUI

struct ListRowView: View {

    
    var category: Category
    
    var body: some View {
        Section(header: Text(category.name)) {
            ForEach(category.items) { item in
                HStack {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .font(.headline)
                        Text(item.type)
                    }
                    
                    Spacer()
                    
                    Text(item.amount, format: .currency(code: "USD"))
                    
                }
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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { category in
                    ListRowView(category: category)
  
                }
                .onDelete(perform: removeItems)
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
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
