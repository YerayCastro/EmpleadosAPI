//
//  EmpleadoEditVM.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 20/11/23.
//

import SwiftUI


// Para inyectarselo al EmpleadoEditView
final class EmpleadoEditVM: ObservableObject {
    let empleado: Empleado
    
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var address = ""
    @Published var zipcode = ""
    @Published var username = ""
    @Published var department = ""
    @Published var gender = ""
    
    @Published var showAlert = false
    @Published var errorMsg = ""
    
    @Published var validator = Validators.shared
    
    init(empleado: Empleado) {
        self.empleado = empleado
        
        firstName = empleado.firstName
        lastName = empleado.lastName
        email = empleado.email
        address = empleado.address
        zipcode = empleado.zipcode
        username = empleado.username
        department = empleado.department.rawValue
        gender = empleado.gender.rawValue
    }
    
    // Función para validar errores.
    func validateError() -> String {
        var msg = ""
        if let error = validator.isEmpty(firstName) {
            msg += "First Name \(error)\n"
        }
        if let error = validator.isEmpty(lastName) {
            msg += "Last Name \(error)\n"
        }
        if let error = validator.validEmail(email) {
            msg += "Email \(error)\n"
        }
        if let error = validator.isEmpty(address) {
            msg += "Address \(error)\n"
        }
        if let error = validator.isEmpty(username) {
            msg += "Username \(error)\n"
        }
        return String(msg.dropLast())
    }
    
    // Función para validar los empleados con los cambios que haya hecho.
    func validateEmpleado() -> Empleado? {
        
        guard let genderType = GenderType(rawValue: gender),
              let dptoName = DptoName(rawValue: department) else {
                return nil
        }
        let msg = validateError()
        if msg.isEmpty {
            return Empleado(id: empleado.id,
                            firstName: firstName,
                            lastName: lastName,
                            username: username,
                            email: email,
                            address: address,
                            zipcode: zipcode,
                            avatar: empleado.avatar,
                            gender: genderType,
                            department: dptoName)
        } else {
            errorMsg = msg
            showAlert.toggle()
            return nil
        }
    }
}
