//
//  RestClient.swift
//  HTTPRequest
//
//  Created by dam on 31/1/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class ApiRest{
    static let urlw: String = "https://libreria-placidojrc.c9users.io/"
    static let urlApi: String = "\(urlw)apislim/"
    let callback: (_ data:Data)->Void
    var urlPeticion: URLRequest
    
    init?(service: String, callback: @escaping (_ data:Data)->Void, _ extra_headers : [String:String] = [:], _ method: String = "GET", _ data : [String:Any] = [:]) {
        guard let url = URL(string: ApiRest.urlApi + service) else {
            return nil
        }
        self.callback = callback
        self.urlPeticion = URLRequest(url: url)
        self.urlPeticion.httpMethod = method
        self.urlPeticion.addValue("application/json",
                                  forHTTPHeaderField: "Content-Type")
        self.urlPeticion.addValue("application/json",
                                  forHTTPHeaderField: "Accept")
        
        if (extra_headers.count>0) {
            for key in extra_headers.keys {
                if let value = extra_headers[key]{
                    self.urlPeticion.addValue(value, forHTTPHeaderField: key)
                }
            }
        }
        
        if method != "GET" && data.count > 0 {
            guard let json = Utils.dictToJson(data: data) else {
                return nil
            }
            self.urlPeticion.httpBody = json
        }
    }
    
    func request() {
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = 15.0
        sessionConfig.timeoutIntervalForResource = 60.0
        let sesion = URLSession(configuration: sessionConfig)
        let task = sesion.dataTask(with: self.urlPeticion,
                                   completionHandler: self.callBack)
        task.resume()
    }
    
    private func callBack(_ data: Data?, _ respuesta: URLResponse?, _ error: Error?) {
        DispatchQueue.main.async {
            guard error == nil else {
                self.callback("{\"status\":600,\"msg\":\"Error request\",\"token\":null".data(using: String.Encoding.utf8)!)
                return
            }
            guard let datos = data else {
                self.callback("{\"status\":601,\"msg\":\"Error data\",\"token\":null".data(using: String.Encoding.utf8)!)
                return
            }
            self.callback(datos)
        }
    }
}
