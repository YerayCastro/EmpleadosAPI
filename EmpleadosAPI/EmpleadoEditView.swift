//
//  EmpleadoEditView.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 20/11/23.
//

import SwiftUI

struct EmpleadoEditView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var editVM: EmpleadoEditVM
    @EnvironmentObject var vm: EmpleadosVM
    
    // Para controlar el foco en UN solo campo.
    // @FocusState private var campo: Bool
    
    // Para controlar el foco en los campos del formulario. Usamos el enum EmpleadosField, de tipo opcional.
    @FocusState private var campo: EmpleadosField?
    
    var body: some View {
        Form {
            Section {
//                 Botón para quitar el teclado, cuando está el foco en un campo. Asociado al campo First name.Con el modificador(.focused)
//                Button {
//                    campo = false
//                } label: {
//                    Text("Quitar")
//                }
                MolonTextField(label: "First Name", text: $editVM.firstName)
                // Para decir de que tipo es el campo.
                    .textContentType(.name)
                // Para el uso de la capitalización
                    .textInputAutocapitalization(.words)
                    //.focused($campo) este se usa para UN solo campo
                // Este se usa cuando vamos a usar más de un campo
                    .focused($campo, equals: .firstName)
                MolonTextField(label: "Last Name", text: $editVM.lastName)
                    .textContentType(.familyName)
                    .textInputAutocapitalization(.words)
                    .focused($campo, equals: .lastName)
                MolonTextField(label: "Address", text: $editVM.address)
                    .textContentType(.fullStreetAddress)
                    .textInputAutocapitalization(.words)
                    .focused($campo, equals: .address)
                MolonTextField(label: "ZIP Code", text: $editVM.zipcode,
                               validator: Validators.shared.noValidate)
                    .textContentType(.postalCode)
                    .autocorrectionDisabled()
                    .focused($campo, equals: .zipcode)
                // Para hacer un Picker y que muestre todos los valores del enum.
                Picker("Gender", selection: $editVM.gender) {
                    // Hacemos un ForEach, con .allCases, y lo devolvemos el valor con .rawValue.
                    ForEach(GenderType.allCases) { gender in
                        Text(LocalizedStringKey(gender.rawValue))
                        // Ponemos una etiqueta(.tag) para que propague el valor real. Hay que pasarlo con el(.rawValue)
                            .tag(gender.rawValue)
                    }
                }
            } header: {
                Text("Personal data")
            }
            // .submitLabeL -> Para que en el teclado aparezca en el botón de introducir, lo que tu quieras
                .submitLabel(.next)
            // Para que cuando des al botón del teclado, haga la función next()
                .onSubmit {
                    campo?.next()
                }
            
            Section {
                // Para hacer un Picker y que muestre todos los valores del enum.
                Picker("Department", selection: $editVM.department) {
                    // Hacemos un ForEach, con .allCases, y lo devolvemos el valor con .rawValue.
                    ForEach(vm.dptos) { dpto in
                        Text(LocalizedStringKey(dpto.rawValue))
                        // Ponemos una etiqueta(.tag) para que propague el valor real. Hay que pasarlo con el(.rawValue)
                            .tag(dpto.rawValue)
                    }
                }
                MolonTextField(label: "Email", text: $editVM.email,
                               validator: Validators.shared.validEmail)
                    .textContentType(.emailAddress)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($campo, equals: .email)
                MolonTextField(label: "Username", text: $editVM.username,
                               validator: Validators.shared.greatherThan4)
                    .textContentType(.username)
                    .autocorrectionDisabled()
                    .textInputAutocapitalization(.never)
                    .keyboardType(.emailAddress)
                    .focused($campo, equals: .username)
            } header: {
                Text("Company details")
            }
            // .submitLabeL -> Para que en el teclado aparezca en el botón de introducir, lo que tu quieras
                .submitLabel(.next)
            // Para que cuando des al botón del teclado, haga la función next()
                .onSubmit {
                    campo?.next()
                }
        }
        .navigationTitle("Edit employee")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .confirmationAction) {
                Button {
                    if let empleado = editVM.validateEmpleado() {
                        Task {
                            await vm.updateEmpleado(empleado: empleado)
                            dismiss()
                        }
                    }
                } label: {
                    Text("Save")
                }
            }
            // Para quitar el teclado.
            ToolbarItem(placement: .keyboard) {
                HStack {
                    Button {
                        campo?.prev()
                    } label: {
                        Image(systemName: "chevron.up")
                    }
                    Button {
                        campo?.next()
                    } label: {
                        Image(systemName: "chevron.down")
                    }

                    Spacer()
                    Button {
                        // Para quitar el teclado, como campo es opcional, lo pongo a nil
                        campo = nil
                    } label: {
                        Image(systemName: "keyboard")
                    }
                }
            }
        }
        .alert("Validation Error",
               isPresented: $editVM.showAlert) {
            
        } message: {
            Text(editVM.errorMsg)
        }

    }
}

#Preview {
     NavigationStack{
        EmpleadoEditView(editVM: EmpleadoEditVM(empleado: .test))
             .environmentObject(EmpleadosVM.test)
    }
}
