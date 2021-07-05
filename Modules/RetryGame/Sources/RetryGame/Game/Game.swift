import SpriteKit

class Game: ObserverProtocol {
    
    private let container: GameContainerProtocol
    private var gameState: GameState
    
    private var parallax: ParallaxRowSystem?
    private var player: Entity?
    
    init(container: GameContainerProtocol) {
        self.container = container
        gameState = .ready
    }
    
    func start() {
        container.eventBus.subscribe(to: .input, with: self) // TODO: consider, should this be done here, or in scene / container?
        container.eventBus.subscribe(to: .game, with: self)
        spawnGame()
    }
    
    func receiveEvent(_ message: EventProtocol) {
        switch message.channel {
        case .input:
            handleInputEvent()
        case .game:
            if let gameEvent = message.event as? GameEvent {
                handleGameEvent(gameEvent)
            }
        default:
            print("unhandled event") // TODO: get rid
        }
    }
    
    func update(_ delta: TimeInterval) {
        if gameState != .running { return }
        parallax?.update(delta)
    }
    
    func playerCollidedWithObstacle() {
        print("game over")
        handleGameEnd()
    }
    
    
    private func handleInputEvent() {
        switch gameState {
        case .ready:
            let event = EventMessage(channel: .game, event: GameEvent.gameStart)
            container.eventBus.notify(of: event)
        case .running:
            let controlEvent = EventMessage(channel: .control, event: ControlEvent.playerAction)
            container.eventBus.notify(of: controlEvent)
        case .gameOver:
            container.retryNetwork()
            restartGame()
            gameState = .ready // TODO: should this drop straight into .running here?
        }
    }
    
    private func handleGameEvent(_ event: GameEvent) {
        switch event {
        case .gameStart:
            print("game start")
            gameState = .running
        case .gameOver:
            print("game over")
            gameState = .gameOver
        }
    }
    
    private func handleGameStart() {
        gameState = .running
    }
    
    private func handleGameEnd() {
        gameState = .gameOver
    }
    
    private func spawnGame() {
        spawnParallax()
        spawnPlayer()
    }
    
    private func restartGame() {
        guard let scene = container.scene, let playerNode = player?.skNode else { return }
        
        parallax?.destroy(scene: scene)
        scene.removeChildren(in: [playerNode])
        player = nil
        
        spawnGame()
    }
    
    private func spawnParallax() {
        guard let factory = container.factory, let scene = container.scene, let sceneWidth = scene.view?.bounds.width else { return }
        
        parallax = ParallaxRowSystem(maxSpeed: GameConstants.maxSpeed, acceleration: GameConstants.acceleration)
        
        let rows: [EntityPrototype] = [
            .parallaxRow(.cycling([.debug(.dark), .debug(.light)], ParallaxRowParameters(distance: 0.25, width: sceneWidth, y: 48))),
            .parallaxRow(.cycling([.debug(.light), .debug(.dark)], ParallaxRowParameters(distance: 0.5, width: sceneWidth, y: 32))),
            .parallaxRow(.cycling([.debug(.dark), .debug(.light)], ParallaxRowParameters(distance: 1, width: sceneWidth, y: 0, isGround: true))),
            .parallaxRow(.obstacles),
            .parallaxRow(.cycling([.debug(.light), .debug(.dark)], ParallaxRowParameters(distance: 2, width: sceneWidth, y: -64))),
        ]
        
        parallax?.spawn(rows, on: scene, from: factory)
        
        
    }
    
    private func spawnPlayer() {
        guard let factory = container.factory, let scene = container.scene else { return }
        
        let player = factory.create(entity: .player)
        scene.addChild(player.skNode)
        player.skNode.position = GameConstants.startPosition
    }
}
