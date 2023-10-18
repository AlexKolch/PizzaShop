//
//  DatabaseService.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 18.10.2023.
//

import Foundation
import FirebaseFirestore

class DatabaseService {
    static let shared = DatabaseService()

    private let database = Firestore.firestore() //Ссылка на базу данных
    private var userRef: CollectionReference { //ссылка на коллекцию наших юзеров
        return database.collection("users")
    }

    private init() { }

    ///Записать юзера в БД
    func setUser(user: UserModel, completion: @escaping (Result<UserModel, Error>) -> ()) {

        userRef.document(user.id).setData(user.representation) { error in
            if let error {
                completion(.failure(error))
            } else {
                completion(.success(user))
            }
        }
    }

    ///Получить юзера из БД
    func getUser(completion: @escaping (Result<UserModel, Error>) -> ()) {

        userRef.document(AuthServices.shared.currentUser!.uid).getDocument { docSnapshot, error in
            guard let data = docSnapshot?.data() else { return }

            guard let userName = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let phone = data["phone"] as? Int else { return }
            guard let address = data["address"] as? String else { return }

            let user = UserModel(id: id, name: userName, phoneNumber: phone, address: address)

            completion(.success(user)) //Возвращает юзера
        }
    }
}
