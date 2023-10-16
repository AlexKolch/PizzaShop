//
//  CartViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 16.10.2023.
//

import Foundation

class CartViewModel: ObservableObject {
    @Published var positions = [Position]()

    func addPosition(_ position: Position) {
        self.positions.append(position)
    }
}
