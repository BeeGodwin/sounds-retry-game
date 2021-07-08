import SpriteKit

class TextureLoader {
    
    typealias AtlasName = String
    typealias TexturePrefix = String
    
    func loadAnims(spriteDefs: [Sprite: [String]]) -> [Sprite: [SKTexture]] {
        
        var animDict = [Sprite: [SKTexture]]()
        
        // TODO: reimport the sprites to xcode and bring them in from a single atlas
       
        return animDict
    }
    
    func loadTiles(tileDefinitions: [TextureSet: [String]]) -> [TextureSet: [SKTexture]] {
        var tileDict = [TextureSet: [SKTexture]]()
        let atlas = SKTextureAtlas(named: "world")
        
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
