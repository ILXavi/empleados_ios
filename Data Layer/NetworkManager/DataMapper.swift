//
//  NetworkManager.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 10/2/22.
//

import Foundation
import UIKit


final class DataMapper {
    
    static let shared = DataMapper()
    private init() {}
    
    // Endpoints
    var loginUrl = "login"
    var listUrl = "users/listEmployees"
    var profileUrl = "users/profile"
    var recoverPassUrl = "users/recoverPassword"
    
    
    
    func login(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        Connection().connect(to: loginUrl, params: params, requestType: "POST") {
            data in
            
            guard let data = data else {
                // Preparas error y retornas
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    completion(response)
                }
            } catch {
                completion(nil)
            }
        }
        
    }
    
    func recoverPassword(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        Connection().connect(to: recoverPassUrl, params: params, requestType: "POST") {
            data in
            
            guard let data = data else {
                // Preparas error y retornas
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    completion(response)
                }
            } catch {
                completion(nil)
            }
        }
        
    }
    
    
    
    
    func list(params: [String: Any], completion: @escaping (Response?) -> Void) {
        Connection().connect(to: listUrl, params: params, requestType: "POST") {
            data in
            
            guard let data = data else {
                // Preparas error y retornas
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    completion(response)
                }
            } catch {
                completion(nil)
            }
        }
        
    }
    
    
    func getProfile(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        Connection().connect(to: profileUrl, params: params, requestType: "POST") {
            data in
            
            guard let data = data else {
                // Preparas error y retornas
                completion(nil)
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(Response.self, from: data)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2){
                    completion(response)
                }
            } catch {
                completion(nil)
            }
        }
        
    }
    
    
}
