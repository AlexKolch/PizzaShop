//
//  Product.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import Foundation

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
 }
