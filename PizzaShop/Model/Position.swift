//
//  Position.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 16.10.2023.
//

import Foundation

struct Position {
    var product: Product
    var id: String
    var count: Int

    var cost: Int {
        return product.price * self.count
    }
}
