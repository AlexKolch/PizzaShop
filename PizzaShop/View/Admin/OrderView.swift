//
//  OrderView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 15.11.2023.
//

import SwiftUI

struct OrderView: View {

    @StateObject var viewModel: OrderViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(viewModel.user.name).font(.title3).bold()
            Text("\(viewModel.user.phoneNumber)").bold()
            Text(viewModel.user.address)
            List {
                ForEach(viewModel.order.positions, id: \.id) { position in
                    PositionCell(position: position)
                }
                Text("Итого: \(viewModel.order.cost) ₽")
            }
        }.padding()
            .onAppear {
                viewModel.getUserData()
            }
    }
}

//struct OrderView_Previews: PreviewProvider {
//    static var previews: some View {
//        OrderView(viewModel: OrderViewModel(order: Order(userID: "", date: Date(), status: "new")))
//    }
//}
