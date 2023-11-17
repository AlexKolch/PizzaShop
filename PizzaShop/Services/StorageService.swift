//
//  StorageService.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 16.11.2023.
//

import Foundation
import FirebaseStorage

final class StorageService {
    static let shared = StorageService()
    private let storage = Storage.storage().reference() //ссылка на Storage
    private var productsRef: StorageReference { storage.child("products") } //Ссылка на папку где хранятся фото продуктов

    private init() {}

    ///Загрузка картинки в Хранилище Storage
    func upload(id: String, image: Data, completion: @escaping (Result<String, Error>) -> ()) {
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpg"

        //загружаем картинки по id продукта
        productsRef.child(id).putData(image, metadata: metadata) { metadata, error in
            guard let metadata else {

                if let error {
                    completion(.failure(error))
                }

                return
            }
            completion(.success("Размер полученного изображения \(metadata.size)"))
        }
    }

    ///Загрузить картинку из Storage
    func downloadProductImage(id: String, completion: @escaping (Result<Data, Error>) -> ()) {
        productsRef.child(id).getData(maxSize: 2*1024*1024) { data, error in
            guard let data else {
                if let error {
                    completion(.failure(error))
                }
                return
            }
            completion(.success(data))
        }
    }
}
