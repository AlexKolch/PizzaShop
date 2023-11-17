//
//  OrderViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 15.11.2023.
//

import Foundation

final class OrderViewModel: ObservableObject {

    @Published var order: Order
    @Published var user = UserModel(id: "", name: "", phoneNumber: 0, address: "")

    init(order: Order) {
        self.order = order
    }

    func getUserData() {
        DatabaseService.shared.getUser(by: order.userID) { result in
            switch result {
            case .success(let user):
                self.user = user
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
}
