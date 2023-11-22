//
//  Model.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 16/11/23.
//

import Foundation

/*:
 1ª capa Model. Este es el modelo conjunto.
 */

enum DptoName: String, Codable, CaseIterable, Identifiable {
    case accounting = "Accounting"
    case businessDevelopment = "Business Development"
    case engineering = "Engineering"
    case humanResources = "Human Resources"
    case legal = "Legal"
    case marketing = "Marketing"
    case productManagement = "Product Management"
    case researchAndDevelopment = "Research and Development"
    case sales = "Sales"
    case services = "Services"
    case support = "Support"
    case training = "Training"
    
    // Creo la variable calculada id, para que se ajuste al protocolo Identifiable. Esta variable nos va a devolver la id. La variable id, es de tipo Self, y nos devuelve self. (Self: es la referencia al tipo de dato.)(self: es la referencia al valor)
    var id: Self { self }
}

enum GenderType: String, Codable, CaseIterable, Identifiable {
    case female = "Female"
    case male = "Male"
    
    // Creo la variable calculada id, para que se ajuste al protocolo Identifiable. Esta variable nos va a devolver la id. La variable id, es de tipo Self, y nos devuelve self. (Self: es la referencia al tipo de dato.)(self: es la referencia al valor)
    var id: Self { self }
}


// Enumeración para el botón de Sorted by, para elegir el tipo
enum SortType: String, CaseIterable, Identifiable {
    case ascendent = "Ascendent"
    case descendent = "Descendent"
    case byID = "By ID"
    
    var id: Self { self }
}


