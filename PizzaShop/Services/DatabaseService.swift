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
    private var ordersRef: CollectionReference {
        return database.collection("orders")
    }

    private init() { }

    ///Записать заказ в БД
    func setOrder(order: Order, completion: @escaping (Result<Order, Error>) -> ()) {
        ordersRef.document(order.id).setData(order.representation) { error in
            if let error {
                completion(.failure(error))
            } else {
                self.setPositions(to: order.id, positions: order.positions) { result in
                    switch result {
                    case .success(let positions):
                        print("Добавлена/о \(positions.count) позиция/ий")
                        completion(.success(order)) //Добавляем заказ после успешного добавления всех позиций
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    ///Устанавить позиции а заказ
    func setPositions(to orderId: String,
                      positions: [Position],
                      completion: @escaping (Result<[Position], Error>) -> ()) {

        let positionRef = ordersRef.document(orderId).collection("positions") //реф на позиции которые будут внутри ordersRef

        for position in positions {
            positionRef.document(position.id).setData(position.representation) //Запись в реф данных по каждой позиции
        }

        completion(.success(positions))
    }

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
