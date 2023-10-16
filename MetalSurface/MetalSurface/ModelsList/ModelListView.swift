//
//  ModelListView.swift
//  MetalSurface
//

import SwiftUI

// MARK: - ModelListView
struct ModelListView: View {
    
    // MARK: - Dependency
    @StateObject private var viewModel = ModelListViewModel()
    
    // MARK: - Body
    var body: some View {
        NavigationView {
            VStack {
                Text("Available 3D Models")
                    .padding()
                
                List(viewModel.modelNames, id: \.self) { modelName in
                    HStack {
                        Image(modelName)
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text(modelName)
                            .onTapGesture {
                                viewModel.selectModel(modelName)
                            }
                    }
                }
            }
            .sheet(item: $viewModel.selectedModelName) { model in
                ARContainer(modelName: model.id)
                    .onDisappear {
                        viewModel.clearSelection()
                    }
            }
        }
    }
}
