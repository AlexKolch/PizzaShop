//
//  AdminOrdersView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 15.11.2023.
//

import SwiftUI

struct AdminOrdersView: View {
    @StateObject var viewModel = AdminOrdersViewModel() //иниц сразу т.к. у админа всегда будет одна view model и нам не нужно по разному ее инициализировать
    @State private var isShowOrderView = false
    @State private var isShowAuthView = false
    
    var body: some View {
        VStack {
            HStack {
                Button {
                    AuthServices.shared.signOut()
                    isShowAuthView.toggle()
                } label: {
                    Text("Выход").foregroundColor(.red)
                }
                Spacer()
                Button {
                    viewModel.getOrders()
                } label: {
                    Text("Обновить")
                }
            }.padding(.horizontal)

            List {
                ForEach(viewModel.orders, id: \.id) { order in
                    OrderCell(order: order)
                        .onTapGesture {
                            viewModel.currentOrder = order
                            isShowOrderView.toggle()
                        }
                }
            }.listStyle(.plain)
                .onAppear {
                    viewModel.getOrders()
                }
                .sheet(isPresented: $isShowOrderView) {
                    let orderViewModel = OrderViewModel(order: viewModel.currentOrder)
                    OrderView(viewModel: orderViewModel)
            }
        }.fullScreenCover(isPresented: $isShowAuthView) {
            AuthView()
        }
    }
}

struct AdminOrdersView_Previews: PreviewProvider {
    static var previews: some View {
        AdminOrdersView()
    }
}
