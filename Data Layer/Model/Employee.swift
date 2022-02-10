//
//  Employee.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 8/2/22.
//

import Foundation

//struct Response : Codable {
//    var status : Int
//    var msg : String
//    var listado : [Employee]?
//}

struct Employee: Codable {
    var id: Int = -1
    var name: String
    var email: String
    var password: String
//    var job: String {
//        didSet {
//            jobType = JobType(rawValue: job)
//        }
//    }
//    var jobType: JobType?
//    var job: JobType?
    var job: String
    var salary: Int
    var biography: String
    var api_token: String
}

