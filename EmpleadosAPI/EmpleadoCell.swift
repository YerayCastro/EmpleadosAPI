//
//  EmpleadoCell.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 20/11/23.
//

import SwiftUI

struct EmpleadoCell: View {

    let empleado: Empleado
    
    let deleteAction: (Empleado) -> ()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(empleado.fullname)
                    .font(.headline)
                Text(empleado.email)
                    .font(.footnote)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            AsyncImage(url: empleado.avatar) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolVariant(.circle)
                    .frame(width: 90)
                    .background {
                        Color(white: 0.9)
                    }
                    .clipShape(Circle())
            } placeholder: {
                Image(systemName: "person")
                    .resizable()
                    .scaledToFit()
                    .symbolVariant(.fill)
                    .symbolVariant(.circle)
                    .padding()
                    .frame(width: 90)
                    .background {
                        Color(white: 0.9)
                    }
                    .clipShape(Circle())
            }
        }
        .swipeActions {
            Button {
                deleteAction(empleado)
            } label: {
                Label("Delete", systemImage: "trash")
            }
            .tint(.red)
        }
    }
}

#Preview {
    EmpleadoCell(empleado: .test, deleteAction: { _ in })
}
