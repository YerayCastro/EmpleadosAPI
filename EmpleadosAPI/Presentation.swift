//
//  Presentation.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 17/11/23.
//

import Foundation

/*:
 1ª capa. Modelo de presentación.(Este es el que muestra los datos por pantalla) Va a transformar el modelo DTO, en algo que me sea más útil. Tiene que ser Identifiable, para poder hacer enumeración. Y tiene que ser Hashable, para poder hacer el maestro detalle y para que puedan ser comparados por igualdad.
 */

struct Empleado: Identifiable, Hashable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let address: String
    let zipcode: String
    let avatar: URL?
    let gender: GenderType
    let department: DptoName
}

extension Empleado {
    var fullname: String {
        "\(lastName), \(firstName)"
    }
    
    var toUpdate: EmpleadosUpdate {
        EmpleadosUpdate(id: id,
                        username: username,
                        firstName: firstName,
                        lastName: lastName,
                        email: email,
                        address: address,
                        avatar: avatar?.absoluteString,
                        zipcode: zipcode,
                        department: department.rawValue,
                        gender: gender.rawValue)
    }
}
