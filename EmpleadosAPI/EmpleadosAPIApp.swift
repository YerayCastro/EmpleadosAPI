//
//  EmpleadosAPIApp.swift
//  EmpleadosAPI
//
//  Created by Yery Castro on 16/11/23.
//

import SwiftUI

@main
struct EmpleadosAPIApp: App {
    @StateObject var vm = EmpleadosVM()
    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(vm)
        }
    }
}
