import SpriteKit

class GameView: SKView {
    
    var inputManager: InputManager!
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let input = inputManager else { print("input manager not initialised"); return }
        
        input.touchStart()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let input = inputManager else { print("input manager not initialised"); return }
        input.touchEnd()
    }
}
