//
//  PizzaShopApp.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 13.10.2023.
//

import SwiftUI

let screen = UIScreen.main.bounds

@main
struct PizzaShopApp: App {
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
