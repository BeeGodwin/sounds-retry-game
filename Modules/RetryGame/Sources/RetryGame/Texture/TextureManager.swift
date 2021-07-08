import SpriteKit

protocol TextureManagerProtocol {
    func getTexture(named textureName: String) -> SKTexture? // TODO: this is wrong
}

enum TextureSet: String {
    case dirt = "dirt"
    case grass = "grass"
    case planet = "planet"
    case sand = "sand"
    case stone = "stone"
}

class TextureManager: TextureManagerProtocol {
    
    private static var LIGHT_GREY = "debug_lightgrey" // TODO: should bin these off and do programatically, but if not, move to game constants
    private static var DARK_GREY = "debug_darkgrey"
    
    private var playerWalkFrames = [SKTexture]()
    private var playerJump: SKTexture?
    private var playerDie: SKTexture?
    
    private lazy var textures = [TextureSet: SKTexture]()
        
    let playerAnims: [String: [SKTexture]]
    let obstacleAnims: [String: [SKTexture]]
    let groundTiles: [TextureSet: [SKTexture]]
    
    init() {
        
        let loader = TextureLoader()
        playerAnims = loader.loadAnims(animationDefinitions: GameConstants.playerAnims)
        obstacleAnims = loader.loadAnims(animationDefinitions: GameConstants.obstacleAnims)
        groundTiles = loader.loadTiles(tileDefinitions: GameConstants.groundTileNames)
        
        loadPlayerTextures()
    }
    
    func getTexture(named: String) -> SKTexture? {
        if let lightGreyImage = UIImage(named: Self.LIGHT_GREY, in: .module, compatibleWith: nil) {
            return SKTexture(image: lightGreyImage)
        }
        return nil
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
    
    func debugLightGrey() -> SKTexture? {
        getTexture(named: Self.LIGHT_GREY)
    }
    
    func debugDarkGrey() -> SKTexture? {
        getTexture(named: Self.DARK_GREY)
    }
    
    // TODO: conform these / better dict usage
    func getPlayerWalk() -> [SKTexture] {
        playerWalkFrames
    }
    
    func getPlayerJump() -> SKTexture? {
        playerJump
    }
    
    func getPlayerDie() -> SKTexture? {
        playerDie
    }
    
    private func loadPlayerTextures() {
        let playerAtlas = SKTextureAtlas(named: "player")
        playerWalkFrames.append(playerAtlas.textureNamed("alienPink_walk1"))
        playerWalkFrames.append(playerAtlas.textureNamed("alienPink_walk2"))
        playerJump = playerAtlas.textureNamed("alienPink_jump.png")
        playerDie = playerAtlas.textureNamed("alienPink_hit.png")
    }
}
