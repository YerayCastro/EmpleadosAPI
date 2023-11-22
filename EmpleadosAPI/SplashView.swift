//
//  SplashView.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 22/11/23.
//

import SwiftUI

struct SplashView: View {
    @EnvironmentObject var vm: EmpleadosVM
    
    var body: some View {
        Group {
            if vm.loading {
                ZStack {
                    Color(.splash)
                    Image(.splash)
                    ProgressView()
                        .controlSize(.large)
                        .padding(.top, 400)
                }
                .ignoresSafeArea()
            } else {
                ContentView()
                    .transition(.move(edge: .top))
            }
        }
        .animation(.default, value: vm.loading)
    }
}

#Preview {
    SplashView()
        .environmentObject(EmpleadosVM.test)
}
