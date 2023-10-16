//
//  ARDetectionView+PlaneExtension.swift
//  MetalSurface
//

import ARKit

// MARK: - ARSession delegate
extension ARDetectionView: ARSessionDelegate {

     func session(_ session: ARSession, didAdd anchors: [ARAnchor]) {
          for anchor in anchors {
               if let arPlaneAnchor = anchor as? ARPlaneAnchor {
                    let id = arPlaneAnchor.identifier
                    if viewModel.planes.contains(where: {$0.key == id}) { fatalError("anchor already exists")}
                    let planeAnchorEntity = PlaneAnchor(arPlaneAnchor: arPlaneAnchor)
                    self.scene.anchors.append(planeAnchorEntity)
                    viewModel.planes[id] = planeAnchorEntity
               }
          }
     }
     
     func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
          for anchor in anchors {
               if let planeAnchor = anchor as? ARPlaneAnchor {
                    if let planeEntityAnchor = viewModel.planes[planeAnchor.identifier] {
                         try? planeEntityAnchor.didUpdate(arPlaneAnchor: planeAnchor)
                    } else {
                         fatalError("trying to update unexisting anchor")
                    }
               }
          }
     }
     
     func session(_ session: ARSession, didRemove anchors: [ARAnchor]) {
          for anchor in anchors {
               if let planeAnchor = anchor as? ARPlaneAnchor {
                    if let planeEntityAnchor = self.viewModel.planes[planeAnchor.identifier] {
                         self.viewModel.planes.removeValue(forKey: planeAnchor.identifier)
                         self.scene.anchors.remove(planeEntityAnchor)
                    } else {
                         fatalError("trying to remove unexisting anchor")
                    }
               }
          }
     }
}

