//
//  CartView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct CartView: View {
    var viewModel: CartViewModel

    var body: some View {
        Text("Корзина!")
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel())
    }
}
