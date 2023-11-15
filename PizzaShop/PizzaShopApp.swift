//
//  PizzaShopApp.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 13.10.2023.
//

import SwiftUI
import Firebase
import FirebaseAuth

let screen = UIScreen.main.bounds

@main
struct PizzaShopApp: App {

    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate

    var body: some Scene {
        WindowGroup {
            if let user = AuthServices.shared.currentUser {
                if user.uid == "qVZgSFB1uSazDM07HTsr5Bq7S0K2" {
                    AdminOrdersView()
                } else {
                    let viewmodel = MainTabBarViewModel(user: user)
                    MainTabBar(viewModel: viewmodel)
                }
            } else {
                AuthView()
            }
        }
    }

    class AppDelegate: NSObject, UIApplicationDelegate {
        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {

            FirebaseApp.configure()
            print("App Delegate configure")

            return true
        }
    }
}
