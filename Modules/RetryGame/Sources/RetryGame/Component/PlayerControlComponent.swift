import GameplayKit

enum PlayerJumpState {
    case jumping
    case grounded
}

class PlayerControlComponent: GKComponent, ObserverProtocol {
    
    let eventBus: EventBusProtocol
    let physicsBody: SKPhysicsBody
    var jumpState: PlayerJumpState = .grounded
    var sprite: SKSpriteNode
    var textureManager: TextureManager // TODO: this is a bit crap and tightly coupled
    
    init(eventBus: EventBusProtocol, physicsBody: SKPhysicsBody, spriteNode: SKSpriteNode, textureManager: TextureManager) {
        self.eventBus = eventBus
        self.physicsBody = physicsBody
        self.sprite = spriteNode
        self.textureManager = textureManager
        super.init()
        eventBus.subscribe(to: .control, with: self)
        eventBus.subscribe(to: .game, with: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func receiveEvent(_ message: EventProtocol) {
        switch message.channel {
        case .control:
            if let controlEvent = message.event as? ControlEvent { handleControlEvent(controlEvent) }
        case .game:
            if let gameEvent = message.event as? GameEvent { handleGameEvent(gameEvent) }
        default:
            print("unhandled event")
        }
        
    }
    
    private func handleControlEvent(_ event: ControlEvent) {
        switch event {
        case .jump:
            handleJump()
        case .land:
            handleLanding() // TODO: we're inadvertently starting with this action so it always fires.
        }
    }
    
    private func handleGameEvent(_ event: GameEvent) {
        switch event {
        case .gameOver:
            physicsBody.isDynamic = false
            die()
        case .gameReady:
            physicsBody.isDynamic = true
            ready()
        case .gameStart:
            walk()
        }
    }
    
    private func handleJump() {
        if case .grounded = jumpState {
            physicsBody.velocity = CGVector(dx: 0, dy: GameConstants.jumpForce)
            jumpState = .jumping
            if let jumpTexture = textureManager.getPlayerJump() {
                sprite.removeAllActions()
                sprite.texture = jumpTexture
            }
        }
    }
    
    private func handleLanding() {
        jumpState = .grounded
        walk()
    }
    
    private func walk() {
        let walkTextures = textureManager.getPlayerWalk()
        if walkTextures.count > 0 {
            sprite.run(SKAction.repeatForever(
                        SKAction.animate(with: walkTextures, timePerFrame: 0.1, resize: true, restore: false)))
        }
    }
    
    private func ready() {
        let walkTextures = textureManager.getPlayerWalk()
        if walkTextures.count > 0 {
            sprite.removeAllActions()
            sprite.texture = walkTextures[0]
        }
    }
    
    private func die() {
        sprite.removeAllActions()
        if let dieTexture = textureManager.getPlayerDie() {
            sprite.texture = dieTexture
        }
    }
    
}

extension Entity {
    func addPlayerControlComponent(_ component: PlayerControlComponent) {
        self.addComponent(component)
    }
}
