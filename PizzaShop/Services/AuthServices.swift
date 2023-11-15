//
//  AuthServices.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 17.10.2023.
//

import Foundation
import FirebaseAuth

class AuthServices {
    static let shared = AuthServices()

    private init() {}

    private let auth = Auth.auth() //Ссылка на авторизацию в сервисе

    var currentUser: User? {
        return auth.currentUser //Возвращает юзера
    }

    ///Регистрация пользователя
    func signUp(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {
        
        auth.createUser(withEmail: email, password: password) { result, error in

            if let result {
                let newUser = UserModel(id: result.user.uid, //в id передаем id из БД
                                        name: "",
                                        phoneNumber: 8,
                                        address: "") //берем нового юзера и кладем в БД

                DatabaseService.shared.setUser(user: newUser) { resultDB in
                    switch resultDB {

                    case .success(_):
                        completion(.success(result.user)) //Зареганный юзер из БД

                    case .failure(let failure):
                        completion(.failure(failure))
                    }
                }
            } else if let error {
                completion(.failure(error))
            }
        }
    }

    ///Авторизация пользователя
    func signIn(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {

        auth.signIn(withEmail: email, password: password) { result, error in
            if let result {
                completion(.success(result.user))
            } else if let error {
                completion(.failure(error))
            }
        }
    }

    ///Выход пользователя
    func signOut() {
       try! auth.signOut()
    }
}
