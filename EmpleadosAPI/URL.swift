//
//  URL.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 17/11/23.
//

import Foundation
/*:
 2ª capa. Interface. Sólo está esta capa cuando vamos a recibir datos de la nube(API). En este modelo van a estar todas las direcciones url donde nos vamos a conectar. Todos los entornos que yo tenga que crear los pongo como variables globales.
 */

// Creo una variable global con la url de prducción. Para crear el entorno de producción.
let prod = URL(string: "https://acacademy-employees-api.herokuapp.com/api/")!

// Para que las urls, no se suban a produccion
#if DEBUG
// Creo una variable global con la url de desarrollo. Para crear el entorno de desarrollo.
let desa = URL(string: "http://localhost:8080/api/")!
// Creo una variable global con la url de preproducción. Para crear el entorno de prepoducción.
let pre = URL(string: "https://acacademy-stage.herokuapp.com/api/")!
#endif

// Para que el entorno se suba a producción
#if RELEASE
let api = prod
#else
let api = prod // Aquí iría DESA si hubiera un DESA o lo que toque
#endif

// Creo una constante llamada api y le doy el valor del entorno que quiero usar. En este caso producción
// let api = prod

// Creo una extensión de URL
extension URL {
    // Creo una variable getEmpleados, para añadir el path de la llamada que voy a hacer. La variable tiene que ser static.
    static let getEmpleados = api.appending(path: "getEmpleados")
    // Creo una variable empleado, para añadir el path de la llamada que voy a hacer. La variable tiene que ser static.
    static let empleado = api.appending(path: "empleado")
    // Creo una función que va a devolver en la llamada un empleado. Lo hago como función porque la llamada es dinámica.
    static func getEmpleado(id: Int) -> URL {
        // Añado el path getEmpleado y el path con la id del empleado para que sea dinámico y poder pasar cualquier id.
        api.appending(path: "getEmpleado").appending(path: "\(id)")
    }
}

// Para ir a la url del empleado 120
// URLSession.shared.dataTask(with: .getEmpleado(id: 120))
