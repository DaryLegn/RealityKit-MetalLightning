//
//  Renderer.swift
//  MetalSurface
//

import MetalKit

final class Renderer: NSObject, MTKViewDelegate {
    var parent: ARDetectionView
    var metalDevice: MTLDevice!
    var metalQuene: MTLCommandQueue!
    let pipelineState: MTLRenderPipelineState
    
    init(_ parent: ARDetectionView) {
        self.parent = parent
        
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            self.metalDevice = metalDevice
        }
        self.metalQuene = metalDevice.makeCommandQueue()
        
        let pipeplineDescriptor = MTLRenderPipelineDescriptor()
        let library = metalDevice.makeDefaultLibrary()
        if let vertexFunction = library?.makeFunction(name: "vertexShader") {
            pipeplineDescriptor.vertexFunction = vertexFunction
        }
        
        pipeplineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
        
        do {
            try pipelineState = metalDevice.makeRenderPipelineState(descriptor: pipeplineDescriptor)
        } catch {
            fatalError("makeRenderPipelineState is fail")
        }
        
        super.init()
    }

    func draw(in view: MTKView) {
        guard let drawable = view.currentDrawable else { return }
        let commandBuffer = metalQuene.makeCommandBuffer()
        let renderPassDescriptor = view.currentRenderPassDescriptor
        renderPassDescriptor?.colorAttachments[0].clearColor = MTLClearColor(red: 0, green: 0.5, blue: 0.5, alpha: 1.0)
        renderPassDescriptor?.colorAttachments[0].loadAction = .clear
        renderPassDescriptor?.colorAttachments[0].storeAction = .store
        
        let renderEncoder = commandBuffer?.makeRenderCommandEncoder(descriptor: renderPassDescriptor!)
        renderEncoder?.setRenderPipelineState(pipelineState)
        renderEncoder?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
        renderEncoder?.endEncoding()
        commandBuffer?.present(drawable)
        commandBuffer?.commit()
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) { }
}

