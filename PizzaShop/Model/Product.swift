//
//  Product.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import Foundation
import FirebaseFirestore

struct Product {

    var id: String
    var title: String
    var imageUrl: String = "" //пока не нужен
    var price: Int
    var descript: String

//    var ordersCount: Int
//    var isRecommend: Bool

    ///Для отправки в БД репрезентуем
    var representation: [String : Any] {

        var repres = [String : Any]()
        repres["id"] = self.id
        repres["title"] = self.title
        repres["price"] = self.price
        repres["descript"] = self.descript

        return repres
    }

    internal init(id: String, title: String, imageUrl: String = "", price: Int, descript: String) {
        self.id = id
        self.title = title
        self.imageUrl = imageUrl
        self.price = price
        self.descript = descript
    }

    ///Для создания продукта из документа бд
    init?(doc: QueryDocumentSnapshot) {
        let data = doc.data() //данные из документа
        ///Из этих данных получаем  эти данные
        guard let id = data["id"] as? String else {return nil}
        guard let title = data["title"] as? String else {return nil}
        guard let price = data["price"] as? Int else {return nil}
        guard let descript = data["descript"] as? String else {return nil}

        self.id = id
        self.title = title
        self.price = price
        self.descript = descript
    }
 }
