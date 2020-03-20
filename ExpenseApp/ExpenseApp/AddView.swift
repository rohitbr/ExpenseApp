//
//  AddView.swift
//  ExpenseApp
//
//  Created by Rohit on 3/19/20.
//  Copyright © 2020 lumasecurity. All rights reserved.
//

import SwiftUI

struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
    static let types = ["Business", "Personal"]
    @ObservedObject var expenses : Expenses
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                TextField("Name", text: $name)
                Picker("Type", selection: $type) {
                    ForEach(Self.types, id: \.self) {
                        Text($0)
                    }
                }

                TextField("Amount", text: $amount)
                    .keyboardType(.numberPad)
            }
        .navigationBarItems(trailing:
            Button("save") {
                if let amount = Int(self.amount) {
                    let expenseItem = ExpenseItem.init(name: self.name, type: self.type, amount: amount)
                    self.expenses.items.append(expenseItem)
                    self.presentationMode.wrappedValue.dismiss()
                }
            }
            )
        }
    }
}
