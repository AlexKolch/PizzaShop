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

    private var currentUser: User? {
        return auth.currentUser //Возвращает юзера
    }

///Регистрация пользователя
    func signUp(email: String,
                password: String,
                completion: @escaping (Result<User, Error>) -> Void) {

        auth.createUser(withEmail: email, password: password) { result, error in

            if let result {
                completion(.success(result.user)) //Юзер из базы данных приходит
            } else if let error {
                completion(.failure(error))
            }
        }
    }
}
