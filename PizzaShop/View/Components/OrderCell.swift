//
//  OrderCell.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 20.10.2023.
//

import SwiftUI

struct OrderCell: View {
    var order: Order

    var body: some View {
        HStack {
            Text("\(order.date)")
            Text("\(order.cost)").bold()
                .frame(width: 90)
            Text("\(order.status)")
                .frame(width: 100)
                .foregroundColor(.green)
        }
    }
}


struct OrderCell_Previews: PreviewProvider {
    static var previews: some View {
        OrderCell(order: Order.examplePrewiews)
    }
}
