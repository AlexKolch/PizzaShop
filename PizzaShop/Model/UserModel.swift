//
//  UserModel.swift
//  PizzaShop
//
//  Created by Алексей Колыченков on 18.10.2023.
//

import Foundation

struct UserModel: Identifiable {
    var id: String
    var name: String
    var phoneNumber: Int
    var address: String

    var representation: [String : Any] {

        var repres = [String : Any]()
        repres["id"] = self.id
        repres["name"] = self.name
        repres["phone"] = self.phoneNumber
        repres["address"] = self.address
        
        return repres
    }
}
