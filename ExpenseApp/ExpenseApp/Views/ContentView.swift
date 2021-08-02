//
//  ContentView.swift
//  ExpenseApp
//
//  Created by Rohit on 3/19/20.
//  Copyright © 2020 lumasecurity. All rights reserved.
//

import SwiftUI

struct ExpenseItem : Identifiable, Codable {
    let id = UUID()
    let name : String
    let type : String
    let amount :Int
}

struct ContentView: View {
    @ObservedObject var expenses = ExpensesViewModel()
    @State private var showingAddExpense = false

    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack {
                            Text(item.name)
                                .font(.headline)
                            Text(item.type)
                            .font(.subheadline)
                        }

                        Spacer()
                        Text("$\(item.amount)")
                    }

                }
            .onDelete(perform: removeRows)
            }
        .navigationBarTitle("ExpenseApp")
        .navigationBarItems(leading: EditButton())
        .navigationBarItems(trailing:
                Button(action: {
                    self.showingAddExpense.toggle()
                }) {
                    Image(systemName: "plus")
            })
                .sheet(isPresented: $showingAddExpense) {
                    // This is modal view
                    AddView(expenses: self.expenses)
                    //
            }
        }

    }

    func removeRows(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
