//
//  Job.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 8/2/22.
//

import Foundation
import UIKit

//struct Job {
//
//    var name: String
//}
//
//let jobs = [
//    Job(name: "---Selecciona---"),
//    Job(name: "Direccion"),
//    Job(name: "RRHH"),
//    Job(name: "Empleado")
//]


enum JobType: String, CaseIterable, Codable {
    case direction = "Dirección"
    case rrhh = "RRHH"
    case employee = "Empleado"
}

//let jobtype = JobType(rawValue: "RRHH")

//jobtype?.rawValue tomar el valor string asociado a al enum

//JobType.allCases para pntar
