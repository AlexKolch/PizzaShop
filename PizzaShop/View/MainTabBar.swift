//
//  MainTabBar.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct MainTabBar: View {

    var viewModel: MainTabBarViewModel

    var body: some View {
        TabView {

            NavigationStack {
                CatalogView()
            }
            .tabItem {
                Image(systemName: "menucard")
                Text("Каталог")
            }

            CartView(viewModel: CartViewModel.shared)
                .tabItem {
                    Image(systemName: "cart")
                    Text("Корзина")
                }

            ProfileView(profileViewModel: ProfileViewModel(userProfile: UserModel(id: "", name: "", phoneNumber: 0000000000, address: "")))
                .tabItem {
                    Image(systemName: "person.circle")
                    Text("Профиль")
                }
        }

    }
}

//struct MainTabBar_Previews: PreviewProvider {
//    static var previews: some View {
//        MainTabBar(viewModel: MainTabBarViewModel(user: User()))
//    }
//}
