//
//  CatalogView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct CatalogView: View {
    @StateObject var viewModel = CatalogViewModel()

    let layoutForMeat = [GridItem(.adaptive(minimum: screen.width / 2.2))]
    let layoutForVegan = [GridItem(.adaptive(minimum: screen.width / 2.4))]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer()
            Section("Мясная") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutForMeat, spacing: 16) {
                        ForEach(viewModel.meatPizzas, id: \.id) { item in

                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel, size: .small)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding()
                }
            }

            Section("Вегетарианская") {
                ScrollView(.vertical, showsIndicators: false) {
                    LazyVGrid(columns: layoutForVegan, spacing: 16) {
                        ForEach(viewModel.vegetablesPizzas, id: \.id) { item in

                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel, size: .small)
                            } label: {
                                ProductCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding()
                }
            }
            //СЕКЦИЯ АДМИНА ДЛЯ НОВЫХ ТОВАРОВ
            Section("Акции") {
                ScrollView(.horizontal, showsIndicators: true) {
                    LazyVGrid(columns: layoutForMeat, spacing: 16) {
                        ForEach(viewModel.promotionPizza, id: \.id) { item in

                            NavigationLink {
                                let viewModel = ProductDetailViewModel(product: item)
                                ProductDetailView(viewModel: viewModel, size: .small)
                            } label: {
                                PromotionCell(product: item)
                                    .foregroundColor(.black)
                            }
                        }
                    }.padding()
                }
            }
        }.onAppear {
            viewModel.getProducts() //Подгружаем продукты из модели и БД
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
