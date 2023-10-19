//
//  Position.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 16.10.2023.
//

import Foundation

struct Position: Identifiable {

    var product: Product
    var id: String
    var count: Int

    var cost: Int {
        return product.price * self.count
    }

    ///Для отправки в БД
    var representation: [String: Any] {

        var repres = [String: Any]()
        repres["id"] = id
        repres ["count"] = count
        repres["title"] = product.title
        repres["price"] = product.price
        repres["cost"] = cost

        return repres
    }
}
