//
//  ExpenseViewCell.swift
//  iExpense
//
//  Created by Derya Antonelli on 30/06/2022.
//

import SwiftUI

struct ExpenseViewCell: View {
    
    var item: ExpenseItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            
            Spacer()
            
            Text(item.amount, format: .currency(code: "USD"))
        }
        .listRowBackground(getColor(for: item.amount))
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


struct ExpenseViewCell_Previews: PreviewProvider {
    static var previews: some View {
        ExpenseViewCell(item: ExpenseItem(name: "Grocery", type: Sections.personal.rawValue, amount: 50))
    }
}
