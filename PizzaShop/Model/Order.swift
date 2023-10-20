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

    init(id: String = UUID().uuidString,
          userID: String,
          positions: [Position] = [Position](),
          date: Date,
          status: String) {
        self.id = id
        self.userID = userID
        self.positions = positions
        self.date = date
        self.status = status
    }

    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data()

        guard let id = data["id"] as? String else {return nil}
        guard let userID = data["userID"] as? String else {return nil}
        guard let date = data["date"] as? Timestamp else {return nil}
        guard let status = data["status"] as? String else {return nil}

        self.id = id
        self.userID = userID
        self.date = date.dateValue()
        self.status = status
    }
}
