//
//  View+Light.swift
//  MetalSurface
//

import SwiftUI

extension View {
    func lighting() -> some View {
        let function = ShaderFunction(library: .default, name: "lighting")
        var params = LightingParams()
        params.lightDirection = [1, 1, 0]
        params.newColor = [0, 1, 1, 1]

        let data = Shader.Argument.data(Data(
            bytes: &params,
            count: MemoryLayout<LightingParams>.stride))

        let shader = Shader(
            function: function,
            arguments: [.color(.white), data])
        return `colorEffect`(shader, isEnabled: true)
    }
}
