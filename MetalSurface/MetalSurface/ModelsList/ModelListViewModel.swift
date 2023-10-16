//
//  ModelListViewModel.swift
//  MetalSurface
//

import Foundation
import SwiftUI

// MARK: - ModelListViewModelProtocol
protocol ModelListViewModelProtocol {
    associatedtype Model: Identifiable
    
    var selectedModelName: Model? { get set }
    var modelNames: [String] { get }
    
    func selectModel(_ modelName: String)
    func clearSelection()
}

// MARK: - ModelListViewModel
class ModelListViewModel: ModelListViewModelProtocol, ObservableObject {
    @Published var selectedModelName: Model?
    
    struct Model: Identifiable {
        let id: String
    }
    
    let modelNames = ["big_smart_desk", "banded_chevron_rug_8x10", "big_grid_chair", "Air_Jordan", "shoe"] // - TO DO: Make Thumbnails images
    
    func selectModel(_ modelName: String) {
        selectedModelName = Model(id: modelName)
    }
    
    func clearSelection() {
        selectedModelName = nil
    }
}
