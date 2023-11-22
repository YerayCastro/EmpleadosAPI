//
//  DataTest.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 20/11/23.
//

import Foundation

extension Empleado {
    static let test = Empleado(id: 1, firstName: "Julio César", lastName: "Fernández", username: "jcfmunoz", email: "jcfmunoz@icloud.com", address: "Apple Park", zipcode: "28000", avatar: URL(string: "https://pbs.twimg.com/profile_images/1017076264644022272/tetffw3o_400x400.jpg"), gender: .male, department: .engineering)
}
extension EmpleadosVM {
    static let test = EmpleadosVM(network: DataTest())
}

// Al pasar la instancia de DataTest, pasa los datos de local
struct DataTest: DataInteractor {
    
    let url = Bundle.main.url(forResource: "testEmpleados", withExtension: "json")!
    
    func loadTestData() throws -> [Empleado] {
        // Aquí están los datos en local.
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([DTOEmpleado].self, from: data).map(\.toPresentation)
    }
    
    func getEmpleados() async throws -> [Empleado] {
        // Devuelve los datos desde local.
        try loadTestData()
    }
    
    func updateEmpleado(empleado: Empleado) async throws {}
}
