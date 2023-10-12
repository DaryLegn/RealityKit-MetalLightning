//
//  ARContainer.swift
//  MetalSurface
//

import SwiftUI

// MARK: - ARContainer
struct ARContainer: UIViewRepresentable {
    var modelName: String

    func makeUIView(context: Context) -> ARDetectionView {
        let arView = ARDetectionView(frame: .zero)
        arView.setup(modelName: modelName)
        return arView
    }
    
    func updateUIView(_ uiView: ARDetectionView, context: Context) { }
}
