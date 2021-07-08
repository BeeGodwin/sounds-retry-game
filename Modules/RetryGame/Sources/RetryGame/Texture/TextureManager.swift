import SpriteKit

protocol TextureManagerProtocol {
    func getTexture(named textureName: String) -> SKTexture?
}

class TextureManager: TextureManagerProtocol {
    
    private static var LIGHT_GREY = "debug_lightgrey" // should bin these off and do programatically, but if not, move to game constants
    private static var DARK_GREY = "debug_darkgrey"
    
    private var playerWalkFrames = [SKTexture]()
    private var playerJump: SKTexture?
    private var playerDie: SKTexture?
    
    private lazy var textures = [String: SKTexture]()
        
    let playerAnims: [String: [SKTexture]]
    let obstacleAnims: [String: [SKTexture]]
    let groundTiles: [String: [SKTexture]]
    
    init() {
        
        let loader = TextureLoader()
        playerAnims = loader.loadAnims(animationDefinitions: GameConstants.playerAnims)
        obstacleAnims = loader.loadAnims(animationDefinitions: GameConstants.obstacleAnims)
        groundTiles = loader.loadTiles(tileDefinitions: GameConstants.groundTileNames)
        
        loadDebugTextures()
        loadPlayerTextures()
    }
    
    func getTexture(named textureName: String) -> SKTexture? {
        return textures[textureName]
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
    
    private func loadDebugTextures() {
        if let lightGreyImage = UIImage(named: Self.LIGHT_GREY, in: .module, compatibleWith: nil) {
            textures[Self.LIGHT_GREY] = SKTexture(image: lightGreyImage)
        }
        if let darkGreyImage = UIImage(named: Self.DARK_GREY, in: .module, compatibleWith: nil) {
            textures[Self.DARK_GREY] = SKTexture(image: darkGreyImage)
        }
    }
    
    private func loadPlayerTextures() {
        let playerAtlas = SKTextureAtlas(named: "player")
        playerWalkFrames.append(playerAtlas.textureNamed("alienPink_walk1"))
        playerWalkFrames.append(playerAtlas.textureNamed("alienPink_walk2"))
        playerJump = playerAtlas.textureNamed("alienPink_jump.png")
        playerDie = playerAtlas.textureNamed("alienPink_hit.png")
    }
}
