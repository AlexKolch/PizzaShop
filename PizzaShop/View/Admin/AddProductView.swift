//
//  AddProductView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 16.11.2023.
//

import SwiftUI

struct AddProductView: View {
    @State private var showImagePicker: Bool = false
    @State private var image = UIImage(named: "bg")! // Сюда отправляем картинку из пикера
    @State private var titleProductTF: String = ""
    @State private var priceProductTF: Int? = nil
    @State private var desciptProductTF: String = ""

    var body: some View {
        VStack {
            Text("Добавить товар").font(.title2.bold())
            Image(uiImage: image)
                .resizable()
                .frame(width: .infinity, height: .infinity)
                .aspectRatio(contentMode: .fit)
                .onTapGesture {
                    showImagePicker.toggle()
                }.sheet(isPresented: $showImagePicker) {
                    ImagePicker(selectedImage: $image)
            }
            VStack(spacing: 12.0) {
                TextField("Название продукта", text: $titleProductTF)
                TextField("Цена продукта", value: $priceProductTF, format: .number).keyboardType(.numberPad)
                TextField("Описание продукта", text: $desciptProductTF)

            }.padding()

            Button {
                print("Сохранить")
            } label: {
                Text("Сохранить")
                    .padding()
            }

        }
    }
}

struct AddProductView_Previews: PreviewProvider {
    static var previews: some View {
        AddProductView()
    }
}
