//
//  CartView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct CartView: View {

    @StateObject var viewModel: CartViewModel

    var body: some View {
        VStack {
            List(viewModel.positions) { position in
                PositionCell(position: position)
                    .swipeActions {
                        //УДАЛЯЕМ ЯЧЕЙКУ ПОЗИЦИИ ИЗ viewModel
                        Button {
                            viewModel.positions.removeAll { pos in
                                pos.id == position.id
                            }
                        } label: {
                            Text("Удалить")
                        }
                    }
            }
            .listStyle(.plain)
            .navigationTitle("Корзина")

            HStack {
                Text("Итого:").fontWeight(.bold)
                Spacer()
                Text("\(viewModel.cost) ₽").fontWeight(.bold)
            }.padding()

            HStack {
                Button {
                    print("Отменить")
                } label: {
                    Text("Отменить")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.red)
                        .cornerRadius(24)
                }

                Button {
                    print("Заказать")
                } label: {
                    Text("Заказать")
                        .fontWeight(.bold)
                        .padding()
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.green)
                        .cornerRadius(24)
                }

            }.padding()
        }
    }
}

struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView(viewModel: CartViewModel.shared)
    }
}
