//
//  ProductDetailViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 15.10.2023.
//

import Foundation
import UIKit

enum Sizes: String, CaseIterable {
    case small = "22 см"
    case big = "33 см"
}

final class ProductDetailViewModel: ObservableObject {

    @Published var product: Product
    @Published var count: Int = 0
    @Published var image = UIImage(systemName: "photo")

    init(product: Product) {
        self.product = product
    }

    func getPrice(size: Sizes) -> Int {
        switch size {
        case .small : return product.price
        case .big : return Int(Double(product.price) * 1.30)
        }
    }

    func getImage() {
        StorageService.shared.downloadProductImage(id: product.id) { result in
            switch result {
            case .success(let data):
                if let uiImage = UIImage(data: data) {
                    self.image = uiImage
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


