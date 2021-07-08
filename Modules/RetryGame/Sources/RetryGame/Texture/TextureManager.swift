import SpriteKit

protocol TextureManagerProtocol {
    func getAnimationFrames(for sprite: Sprite) -> [SKTexture] // TODO: this is wrong
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
    
    // MARK: these should prob be binned
    func debugLightGrey() -> [SKTexture] {
        guard let tile = getTile(from: .dirt, side: .center) else { return [] }
        return [tile]
    }
    
    func debugDarkGrey() -> [SKTexture] {
        debugLightGrey()
    }
    
    // TODO: conform these / better dict usage
    func getPlayerWalk() -> [SKTexture] {
        guard let frames = animations[.playerWalk] else { return [] }
        return frames
    }
    
    func getPlayerJump() -> [SKTexture] {
        guard let frames = animations[.playerJump] else { return [] }
        return frames
    }
    
    func getPlayerDie() -> [SKTexture] {
        guard let frames = animations[.playerDie] else { return [] }
        return frames
    }
}
