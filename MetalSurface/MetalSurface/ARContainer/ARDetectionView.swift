//
//  ARView.swift
//  MetalSurface
//

import RealityKit
import ARKit
import SwiftUI
import Metal

// MARK: - ARDetectionView
final class ARDetectionView: ARView {
     
     // MARK: - Dependency
     @StateObject var viewModel = ARDetectionViewModel()
     
     // MARK: - Properties
     var arView: ARView { return self }
     var metalDevice: MTLDevice!
     var pipelineState: MTLRenderPipelineState!
     var renderer: Renderer!
     
     // MARK: - Init
     required init(frame frameRect: CGRect) {
          super.init(frame: frameRect)
     }
     
     @available(*, unavailable)
     required init?(coder decoder: NSCoder) {
          fatalError("not implemented")
     }
     
     // MARK: - Setup
     func setup(modelName: String) {
          viewModel.modelName = modelName
          arView.cameraMode = .ar
          setupARSession()
          getMetal()
          let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
          tapGesture.cancelsTouchesInView = false
          addGestureRecognizer(tapGesture)
     }
     
     private func setupARSession() {
          let session = self.session
          let configuration = ARWorldTrackingConfiguration()
          configuration.planeDetection = [.horizontal]
          session.run(configuration)
          session.delegate = self
     }
     
     func getMetal() {
          if let metalDevice = MTLCreateSystemDefaultDevice() {
               self.metalDevice = metalDevice
               self.renderer = Renderer(self)
               
               let library = metalDevice.makeDefaultLibrary()
               
               let vertexFunction = library?.makeFunction(name: "vertex_main")
               
               let pipelineDescriptor = MTLRenderPipelineDescriptor()
               pipelineDescriptor.vertexFunction = vertexFunction
               
               do {
                    pipelineState = try metalDevice.makeRenderPipelineState(descriptor: pipelineDescriptor)
               } catch {
                    print("Failed to create pipeline state: \(error)")
               }
          }
     }
     
     // MARK: - Actions
     @objc private func handleTap(_ recognizer: UITapGestureRecognizer) {
          let tapLocation = recognizer.location(in: arView)
          let results = arView.raycast(from: tapLocation, allowing: .estimatedPlane, alignment: .horizontal)

          if let result = results.first {
               let anchor = AnchorEntity(raycastResult: result)

               if let entity = try? ModelEntity.load(named: viewModel.modelName) {
                    let scale = SIMD3<Float>(0.01, 0.01, 0.01)
                    entity.scale = scale
                    anchor.addChild(entity)
               }
               arView.scene.addAnchor(anchor)
          }
     }
}
