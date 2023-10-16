//
//  ARDetectionViewModel.swift
//  MetalSurface
//

import SwiftUI

// MARK: - ARDetectionViewModelProtocol
protocol ARDetectionViewModelProtocol: ObservableObject {
    var modelName: String { get set }
    var planes: [UUID: PlaneAnchor] { get set }
}

// MARK: - ARDetectionViewModel
class ARDetectionViewModel: ARDetectionViewModelProtocol {
    @Published var modelName: String = ""
    @Published var planes: [UUID: PlaneAnchor] = [:]
}
