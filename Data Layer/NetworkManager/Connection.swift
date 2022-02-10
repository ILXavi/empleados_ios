//
//  Login.swift
//  Empleados
//
//  Created by Javier Eduardo Rodriguez Ardila on 10/2/22.
//

import Foundation
import UIKit


final class Connection {
    
    let baseUrl = "http://localhost/empleados-app/public/api/"
        
    func connect(to endpoint: String, params: [String: Any]?, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: baseUrl+endpoint) else {
            completion(nil)
            return
        }
        
        var urlRequest = URLRequest(url: url, timeoutInterval: 10)
        
        if let params = params {
            guard let paramsData = try? JSONSerialization.data(withJSONObject: params, options: []) else{
                completion(nil)
                return
            }
            
            urlRequest.httpMethod = "POST"
            urlRequest.httpBody = paramsData
        }
        
        let headers = [
            "Content_Type": "application/json",
            "Accept":       "application/json"
        ]
        
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.httpAdditionalHeaders = headers
        
        let urlSession = URLSession(configuration: sessionConfiguration)
        
        let networkTask = urlSession.dataTask(with: urlRequest) {
            data, response, error in
            
            let httpResponse = response as! HTTPURLResponse
            
            print("HTTP Status code: \(httpResponse.statusCode)")
            
            guard error == nil else {
                completion(nil)
                return
            }
            
            completion(data)
        }
        
        networkTask.resume()
    }
}
