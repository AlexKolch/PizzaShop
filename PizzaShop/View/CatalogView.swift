//
//  CatalogView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct CatalogView: View {

//    @ObservedObject var sizePizza: ProductDetailViewModel

    let layoutForPopular = [GridItem(.adaptive (minimum: screen.width / 2.2))]
    var layoutForPizza = [GridItem(.adaptive(minimum: screen.width / 2.4))]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer()

            Section("Популярное") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layoutForPopular, spacing: 16) {
                        ForEach(CatalogViewModel.shared.popularProducts, id: \.id) { item in

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
                    LazyVGrid(columns: layoutForPizza, spacing: 16) {
                        ForEach(CatalogViewModel.shared.vegetablesPizzas, id: \.id) { item in

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
        }
    }
}

struct CatalogView_Previews: PreviewProvider {
    static var previews: some View {
        CatalogView()
    }
}
