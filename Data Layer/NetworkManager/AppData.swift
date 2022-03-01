//
//  AppData.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 11/2/22.
//

import Foundation

class AppData {
    static let shared = AppData()
    var apiToken: String = ""
    var employees: [Employee]=[]
    var profile: [Employee]=[]
    var selectedEmployee : Employee?
       
}
