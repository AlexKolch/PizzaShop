//
//  MainTabBarViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 18.10.2023.
//

import Foundation
import FirebaseAuth

class MainTabBarViewModel: ObservableObject {
    @Published var user: User

    init(user: User) {
        self.user = user
    }
}
