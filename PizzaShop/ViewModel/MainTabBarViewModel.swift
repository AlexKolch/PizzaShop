//
//  MainTabBarViewModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 18.10.2023.
//

import Foundation
import FirebaseAuth

final class MainTabBarViewModel: ObservableObject {
    @Published var user: User

    init(user: User) {
        self.user = user
    }
}
