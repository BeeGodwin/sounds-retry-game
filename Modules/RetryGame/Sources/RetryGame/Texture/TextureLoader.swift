import SpriteKit

class TextureLoader {

    func loadAnims(spriteDefs: [Sprite: [String]]) -> [Sprite: [SKTexture]] {
        let atlas = SKTextureAtlas(named: GameConstants.spriteAtlas)
        
        var animDict = [Sprite: [SKTexture]]()
        
        spriteDefs.forEach { sprite, names in
            let textures = names.map { atlas.textureNamed($0) }
            animDict[sprite] = textures
        }
        return animDict
    }
    
    func loadTiles(tileDefinitions: [TextureSet: [String]]) -> [TextureSet: [SKTexture]] {
        var tileDict = [TextureSet: [SKTexture]]()
        let atlas = SKTextureAtlas(named: GameConstants.worldAtlas)
        
        tileDefinitions.keys.forEach { key in
            guard let nameArray = tileDefinitions[key] else { return }
            var textures = [SKTexture]()
            nameArray.forEach { name in
                textures.append(atlas.textureNamed(name))
            }
            if textures.count > 0 {
                tileDict[key] = textures
            }
        }
        
        return tileDict
    }
}
