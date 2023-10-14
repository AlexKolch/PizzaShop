//
//  CatalogView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct CatalogView: View {

    var layout = [GridItem(.adaptive(minimum: screen.width / 2.4))]

    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Spacer()

            Section("Популярное") {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: layout, spacing: 16) {
                        ForEach(CatalogViewModel.shared.popularProducts, id: \.id) { item in

                            NavigationLink {
                                ProductDetailView(product: item)
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
                    LazyVGrid(columns: layout, spacing: 16) {
                        ForEach(CatalogViewModel.shared.vegetablesPizzas, id: \.id) { item in
                            NavigationLink {
                                ProductDetailView(product: item)
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
