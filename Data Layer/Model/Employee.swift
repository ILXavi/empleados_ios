//
//  Employee.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 8/2/22.
//

import Foundation

struct Employee: Codable {
    var id: Int?
    var name: String?
    var email: String?
    var password: String?
    var job: String?
    var salary: Float?
    var biography: String?
    var api_token: String?
}


