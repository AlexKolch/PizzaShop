//
//  PromotionCell.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 17.11.2023.
//

import SwiftUI

struct PromotionCell: View {
    var product: Product
    @State var uiImage = UIImage(named: "pizzaPlaceholder")

    var body: some View {
        VStack(spacing: 3.0) {
            Image(uiImage: uiImage!)
                .resizable()
                .scaledToFill()
                .frame(minWidth: screen.width * 0.45)
                .clipped()

            HStack {
                Text(product.title)
                    .font(.custom("AvenirNext-regular", size: 12))
                Spacer()
                Text("\(product.price) ₽")
                    .font(.custom("AvenirNext-bold", size: 12))
            }.padding(.horizontal, 8)
                .padding(.bottom, 10)

        }.frame(width: screen.width * 0.45, height: screen.height * 0.35)
            .background(Color.white)
            .cornerRadius(16)
            .shadow(radius: 4)
            .onAppear {
                //Загружаем картинки из Storage
                StorageService.shared.downloadProductImage(id: self.product.id) { result in
                    switch result {
                    case .success(let data):
                        if let image = UIImage(data: data) {
                            self.uiImage = image
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
    }
}

struct PromotionCell_Previews: PreviewProvider {
    static var previews: some View {
        PromotionCell(product: Product(id: "1", title: "Пицца", imageUrl: "_", price: 370, descript: "вкусная пицца"))
    }
}
