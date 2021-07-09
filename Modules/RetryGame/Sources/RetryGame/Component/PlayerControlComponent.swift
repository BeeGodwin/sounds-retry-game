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
    let animator: AnimatorComponent
    var textureManager: TextureManager
    
    init(eventBus: EventBusProtocol, physicsBody: SKPhysicsBody, spriteNode: SKSpriteNode, textureManager: TextureManager, animator: AnimatorComponent) {
        self.eventBus = eventBus
        self.physicsBody = physicsBody
        self.sprite = spriteNode
        self.textureManager = textureManager
        self.animator = animator
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
            handleLanding()
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
            jumpState = .jumping
            physicsBody.velocity = CGVector(dx: 0, dy: GameConstants.jumpForce)
            animator.updateAnimation(with: textureManager.getAnimationFrames(for: .playerJump))
        }
    }
    
    private func handleLanding() {
        jumpState = .grounded
        walk()
    }
    
    private func walk() {
        animator.updateAnimation(with: textureManager.getAnimationFrames(for: .playerWalk))
    }
    
    private func ready() {
        if let singleWalkFrame = textureManager.getAnimationFrames(for: .playerWalk).first {
            animator.updateAnimation(with: [singleWalkFrame])
        }
    }
    
    private func die() {
        animator.updateAnimation(with: textureManager.getAnimationFrames(for: .playerDie))
    }
    
}

extension Entity {
    func addPlayerControlComponent(_ component: PlayerControlComponent) {
        self.addComponent(component)
    }
}
