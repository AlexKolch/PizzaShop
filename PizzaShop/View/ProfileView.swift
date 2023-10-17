//
//  ProfileView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 14.10.2023.
//

import SwiftUI

struct ProfileView: View {

    @State private var isAvatarPresented = false
    @State private var isQuitAlertPresented = false
    @State private var isAuthViewPresented = false
    
    var body: some View {

        VStack(alignment: .center, spacing: 20.0) {
            HStack(spacing: 16.0) {
                Image("user").resizable()
                    .frame(width: 80, height: 80)
                    .background(Color("userBG"))
                    .clipShape(Circle())
                    .onTapGesture {
                        isAvatarPresented.toggle()
                    }
                    .confirmationDialog("Откуда взять фото", isPresented: $isAvatarPresented) {
                        Button {
                            print("Gallery")
                        } label: {
                            Text("Из галереи")
                        }

                        Button {
                            print("Camera")
                        } label: {
                            Text("С камеры")
                        }
                    }

                VStack(alignment: .leading, spacing: 10.0) {
                    Text("Мирослав Филиппецкий").bold()
                    Text("+7 (999) 111-22-33")
                }
            }
            VStack(alignment: .leading, spacing: 8) {
                Text("Адрес доставки: ").bold()
                Text("Россия, Московская область, г. Нижний Уренгой, ул, Юных Юннатов, д. 35, кв. 18")
            }

            //Таблица с заказами
            List {
                Text("ваши заказы будут тут!")
            }
            //Кнопка выхода из аккаунта
            Button {
                isQuitAlertPresented.toggle()
            } label: {
                Text("Выйти")
            }.padding(.bottom)
                .confirmationDialog("Действительно хотите выйти?", isPresented: $isQuitAlertPresented) {
                    Button {
                        isAuthViewPresented.toggle()
                    } label: {
                        Text("Да")
                    }
                }

        }.fullScreenCover(isPresented: $isAuthViewPresented) {
            AuthView()

        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
