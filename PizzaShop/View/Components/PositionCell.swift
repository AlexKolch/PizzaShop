//
//  PositionCell.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 16.10.2023.
//

import SwiftUI

struct PositionCell: View {

    let position: Position

    var body: some View {

        HStack(spacing: 26.0) {
            Text(position.product.title)
                .fontWeight(.bold)

            Spacer()
            Text("\(position.count) шт.")
            Text("\(position.cost) ₽").frame(width: 75, alignment: .trailing)
        }.padding(.horizontal, 8)
    }
}

struct PositionCell_Previews: PreviewProvider {
    static var previews: some View {
        PositionCell(
            position: Position(product: Product(id: UUID().uuidString, title: "Пицца Маргарита", imageUrl: "vegetable", price: 350, descript: "_"),
                               id: UUID().uuidString,
                               count: 2)
        )
    }
}
