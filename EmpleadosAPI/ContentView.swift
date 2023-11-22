//
//  ContentView.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 16/11/23.
//

import SwiftUI

struct ContentView: View {
    // Objeto de entorno declarado, no inicializado
    @EnvironmentObject var vm: EmpleadosVM
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dptos){ dpto in
                    empleadosSection(empleados: vm.getEmpleadosByDpto(dpto: dpto),
                                     dpto: dpto.rawValue)
                }
            }
            .navigationTitle("Employees")
            .searchable(text: $vm.search, prompt: "Search for an employee")
            .sortedButton(sortType: $vm.sortType)
            .navigationDestination(for: Empleado.self) { empleado in
                EmpleadoEditView(editVM: EmpleadoEditVM(empleado: empleado))
            }
            // Para poder refrescar la pantalla, y ver los cambios que se hayan hecho en la API.
            .refreshable {
                await vm.getEmpleados()
            }
        }
        .deleteAlert(isPresented: $vm.deleteAlert,
                     msg: vm.msg,
                     deleteAction: vm.deleteEmpleado)
        .alert("App Alert", isPresented: $vm.showAlert) { } message: {
            Text(vm.msg)
        }
    }
    // Función para recuperar la sección de empleados
    func empleadosSection(empleados: [Empleado], dpto: String) -> some View {
        Group {
            // Si empleados es mayor que 0, devuelve los empleados.
            if empleados.count > 0 {
                Section {
                    ForEach(empleados) { empleado in
                        NavigationLink(value: empleado) {
                            EmpleadoCell(empleado: empleado,
                                         deleteAction: vm.deleteEmpleadoAlert)
                        }
                    }
                } header: {
                    Text(LocalizedStringKey(dpto))
                }
            }
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(EmpleadosVM.test)
}
