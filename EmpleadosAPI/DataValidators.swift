//
//  DataValidators.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 20/11/23.
//

import Foundation

struct Validators {
    static let shared = Validators()
    
    // Función para que no evalue el valor de inicio.Recibe un valor y devuelve un opcional.Retorna siempre nil.
    func noValidate(_ value: String) -> String? {
        return nil
    }
    
    // Función para validar si el campo está vacio
    func isEmpty(_ value: String) -> String? {
        // Si el campo está vacío, devuelve "cannot be empty" sino, devuelve nil
        value.isEmpty ? "cannot be empty" : nil
    }
    // Función para validar el email.
    func validEmail(_ value: String) -> String? {
        let emailRegex = #"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.){3}(?:25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])"#
        do {
            let regex = try Regex(emailRegex)
            if let _ = try regex.wholeMatch(in: value) {
                return nil
            } else {
                return "is not a valid email."
            }
        } catch {
            return "is not a valid email."
        }
    }
    // Función para validar que hay que escribir más de 4 caracteres y también que valide que el campo no esté vacío.
    func greatherThan4(_ value: String) -> String? {
        var msg = ""
        if let err = isEmpty(value) {
            msg += err
        }
        if value.count < 4 {
            if msg.isEmpty {
                msg = "must be greather than 4 characters."
            } else {
                msg = "\(msg.dropLast()) and must be greather than 4 characters."
            }
        }
        if msg.isEmpty {
            return nil
        } else {
            return msg
        }
    }
}


 

 

 

