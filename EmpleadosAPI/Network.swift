//
//  Network.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 19/11/23.
//

import SwiftUI

/*:
 3ª capa. Interactor(Network) Llamada de red.
 */

// Creo un protocolo de DataInteractor, para pasarle la función getEmpleados.Para los datos de prueba o de producción.
protocol DataInteractor {
    func getEmpleados() async throws -> [Empleado]
    func updateEmpleado(empleado: Empleado) async throws
}

// Al pasar la instancia de Network,coge los datos de la nube.
struct Network: DataInteractor {
    // Función para recuperar JSON
    func getJSON<JSON>(request: URLRequest, type: JSON.Type) async throws -> JSON where JSON: Codable {
        // Aquí hacemos la llamada
        let (data, response) = try await URLSession.shared.getData(for: request)
        // Comparamos el estatusCode
        if response.statusCode == 200 {
            do {
                // Devolver el json
                return try JSONDecoder().decode(JSON.self, from: data)
            } catch {
                // Controlar el error
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    // Función Post. Para enviar.
    func postJSON(request: URLRequest, status: Int = 200) async throws {
        let (_, response) = try await URLSession.shared.getData(for: request)
        if response.statusCode != status {
            throw NetworkError.status(response.statusCode)
        }
    }
    // Función getEmpleados. Para recuperar los empleados.
    func getEmpleados() async throws -> [Empleado] {
        // Recuperame el json, a partir de la operación get, de la url getEmpleados, sobre el tipo DTOEmleados y hazme un map de cada registro de la variable calculada toPresentation, para convertir DTOEmpleados, en un empleado, de la capa de presentación.
        try await getJSON(request: .get(url: .getEmpleados), type: [DTOEmpleado].self).map(\.toPresentation)
    }
    
    // Función que actualiza el empleado
    func updateEmpleado(empleado: Empleado) async throws {
       // Hacemos el postJSON, sobre el post, de la url(.empleado), del dato(.toUpdate), sobre el método(PUT). Para hacer la llamada a la nube.
        try await postJSON(request: .post(url: .empleado, data: empleado.toUpdate, method: "PUT"))
    }
}
