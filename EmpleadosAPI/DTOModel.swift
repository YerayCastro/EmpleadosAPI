//
//  DTOModel.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 16/11/23.
//
/*:
 1ª capa. Model.
 DTO -> Data transfer Object -> Patrón de diseño, que se basa en que los datos que recibo de la Api, no son los mismos que voy a usar en mi aplicación. Es buena practica separar los modelos.
 */
import Foundation

// Obligatorio que sea de tipo Codable.
struct DTOEmpleado: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let username: String
    let email: String
    let address: String
    let zipcode: String
    let avatar: String
    
    struct Gender: Codable {
        let id: Int
        let gender: GenderType
    }
    let gender: Gender
    
    struct Department: Codable {
        let id: Int
        let name: DptoName
    }
    let department: Department
}

// Creo una extensión de DTOEmpleado con una variable calculada(toPresentation) que lo que va a hacer es transformar la instancia de DTOEmpleado, en una instancia de Empleado
extension DTOEmpleado {
    var toPresentation: Empleado {
        Empleado(id: id,
                 firstName: firstName,
                 lastName: lastName,
                 username: username,
                 email: email,
                 address: address,
                 zipcode: zipcode,
                 avatar: URL(string: avatar),
                 gender: gender.gender,
                 department: department.name)
    }
}

struct EmpleadosUpdate: Codable {
    var id: Int
    var username: String?
    var firstName: String?
    var lastName: String?
    var email: String?
    var address: String?
    var avatar: String?
    var zipcode: String?
    var department: String?
    var gender: String?
}
