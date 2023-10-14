//
//  ProductCell.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct ProductCell: View {
    var product: Product

    var body: some View {
        VStack(spacing: 3.0) {
            Image(product.imageUrl).resizable()
                .scaledToFill()
                .frame(minWidth: screen.width * 0.45)
                .clipped()
                //.cornerRadius(16)

            HStack {
                Text(product.title)
                    .font(.custom("AvenirNext-regular", size: 12))
                Spacer()
                Text("\(product.price) ₽")
                    .font(.custom("AvenirNext-bold", size: 12))
            }.padding(.horizontal, 8)
                .padding(.bottom, 10)

        }.frame(width: screen.width * 0.45, height: screen.height * 0.35)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 4)
    }
}

struct ProductCell_Previews: PreviewProvider {
    static var previews: some View {
        ProductCell(product: Product(id: "1", title: "Пицца", imageUrl: "_", price: 370, descript: "вкусная пицца"))
    }
}
