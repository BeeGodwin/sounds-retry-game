import SpriteKit

protocol TextureManagerProtocol {
    func getAnimationFrames(for sprite: Sprite) -> [SKTexture]
    func getTile(from set: TextureSet, side: TextureSetSide) -> SKTexture? // TODO: review use of this and see if can be non-optional
}

enum TextureSet: String {
    case dirt = "dirt"
    case grass = "grass"
    case planet = "planet"
    case sand = "sand"
    case stone = "stone"
}

class TextureManager: TextureManagerProtocol {
    
    private lazy var textures = [TextureSet: SKTexture]()
    
    let animations: [Sprite: [SKTexture]]
    let groundTiles: [TextureSet: [SKTexture]]
    
    init() {
        let loader = TextureLoader()
        groundTiles = loader.loadTiles(tileDefinitions: GameConstants.groundTileNames)
        animations = loader.loadAnims(spriteDefs: GameConstants.sprites)
    }
    
    func getAnimationFrames(for sprite: Sprite) -> [SKTexture] {
        guard let frames = animations[sprite] else { return [] }
        return frames
    }
    
    func getTile(from set: TextureSet, side: TextureSetSide) -> SKTexture? {
        if let tiles = groundTiles[set] {
            switch side {
            case .center:
                return tiles[1]
            case .mid:
                return tiles[0]
            }
        }
        return nil
    }
}
