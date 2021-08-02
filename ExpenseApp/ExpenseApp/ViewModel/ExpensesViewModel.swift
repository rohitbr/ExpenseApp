//
//  ExpensesViewModel.swift
//  ExpenseApp
//
//  Created by Bhat, Rohit on 8/2/21.
//  Copyright © 2021 lumasecurity. All rights reserved.
//

import Foundation

class ExpensesViewModel: ObservableObject {
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
