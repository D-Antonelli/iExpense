//
//  AddView.swift
//  iExpense
//
//  Created by Derya Antonelli on 13/06/2022.
//

import SwiftUI

struct AddView: View {
    @ObservedObject var expenses: Expenses
    @Environment(\.dismiss) var dismiss
    
    @State private var name = ""
    @State private var type = "Personal"
    @State private var currencyCode = "USD"
    @State private var amount = 0.0
    
    private var numberFormatter: NumberFormatter

    init(expenses: Expenses, numberFormatter: NumberFormatter = NumberFormatter()) {
        self.expenses = expenses
        self.numberFormatter = numberFormatter
        self.numberFormatter.numberStyle = .currency
        self.numberFormatter.currencyCode = currencyCode
    }
    
    let types = ["Business", "Personal"]
    let currencyCodes = ["USD", "GBP", "EUR"]
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                Picker("Currency", selection: $currencyCode) {
                    ForEach(currencyCodes, id: \.self) {
                        Text($0)
                    }
                    .onChange(of: currencyCode) {code in
                        self.numberFormatter.currencyCode = code
                        // trigger UI changes for real-time update
                        amount+=1
                        amount-=1
                    }
                }
                
                TextField("Amount", value: $amount, formatter: numberFormatter)
                    .keyboardType(.decimalPad)
            }
            .navigationTitle("Add new expense")
            .toolbar {
                Button("Save") {
                    let item = ExpenseItem(name: name, type: type, amount: amount)
                    expenses.items.append(item)
                    dismiss()
                }
            }
        }
    }
}


struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
}
