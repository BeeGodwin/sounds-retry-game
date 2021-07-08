import SpriteKit

class TextureLoader {
    
    typealias AtlasName = String
    typealias TexturePrefix = String
    
    func loadAnims(animationDefinitions: [String: (String, String)]) -> [String: [SKTexture]] {
        // anims will either be single framed or be suffixed with an index
       
        
        var animDict = [String: [SKTexture]]()
        
        animationDefinitions.forEach { (key, value)in
            let atlas = SKTextureAtlas(named: value.0)
        
            var textures = [SKTexture]()
            
            textures.append(atlas.textureNamed(value.1))
            
            // now do the iterated ones, this misses some.
            
            animDict[key] = textures
        }
       
       
        
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
