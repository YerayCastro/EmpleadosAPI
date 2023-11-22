//
//  MolonTextField.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 20/11/23.
//

import SwiftUI

struct MolonTextField: View {
    let label: String
    @Binding var text: String
    
    // Variable validator, recibe un String, y devuelve un String opcional
    var validator: (String) -> String? = Validators.shared.isEmpty
    
    @State private var errorMessage = ""
    
    var body: some View {
        // Para hacer las traducciones de las etiquetas.
        let localized = String(localized: LocalizedStringResource(stringLiteral: label))
        VStack(alignment: .leading) {
            Text(localized.capitalized)
                .font(.headline)
                .padding(.leading, 10)
            HStack {
                TextField("Enter the \(localized.lowercased())", text: $text)
                Button {
                    text = ""
                } label: {
                    Image(systemName: "xmark")
                        .symbolVariant(.fill)
                        .symbolVariant(.circle)
                }
                .buttonStyle(.plain)
                .opacity(text.isEmpty ? 0.0 : 0.5)
            }
            .padding(10)
            .background {
                Color(white: 0.95)
            }
            .clipShape(RoundedRectangle(cornerRadius: 10))
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)
                    .fill(.red)
                    .opacity(!errorMessage.isEmpty ? 1.0 : 0.0)
            }
            if !errorMessage.isEmpty {
                Text("\(localized.capitalized) \(errorMessage)")
                    .bold()
                    .font(.caption)
                    .padding(.leading, 10)
                    .foregroundStyle(.red)
                    .transition(.opacity)
            }
        }
        // Con initial: true, valida también el valor de inicio.
        .onChange(of: text, initial: true) {
            if let errorMsg = validator(text) {
                errorMessage = errorMsg
            } else {
                errorMessage = ""
            }
        }
        .animation(.default, value: errorMessage)
    }
}

#Preview {
    MolonTextField(label: "First Name", text: .constant("Julio César"))
}
