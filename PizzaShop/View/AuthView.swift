//
//  ContentView.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 13.10.2023.
//

import SwiftUI

struct AuthView: View {
    @State private var isAuth = true
    @State private var email = ""
    @State private var password = ""
    @State private var repeatPassword = ""
    @State private var isTabViewShow = false
    @State private var isAlertShow = false
    @State private var alertMessage = ""

    var body: some View {
        VStack(spacing: 20.0) {
            Text(isAuth ? "Авторизаця" : "Регистрация")
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

                if !isAuth {
                        SecureField("Повторите пароль", text: $repeatPassword)
                            .padding()
                            .background(Color.white.opacity(0.7))
                            .cornerRadius(12)
                            .padding(6)
                            .padding(.horizontal, 20)
                }

                Button {
                    if isAuth {
                        print("Авторизация пользователя через Firebase")

                        AuthServices.shared.signIn(email: self.email, password: self.password) { result in
                            switch result {
                            case .success(_):
                                self.isTabViewShow.toggle()
                            case .failure(let error):
                                alertMessage = "Ошибка авторизации: \(error.localizedDescription)"
                                self.isAlertShow.toggle()
                            }
                        }
                    } else {
                        ///Проверка повторного пароля
                        guard password == repeatPassword else {
                            self.alertMessage = "Пароли не совпадают!"
                            self.isAlertShow.toggle()
                            return
                        }

                        AuthServices.shared.signUp(email: self.email, password: self.password) { result in
                            switch result {
                            case .success(let user):

                                alertMessage = "Вы зарегистрировались с email: \(user.email!)"
                                self.isAlertShow.toggle()
                                print("Регистрация пользователя")
                                self.email = ""
                                self.password = ""
                                self.repeatPassword = ""
                                self.isAuth.toggle()

                            case .failure(let error):

                                alertMessage = "Ошибка регистрации: \(error.localizedDescription)"
                                self.isAlertShow.toggle()
                            }
                        }
                    }
                } label: {
                    Text(isAuth ? "Войти" : "Создать аккаунт")
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
                    isAuth.toggle()
                } label: {
                    Text(isAuth ? "Еще не с нами?" : "Есть аккаунт!")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .padding(6)
                        .padding(.leading, 100)
                        .font(.title3.bold())
                        .foregroundColor(Color("darkOrange"))
                }

            }.padding().padding(.top, 16).background(Color.secondary.opacity(0.5))
                .cornerRadius(24)
                .padding(isAuth ? 30 : 16)
                .alert(alertMessage, isPresented: $isAlertShow) {
                    Button { } label: {
                        Text("Ok")
                    }
                }

        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Image("bg")
                .blur(radius: isAuth ? 0 : 8))
            .animation(.easeInOut(duration: 0.3), value: isAuth)
            .fullScreenCover(isPresented: $isTabViewShow) {
                //Проверка что заходит Админ
                if AuthServices.shared.currentUser?.uid == "qVZgSFB1uSazDM07HTsr5Bq7S0K2" {
                    AdminOrdersView()
                } else {
                    let mainTabBarViewModel = MainTabBarViewModel(user: AuthServices.shared.currentUser!)
                    MainTabBar(viewModel: mainTabBarViewModel)
                }
            }
    }
}

struct AuthView_Previews: PreviewProvider {
    static var previews: some View {
        AuthView()
    }
}
