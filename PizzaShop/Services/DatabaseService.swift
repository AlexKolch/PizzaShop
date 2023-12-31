//
//  DatabaseService.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 18.10.2023.
//

import Foundation
import FirebaseFirestore

final class DatabaseService {
    static let shared = DatabaseService()

    private let database = Firestore.firestore() //Ссылка на базу данных
    ///ссылка на коллекцию юзеров
    private var userRef: CollectionReference {
        return database.collection("users")
    }
    ///ссылка на коллекцию заказов
    private var ordersRef: CollectionReference {
        return database.collection("orders")
    }
    ///ссылка на коллекцию продуктов
    private var productsRef: CollectionReference {
        return database.collection("products")
    }

    private init() { }

    ///Получить заказы из БД
    func getOrders(by userID: String?, completion: @escaping (Result<[Order], Error>) -> ()) {
        self.ordersRef.getDocuments { qSnapshot, error in
            if let qSnapshot {
                var orders = [Order]()
                for doc in qSnapshot.documents {
                    if let userID = userID {
//Если userID получен, то получаем заказы только по этому userID
                        if let order = Order(doc: doc), order.userID == userID {
                            orders.append(order)
                        }
//Если без userID получаем все заказы из БД (ветка для админа)
                    } else {
                        if let order = Order(doc: doc) {
                            orders.append(order)
                        }
                    }
                }
                completion(.success(orders))
            } else if let error {
                completion(.failure(error))
            }
        }
    }

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

    ///Получить позиции в заказе
    func getPosiitions(by orderID: String, completion: @escaping (Result<[Position], Error>) -> ()) {

        let positionsRef = ordersRef.document(orderID).collection("positions") //референс на позиции в заказе

        positionsRef.getDocuments { qSnap, error in
            if let qSnap {
                var positions = [Position]()

                for doc in qSnap.documents {
                    if let position = Position(doc: doc) {
                        positions.append(position)
                    }
                }

                completion(.success(positions))
            } else if let error {
                completion(.failure(error))
            }
        }
    }

    ///Установить позиции в заказ
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
    func getUser(by userID: String? = nil, completion: @escaping (Result<UserModel, Error>) -> ()) {

        userRef.document(userID != nil ? userID! : AuthServices.shared.currentUser!.uid).getDocument { docSnapshot, error in
            guard let data = docSnapshot?.data() else { return }

            guard let userName = data["name"] as? String else { return }
            guard let id = data["id"] as? String else { return }
            guard let phone = data["phone"] as? Int else { return }
            guard let address = data["address"] as? String else { return }

            let user = UserModel(id: id, name: userName, phoneNumber: phone, address: address)

            completion(.success(user)) //Возвращает юзера
        }
    }

    ///Запись в БД нового продукта
    func setProduct(_ product: Product, image: Data, completion: @escaping (Result<Product, Error>) -> ()) {

        StorageService.shared.upload(id: product.id, image: image) { result in
            switch result {
            case .success(let sizeInfo):
                print(sizeInfo)

                self.productsRef.document(product.id).setData(product.representation) { error in
                    if let error {
                        completion(.failure(error))
                    } else {
                        completion(.success(product))
                    }
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
    
    ///Получить из БД продук
    func getProducts(completion: @escaping (Result<[Product], Error>) -> ()) {
        self.productsRef.getDocuments { querySnapshot, error in
            guard let querySnapshot else {
                if let error {
                    completion(.failure(error))
                }
                return
            }

            let docs = querySnapshot.documents
            var products = [Product]()

            for doc in docs {
                //Тут НУЖНО создать ПРОДУКТ через ДОКУМЕНТ (написать init через QueryDocumentSnapshot для Product)
                guard let product = Product(doc: doc) else {return}
                products.append(product)
            }
            completion(.success(products))
        }
    }
}
