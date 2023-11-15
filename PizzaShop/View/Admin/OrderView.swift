//
//  OrderView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 15.11.2023.
//

import SwiftUI

struct OrderView: View {

    @StateObject var viewModel: OrderViewModel

    var statuses: [String] {
        var statusArray = [String]()

        for status in OrderStatus.allCases {
            statusArray.append(status.rawValue)
        }

        return statusArray
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8.0) {
            Text(viewModel.user.name).font(.title3).bold()
            Text("\(viewModel.user.phoneNumber)").bold()
            Text(viewModel.user.address)

            Picker(selection: $viewModel.order.status) {
                ForEach(statuses, id: \.self) {
                    Text($0)
                }
            } label: {
                Text("Статус заказа")
            }.onChange(of: viewModel.order.status) { newStatus in //изменение статуса в пикере запишнм в бд
                DatabaseService.shared.setOrder(order: viewModel.order) { result in
                    switch result {
                    case .success(let order):
                        print(order.status)
                    case .failure(let failure):
                        print(failure.localizedDescription)
                    }
                }
            }

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
