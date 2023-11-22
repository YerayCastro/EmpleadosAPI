//
//  EmpleadosVM.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 19/11/23.
//

import SwiftUI

/*:
 4º capa: ViewModel
 */

final class EmpleadosVM: ObservableObject {
    // Obtengo la instncia de DataInteractor
    let network: DataInteractor
    // Hay que inicializarlo porque vamos a recibir los datos de manera asíncrona
    @Published var empleados: [Empleado] = []
    @Published var showAlert = false
    @Published var msg = ""
    @Published var sortType: SortType = .byID
    @Published var search = ""
    @Published var deleteAlert = false
    
    @Published var loading = true
    
    var empleadoToDelete: Empleado?
    
    // Variable calculada, para sacar la cadena, que esta dentro de la cadena, del elemento.
    var departments: [String] {
        DptoName.allCases.map {
            String(localized: LocalizedStringResource(stringLiteral: $0.rawValue))
        }.sorted()
    }
    
    // Para que me devuelva los valores del Array ordenados por la traducción.
    var dptos: [DptoName] {
        DptoName.allCases.sorted { d1, d2 in
            String(localized: LocalizedStringResource(stringLiteral: d1.rawValue)) <=
            String(localized: LocalizedStringResource(stringLiteral: d2.rawValue))
        }
    }
    
//     Para obtener el valor único de los departamentos. Hacemos el Set, para eliminiar los valores duplicados, y los metemos en el Array, para obtener los valores únicos.El .map(\.department) hace un listado de los departamentos.
//    var dptos: [DptoName] {
//        Array(Set(empleados.map(\.department)))
//    }
    
    // Para inicializar los valores del DataInteractor con un valor por defecto de Network.
    init (network: DataInteractor = Network()) {
        // Se le asocia el valor a la clase, desde éste momento todas las llamadas son a la red.
        self.network = network
        // Como se trabaja con async, hay que hacerlo con Task
        Task {
            await MainActor.run { loading = true }
            await getEmpleados()
            await MainActor.run { loading = false }
        }
    }
    // Para poder ejecutar el async, tiene que haber antes un await(Task {await})
    func getEmpleados() async {
        do {
            // Creo la constante emps, para evitar error de runtime. Esto se está ejecutando en el hilo secundario.
            let emps = try await network.getEmpleados()
            // Creo un MainActor, poniendo delante await para poder elevarlo al hilo principal.
            await MainActor.run {
                self.empleados = emps
            }
        } catch {
            await MainActor.run {
                self.msg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    // Función para devolver empleados por tipo de departamento
    func getEmpleadosByDpto(dpto: DptoName) -> [Empleado] {
        empleados
            .filter { $0.department == dpto }
            .filter {
                if search.isEmpty {
                    true
                } else {
                    $0.fullname.range(of: search, options: [.caseInsensitive, .diacriticInsensitive]) != nil
                }
            }
            .sorted { e1, e2 in
                switch sortType {
                case .ascendent:
                    e1.fullname <= e2.fullname
                case .descendent:
                    e1.fullname >= e2.fullname
                case .byID:
                    e1.id < e2.id
                }
            }
    }
    
    // Función para borrar empleados, pero que muestre una alerta antes de que si estás seguro de borrarlo.
    func deleteEmpleadoAlert(empleado: Empleado) {
        msg = "Are you sure to delete the employee \(empleado.fullname)"
        deleteAlert.toggle()
        empleadoToDelete = empleado
    }
    // Función que borra el empleado, después de haber sido preguntado con la alerta
    func deleteEmpleado() {
        if let empleadoToDelete {
            withAnimation {
                empleados.removeAll(where: { $0.id == empleadoToDelete.id })
            }
        }
    }
    
    // Función que llama a la función asincrona updateEmpleadoAsync.
    func updateEmpleado(empleado: Empleado) async {
        do {
            try await updateEmpleadoAsync(empleado: empleado)
        } catch {
            await MainActor.run {
                self.msg = "\(error)"
                self.showAlert.toggle()
            }
        }
    }
    
    // Función para cargar los datos.Tiene que ser asincrono.
    func updateEmpleadoAsync(empleado: Empleado) async throws {
        try await network.updateEmpleado(empleado: empleado)
        await MainActor.run {
            updateEmpleadoArray(empleado: empleado)
        }
    }
    // Función para descargar el empleado
    func updateEmpleadoArray(empleado: Empleado) {
        if let first = empleados.firstIndex(where: { $0.id == empleado.id }) {
            empleados[first] = empleado
        }
    }
}
