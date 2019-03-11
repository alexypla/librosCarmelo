//
//  API.swift
//  ApiLibreria
//
//  Created by dam on 20/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class API{

    
    init(){
    }
    
    private func getData(data:Data)->String{
        var dataStr : String = String(data: data, encoding: String.Encoding.utf8)!
        let start = dataStr.range(of: "\"data\":")?.upperBound
        let end = String.Index(encodedOffset: dataStr.endIndex.encodedOffset-1)
        dataStr = String(dataStr[start!..<end])
        return dataStr
    }

    
    func addBook(book: Book, callback: @escaping (_ data: String,_ error:String) -> Void){
        guard let cliente = ApiRest(service: "libro",callback: {
            (data: Data) in {
                print(data)
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    if (dic["status"] as! Int==201){
                        callback(dic["data"] as! String,"")
                    }
                    else
                    {
                        callback("","\(String(describing: dic["msg"]!))");
                    }
                }
                catch {
                    callback("","Error critico al entender los datos");
                }
            }()
        },[:],"POST",book.toArray()) else {
            callback("","Error critico al iniciar petición");
            return
        }
        cliente.request()
    }
    
    func updateBook(book: Book, callback: @escaping (_ data: String,_ error:String) -> Void){
        guard let cliente = ApiRest(service: "libro",callback: {
            (data: Data) in {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    if (dic["status"] as! Int==202){
                        callback("OK","")
                    }
                    else
                    {
                        callback("","\(String(describing: dic["msg"]!))")
                    }
                }
                catch {
                    callback("","Error critico al entender los datos1")
                }
            }()
        },[:],"PUT",book.toArray()) else {
            callback("","Error critico al iniciar petición")
            return
        }
        cliente.request()
    }
    
 
    func getBooks(callback: @escaping (_ data:[Book],_ error:String) -> Void){
        guard let cliente = ApiRest(service: "libro",callback: {
            (data: Data) in {
                print("lol")
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(dic)
                    if (dic["status"] as! Int==200){
                        let dataStr = self.getData(data: data)
                        print(dataStr)
                        let deco = JSONDecoder()
                        do{
                            let libros = try deco.decode([Book].self, from: dataStr.data(using: String.Encoding.utf8)!)
                            callback(libros,"")
                        }
                        catch {
                            callback([],"Error al entender los datos")
                        }
                    }
                    else{
                        callback([],"\(String(describing: dic["msg"]!))");
                    }
                }
                catch {
                    callback([],"Error critico al entender los datos");
                }
            }()
        }) else {
            callback([],"Error critico al iniciar petición");
            return
        }
        cliente.request()
    }
    func deleteBook(id:String,callback: @escaping (_ data:String,_ error:String) -> Void){
        guard let cliente = ApiRest(service: "libro/\(id)",callback: {
            (data: Data) in {
                do {
                    let dic = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    
                    if (dic["status"] as! Int==200){
                        callback("OK","")
                    }
                    else{
                        callback("","\(String(describing: dic["msg"]!))");
                    }
                }
                catch {
                    callback("","Error critico al entender los datos");
                }
            }()
        },[:],"DELETE") else {
            callback("","Error critico al iniciar petición");
            return
        }
        cliente.request()
    }
}
