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

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]() {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(items) {
                UserDefaults.standard.set(encoded, forKey: "items")
            }
        }
    }

    init() {
        if let items = UserDefaults.standard.data(forKey: "items")
        {
            let decoder = JSONDecoder()
            if let decoded = try? decoder.decode([ExpenseItem].self, from: items){
                self.items = decoded
                return
            }
        }
        self.items = []
    }
}

struct ContentView: View {
    @ObservedObject var expenses = Expenses()
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
