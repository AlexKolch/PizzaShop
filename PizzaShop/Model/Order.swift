//
//  Order.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 19.10.2023.
//

import Foundation
import FirebaseFirestore

enum OrderStatus: String {
    case new = "НовыЙ"
    case cooking = "Готовится"
    case deliverv = "Доставляется"
    case completed = "Выполнен"
    case cancelled = "Отменён"
}

struct Order {
    var id: String = UUID().uuidString
    var userID: String
    var positions = [Position]()
    var date: Date
    var status: String

    ///вычисляет сумму всех позиций
    var cost: Int {
        var sum = 0

        for position in positions {
            sum += position.cost
        }

        return sum
    }

    ///Для отправки в БД
    var representation: [String : Any] {

        var repres = [String : Any]()
        repres["id"] = id
        repres["userID"] = userID
        repres["date"] = Timestamp(date: date) //своя интерпретация даты у Firebase
        repres["status"] = status

        return repres
    }
}
