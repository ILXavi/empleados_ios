//
//  Response.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 10/2/22.
//

import Foundation

struct Response: Codable {
    var status : Int
    var msg : String
    var resp : [Employee]?
}
