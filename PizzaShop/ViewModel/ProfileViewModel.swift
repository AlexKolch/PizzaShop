//
//  ProfileViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 18.10.2023.
//

import Foundation

class ProfileViewModel: ObservableObject {

    @Published var userProfile: UserModel
    @Published var orders = [Order]() //массив заказов юзера

    init(userProfile: UserModel) {
        self.userProfile = userProfile
    }

    ///Получить заказы
    func getOrders() {
        DatabaseService.shared.getOrders(by: AuthServices.shared.currentUser?.uid) { result in
            switch result {
            case .success(let orders):
                self.orders = orders
                print("Всего заказов: \(orders.count)")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

    func setProfile() {
        DatabaseService.shared.setUser(user: userProfile) { result in
            switch result {
            case .success(let user):
                print("Создан \(user.name)")
            case .failure(let error):
                print("Ошибка отправки данных \(error.localizedDescription)")
            }
        }
    }

    func getProfile() {
        DatabaseService.shared.getUser { result in
            switch result {
            case .success(let user):
                self.userProfile = user
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
        print("get Profile")
    }
}
