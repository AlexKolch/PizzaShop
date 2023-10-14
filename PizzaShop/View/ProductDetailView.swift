//
//  ProductDetailView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct ProductDetailView: View {
    var product: Product
    
    var body: some View {
        Text("\(product.title)")
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(product: Product(id: "1", title: "Пицца", imageUrl: "pizzaPlaceholder", price: 370, descript: "вкусная пицца"))
    }
}
