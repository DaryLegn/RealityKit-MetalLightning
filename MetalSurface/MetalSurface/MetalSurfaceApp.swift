//
//  MetalSurfaceApp.swift
//  MetalSurface
//

import SwiftUI
import Metal
import MetalKit

@main
struct MetalSurfaceApp: App {
    var body: some Scene {
        WindowGroup {
            ModelListView()
                .ignoresSafeArea()
        }
    }
}
