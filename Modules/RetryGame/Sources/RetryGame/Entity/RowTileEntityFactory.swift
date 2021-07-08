//
//  File.swift
//  
//
//  Created by Bee Godwin on 08/07/2021.
//

import SpriteKit

protocol RowTileEntityFactory {
    func build(on entity: Entity, with flavour: RowTileEntityFlavour)
}

enum RowTileEntityFlavour {
    case single(TextureSet, TextureSetSide)
}

enum TextureSetSide: String {
    case mid = "Mid"
    case center = "Center"
}

extension EntityFactory: RowTileEntityFactory {
    func build(on entity: Entity, with flavour: RowTileEntityFlavour) {
        switch flavour {
        case .single(let set, let side):
            guard let texture = container.textureManager.getTile(from: set, side: side) else { return }
            let component = SpriteComponent(texture: texture)
            entity.addSpriteComponent(component)
        }
        
    }
}
