//
//  Position.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 16.10.2023.
//

import Foundation
import FirebaseFirestore

struct Position: Identifiable {

    var product: Product
    var id: String
    var count: Int

    var cost: Int {
        return product.price * self.count
    }

    ///Записываем в словарь для отправки в БД
    var representation: [String: Any] {

        var repres = [String: Any]()
        repres["id"] = id
        repres ["count"] = count
        repres["title"] = product.title
        repres["price"] = product.price
        repres["cost"] = cost

        return repres
    }

    init(product: Product, id: String, count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }

    ///Для создания позиции из документа базы данных Firebase
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data() //Берем данные из документа
        ///Из этих данных получаем  эти данные
        guard let id = data["id"] as? String else {return nil}
        guard let title = data["title"] as? String else {return nil}
        guard let price = data["price"] as? Int else {return nil}
        let product = Product(id: "", title: title, imageUrl: "", price: price, descript: "")
        guard let count = data["count"] as? Int else {return nil}

        self.id = id
        self.product = product
        self.count = count
    }
}
