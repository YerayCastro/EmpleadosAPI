//
//  URLRequest.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 19/11/23.
//

import Foundation

/*:
 2ª capa. Aquí van las peticiones que voy a usar. 
 */

// Extensión de URLRequest
extension URLRequest {
    // Función del método get
    static func get(url: URL) -> URLRequest {
        // Creo la variable request
        var request = URLRequest(url: url)
        // Intervalo del  tiempo de respuesta del servidor.
        request.timeoutInterval = 60
        // Método del request, pongo el tipo, pero si no lo pones por defecto es GET
        request.httpMethod = "GET"
        // Añadir un valor de cabecera. setValue fija el valor que le damos aunque exista cabecera.
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        // Devuelvo el request
        return request
    }
    // Función del método post. Siempre usa un fichero JSON
    static func post<JSON>(url: URL, data: JSON, method: String = "POST") -> URLRequest where JSON: Codable {
        // Creo la variable request
        var request = URLRequest(url: url)
        request.timeoutInterval = 60
        request.httpMethod = method
        request.setValue("application/json; charset=utf8", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.httpBody = try? JSONEncoder().encode(data)
        // Devuelvo request
        return request
    }
    
}
