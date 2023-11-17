//
//  AdminOrdersViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 15.11.2023.
//

import Foundation

final class AdminOrdersViewModel: ObservableObject {
    @Published var orders = [Order]()
    var currentOrder = Order(userID: "", date: Date(), status: "новый") //сюда передадим нажатый заказ на который будем переходить

    func getOrders() {
        DatabaseService.shared.getOrders(by: nil) { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                for (index, order) in self.orders.enumerated() {
                    DatabaseService.shared.getPosiitions(by: order.id) { result in
                        switch result {
                        case .success(let positions):
                            self.orders[index].positions = positions //взят один заказ по индексу из массива
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                }
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
