import SpriteKit

protocol TextureManagerProtocol {
    func getTexture(named textureName: String) -> SKTexture?
}

class TextureManager: TextureManagerProtocol {
    
    private static var LIGHT_GREY = "debug_lightgrey"
    private static var DARK_GREY = "debug_darkgrey"
    
    private lazy var textures = [String: SKTexture]()
    
    init() {
        loadDebugTextures()
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
    
    private func loadDebugTextures() {
        if let lightGreyImage = UIImage(named: Self.LIGHT_GREY, in: .module, compatibleWith: nil) {
            textures[Self.LIGHT_GREY] = SKTexture(image: lightGreyImage)
        }
        if let darkGreyImage = UIImage(named: Self.DARK_GREY, in: .module, compatibleWith: nil) {
            textures[Self.DARK_GREY] = SKTexture(image: darkGreyImage)
        }
    }
}
