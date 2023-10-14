//
//  CatalogViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import Foundation

class CatalogViewModel: ObservableObject {
    static var shared = CatalogViewModel()

    var popularProducts = [Product(id: "1", title: "Пицца Маргарита", imageUrl: "pizzaPlaceholder", price: 400, descript: "вкусная пицца"),
                    Product(id: "2", title: "Пицца Пепперони", imageUrl: "pizzaPlaceholder", price: 450, descript: "вкусная пицца"),
                    Product(id: "3", title: "Пицца 4 сыра", imageUrl: "pizzaPlaceholder", price: 540, descript: "вкусная пицца"),
                    Product(id: "4", title: "Пицца Гавайская", imageUrl: "pizzaPlaceholder", price: 500, descript: "вкусная пицца"),
                    Product(id: "5", title: "Пицца Деревенская", imageUrl: "pizzaPlaceholder", price: 370, descript: "вкусная пицца")]

    var vegetablesPizzas = [Product(id: "1", title: "Вегетарианская", imageUrl: "vegetable", price: 470, descript: "вкусная пицца"),
                    Product(id: "2", title: "Пицца с грибами", imageUrl: "vegetable", price: 350, descript: "вкусная пицца"),
                    Product(id: "3", title: "Витаминная", imageUrl: "vegetable", price: 440, descript: "вкусная пицца"),
                    Product(id: "4", title: "Пицца Летняя", imageUrl: "vegetable", price: 400, descript: "вкусная пицца")
                    ]
}
