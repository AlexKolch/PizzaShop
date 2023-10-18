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

    @StateObject var profileViewModel: ProfileViewModel
    
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
                    TextField("Имя", text: $profileViewModel.userProfile.name).font(.body.bold())
                    HStack {
                        Text("+7")
                        TextField("Телефон", value: $profileViewModel.userProfile.phoneNumber, format: .number)
                    }
                }
            }.padding()

            VStack(alignment: .leading, spacing: 8) {
                Text("Адрес доставки: ").bold()
                TextField("Ваш адрес", text: $profileViewModel.userProfile.address)
            }.padding(.horizontal)

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
                .fullScreenCover(isPresented: $isAuthViewPresented) {
                    AuthView()
                }

        }
        //On Submit
        .onSubmit {
            print("On Submit: Было редактирование")
            profileViewModel.setProfile()
        }
        .onAppear {
            self.profileViewModel.getProfile()
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(profileViewModel: ProfileViewModel(userProfile: UserModel(id: "",
                                                                 name: "Вася Иванов",
                                                                 phoneNumber: 45658568568,
                                                                 address: "Хрен доедешь")))
    }
}
