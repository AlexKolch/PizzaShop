//
//  ProductDetailViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 15.10.2023.
//

import Foundation

enum Sizes: String, CaseIterable {
    case small = "22 см"
    case big = "33 см"
}

class ProductDetailViewModel: ObservableObject {

    @Published var product: Product
    @Published var count: Int = 0

    init(product: Product) {
        self.product = product
    }

    func getPrice(size: Sizes) -> Int {
        switch size {
        case .small : return product.price
        case .big : return Int(Double(product.price) * 1.30)
        }
    }
}


