//
//  ContentView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 13.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var email = ""
    @State private var password = ""

    var body: some View {
        VStack(spacing: 20.0) {
            Text("Авторизаця")
                .padding()
                .padding(.horizontal, 30)
                .font(.title2.bold())
                .background(Color.white.opacity(0.7))
                .cornerRadius(30)

            VStack {
                TextField("Введите Email", text: $email)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(12)
                    .padding(6)
                    .padding(.horizontal, 20)

                SecureField("Введите пароль", text: $password)
                    .padding()
                    .background(Color.white.opacity(0.7))
                    .cornerRadius(12)
                    .padding(6)
                    .padding(.horizontal, 20)

                Button {
                    print("Авторизация")
                } label: {
                    Text("Войти")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(LinearGradient(colors: [Color("yellow"), Color("orange")], startPoint: .bottomLeading, endPoint: .topTrailing))
                        .cornerRadius(12)
                        .padding(6)
                        .padding(.horizontal, 20)
                        .font(.title3.bold())
                        .foregroundColor(.black)
                }

                Button {
                    print("Еще не с нами?")
                } label: {
                    Text("Еще не с нами?")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .padding(6)
                        .padding(.leading, 100)
                        .font(.title3.bold())
                        .foregroundColor(Color("darkOrange"))
                }

            }.padding().padding(.top, 16).background(Color.secondary.opacity(0.5))
                .cornerRadius(24)
                .padding(30)

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("bg"))





    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
