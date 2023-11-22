//
//  EnumFields.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 21/11/23.
//

import Foundation

// Enum para quitar el teclado en los campos que tienen foco.
enum EmpleadosField {
    case firstName
    case lastName
    case address
    case zipcode
    case email
    case username
    
    // Función para que el foco salte al siguiente campo.
    mutating func next() {
        switch self {
        case .firstName:
            self = .lastName
        case .lastName:
            self = .address
        case .address:
            self = .zipcode
        case .zipcode:
            self = .email
        case .email:
            self = .username
        case .username:
            self = .firstName
        }
    }
    
    // Función para que el foco salte al anterior campo
    mutating func prev() {
        switch self {
        case .firstName:
            self = .username
        case .lastName:
            self = .firstName
        case .address:
            self = .lastName
        case .zipcode:
            self = .address
        case .email:
            self = .zipcode
        case .username:
            self = .email
        }
    }
}
