//
//  PlaneAnchor.swift
//  MetalSurface
//

import RealityKit
import ARKit

class PlaneAnchor: Entity, HasModel, HasAnchoring {
    
    @available(*, unavailable)
    required init() {
        fatalError("Not available")
    }
    
    init(arPlaneAnchor: ARPlaneAnchor) {
        super.init()
        self.components.set(createModelComponent(arPlaneAnchor))
        self.transform.matrix = arPlaneAnchor.transform
        self.position += arPlaneAnchor.center
        self.orientation = simd_quatf(angle: arPlaneAnchor.planeExtent.rotationOnYAxis, axis: [0,1,0])
    }
    
    private func createModelComponent(_ arPlaneAnchor: ARPlaneAnchor) -> ModelComponent {
        let mesh = MeshResource.generatePlane(width: arPlaneAnchor.planeExtent.width, depth: arPlaneAnchor.planeExtent.height)
        let material = UnlitMaterial(color: .lightGray.withAlphaComponent(0.5))
        let modelComponent = ModelComponent(mesh: mesh, materials: [material])
        return modelComponent
    }

    func didUpdate(arPlaneAnchor: ARPlaneAnchor) throws {
        let updatedMesh = MeshResource.generatePlane(width: arPlaneAnchor.planeExtent.width, depth: arPlaneAnchor.planeExtent.height)
        self.model?.mesh = updatedMesh
        
        let translation = arPlaneAnchor.center
        let positionTransform = simd_float4x4(translation: translation)
        let rotationAngle = arPlaneAnchor.planeExtent.rotationOnYAxis
        let orientationTransform = float4x4(simd_quatf(angle: rotationAngle, axis: [0,1,0]))
        self.transform.matrix = simd_mul(arPlaneAnchor.transform, simd_mul(positionTransform, orientationTransform))
    }
}
