//
//  SortedButton.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 20/11/23.
//

import SwiftUI

// (fileprivate) No aparece fuera de este fichero, asi accedo solo a la extensión de View.
fileprivate struct SortedButton: ViewModifier {
    // Creamos un @Binding del tipo de dato SortType
    @Binding var sortType: SortType
    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Menu {
                        Button {
                            sortType = .ascendent
                        } label: {
                            Text("Ascendent")
                        }
                        Button {
                            sortType = .descendent
                        } label: {
                            Text("Descendent")
                        }
                        Button {
                            sortType = .byID
                        } label: {
                            Text("By ID")
                        }
                    } label: {
                        Text("Sorted by")
                    }
                }
            }
    }
}

extension View {
    // Extensión que devuelve una View, pasandole el Binding de SortType, que devuelve el modifier de SortedButton, de tipo sortType
    func sortedButton(sortType: Binding<SortType>) -> some View {
        modifier(SortedButton(sortType: sortType))
    }
}
