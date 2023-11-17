//
//  ProductDetailView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct ProductDetailView: View {

   @StateObject var viewModel: ProductDetailViewModel

    @State var size: Sizes
    @State var count = 1

    @Environment(\.dismiss) var dismiss
    @Environment(\.presentationMode) var presentationMode //for ios 14
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                if viewModel.product.imageUrl.isEmpty {
                    Image(uiImage: viewModel.image!)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                } else {
                    Image(viewModel.product.imageUrl)
                        .resizable()
                        .frame(maxWidth: .infinity, maxHeight: 300)
                }
                HStack {
                    Text("\(viewModel.product.title)").font(.title2.bold())
                    Spacer()
                    Text("\(viewModel.getPrice(size: self.size)) ₽").font(.title2)
                }.padding(.horizontal, 20)

                Text("\(viewModel.product.descript)")
                    .padding(.horizontal)
                    .padding(.top, 8)

                Picker("Размер пиццы", selection: $size) {
                    ForEach(Sizes.allCases, id: \.self) { item in
                        Text(item.rawValue)
                    }
                }.pickerStyle(.segmented)
                    .padding()

                Stepper("Количество \(self.count)", value: $count, in: 1...10)
                    .padding(.horizontal, 84)
                    .padding(.vertical)
            }
            Spacer()
            Button {
                print("Добавить в корзину")

                var position = Position(product: viewModel.product, id: UUID().uuidString, count: self.count)
                position.product.price = viewModel.getPrice(size: self.size)

                CartViewModel.shared.addPosition(position)

                if #available(iOS 15, *) {
                    self.dismiss()
                } else {
                    self.presentationMode.wrappedValue.dismiss()
                }

            } label: {
                Text("Добавить в корзину")
            }.foregroundColor(Color("darkOrange")).font(.title3).bold()
                .frame(width: 250, height: 50)
                .background(LinearGradient(colors: [Color("yellow"), Color("orange")], startPoint: .leading, endPoint: .trailing))
                .cornerRadius(30)

            Spacer()
        }.onAppear {
            viewModel.getImage()
        }
    }
}

struct ProductDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ProductDetailView(viewModel: ProductDetailViewModel(product: Product(id: "1", title: "Пицца", imageUrl: "pizzaPlaceholder", price: 370, descript: "вкусная пицца")), size: .small)
    }
}
