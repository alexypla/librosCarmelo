//
//  Book.swift
//  ApiLibreria
//
//  Created by dam on 20/2/19.
//  Copyright © 2019 dam. All rights reserved.
//

import Foundation

class Book:Codable {
    var id:String?
    var nombre:String
    var autor:String?
    var editorial:String
    var isbn:String
    var ejemplares:String
    var precio:String
    var edicion:String

    
    init(nombre:String,isbn:String){
        self.id=""
        self.nombre=nombre
        self.isbn=isbn
        self.autor=""
        self.editorial=""
        self.ejemplares=""
        self.precio=""
        self.edicion=""
    }
    
    
    func toArray()->[String:String]{
        var result = [String:String]()
        result["id"] = id
        result["nombre"] = nombre
        result["edicion"] = edicion
        result["isbn"] = isbn
        result["ejemplares"] = ejemplares
        result["precio"] = precio
        result["autor"] = autor
        result["editorial"] = editorial
        return result
    }
}
