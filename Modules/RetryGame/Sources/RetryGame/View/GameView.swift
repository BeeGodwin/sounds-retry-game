import SpriteKit

class GameView: SKView {
    
    var inputManager: InputManager!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let input = inputManager { input.touchStart() }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let input = inputManager { input.touchEnd() }
    }
}
