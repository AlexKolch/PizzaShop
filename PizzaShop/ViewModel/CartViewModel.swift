//
//  CartViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 16.10.2023.
//

import Foundation

final class CartViewModel: ObservableObject {

    static let shared = CartViewModel()

    private init() {}

    @Published var positions = [Position]()

    var cost: Int {
        var summ = 0

        for pos in positions {
            summ += pos.cost
        }

        return summ
    }

    func addPosition(_ position: Position) {
        self.positions.append(position)
    }
}
