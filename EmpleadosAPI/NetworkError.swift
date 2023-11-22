//
//  NetworkError.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 19/11/23.
//

import Foundation

/*:
 2ª capa. Gestión de errores
 */

public enum NetworkError: Error, CustomStringConvertible {
    case general(Error)
    case status(Int)
    case noContent
    case json(Error)
    case unknown
    case noHTTP
    
    // Variable calculada, para devolver una descripción en los errores.
    public var description: String {
        switch self {
        case .general(let error):
            "Error general: \(error.localizedDescription)"
        case .status(let int):
            "Error de status: \(int)"
        case .noContent:
            "El contenido no se corresponde con lo esperado"
        case .unknown:
            "Error desconocido"
        case .noHTTP:
            "No es una llamada HTTP"
        case .json(let error):
            "Error en el JSON: \(error)"
        }
    }
}
