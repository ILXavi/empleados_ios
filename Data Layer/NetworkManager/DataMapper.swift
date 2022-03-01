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
    var registerUrl = "users/registerUser"
    var editProfileUrl = "users/editProfile"
    
    
//    Función para lanzar la peticion de login a la API
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
    
    //    Función para lanzar la peticion de registro a la API
    func register(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        Connection().connect(to: registerUrl, params: params, requestType: "PUT") {
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
    
    //    Función para lanzar la peticion de editar empleado a la API
    func editProfile(params: [String: Any]?, completion: @escaping (Response?) -> Void) {
        Connection().connect(to: editProfileUrl, params: params, requestType: "PUT") {
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
    
    //    Función para lanzar la peticion de recuperar contraseña a la API (Se envia al correo la nueva contraseña)
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
    
    
    
    //    Función para solicitar el listado de empleados
    func list(params: [String: Any], completion: @escaping (Response?) -> Void) {
        Connection().connect(to: listUrl, params: params, requestType: "POST") {
            data in
            
            guard let data = data else {
                // Preparas error y retornas
                completion(nil)
                return
            }
            
            #if DEBUG
            let jsonString = String(data: data, encoding: .utf8)
            print("RESPONSE: \n\(jsonString ?? "NO JSON STRING")")
            #endif
            
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
    
    //    Función para lanzar la peticion de obtener el perfil
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
