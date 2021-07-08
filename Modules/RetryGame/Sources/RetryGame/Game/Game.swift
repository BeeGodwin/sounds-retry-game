import SpriteKit

class Game: ObserverProtocol { // TODO: this is becoming a bit bloated & needs splitting up
    private let container: GameContainerProtocol
    var gameState: GameState
    
    private var parallax: ParallaxRowSystem?
    private var player: Entity?

    
    init(container: GameContainerProtocol) {
        self.container = container
        gameState = .ready
    }
    
    func start() {
        guard let scene = container.scene else { return }
        let bus = container.eventBus
        bus.subscribe(to: .input, with: self)
        bus.subscribe(to: .game, with: self)
        
        container.uiManager.spawnUI(on: scene, eventBus: bus)
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
            print("unhandled event")
        }
    }
    
    func update(_ delta: TimeInterval) {
        if gameState != .running { return }
        parallax?.update(delta)
    }
    
    func playerCollidedWithObstacle() {
        let event = EventMessage(channel: .game, event: GameEvent.gameOver)
        container.eventBus.notify(of: event)
    }
    
    func playerLanded() {
        let event = EventMessage(channel: .control, event: ControlEvent.land)
        container.eventBus.notify(of: event)
    }
    
    private func handleInputEvent() {
        switch gameState {
        case .ready:
            let event = EventMessage(channel: .game, event: GameEvent.gameStart)
            container.eventBus.notify(of: event)
        case .running:
            let controlEvent = EventMessage(channel: .control, event: ControlEvent.jump)
            container.eventBus.notify(of: controlEvent)
        case .gameOver:
            container.retryNetwork()
            let event = EventMessage(channel: .game, event: GameEvent.gameReady)
            container.eventBus.notify(of: event)
            restartGame()
        }
    }
    
    private func handleGameEvent(_ event: GameEvent) {
        switch event {
        case .gameStart:
            gameState = .running
        case .gameOver:
            gameState = .gameOver
        case .gameReady:
            gameState = .ready
        }
    }
    
    private func handleGameStart() {
        gameState = .running
    }
    
    private func spawnGame() {
        spawnParallax()
        spawnPlayer()
    }
    
    private func restartGame() {
        guard let scene = container.scene, let playerNode = player?.skNode else { return }
        
        let resetScoreEvent = EventMessage(channel: .score, event: ScoreEvent.reset)
        container.eventBus.notify(of: resetScoreEvent)
        parallax?.destroy(scene: scene)
        scene.removeChildren(in: [playerNode])
        player = nil
        
        spawnGame()
    }
    
    private func spawnParallax() {
        guard let factory = container.factory, let scene = container.scene, let sceneWidth = scene.view?.bounds.width else { return }
        
        parallax = ParallaxRowSystem(maxSpeed: GameConstants.maxSpeed, acceleration: GameConstants.acceleration)

        let rows: [EntityPrototype] = [
            .parallaxRow(.cycling([.rowTile(.single(.stone, .center))],  ParallaxRowParameters(distance: 0.25, width: sceneWidth, y: 48))),
            .parallaxRow(.cycling([.rowTile(.single(.stone, .center)), .rowTile(.single(.dirt, .center))],  ParallaxRowParameters(distance: 0.5, width: sceneWidth, y: 32))),
            .parallaxRow(.cycling([.rowTile(.single(.dirt, .center)), .rowTile(.single(.stone, .center))],  ParallaxRowParameters(distance: 1, width: sceneWidth, y: 0, isGround: true))),
            .parallaxRow(.obstacles(ParallaxRowParameters(distance: 1, width: sceneWidth, y: 64))),
            .parallaxRow(.cycling([.rowTile(.single(.grass, .mid))],  ParallaxRowParameters(distance: 2, width: sceneWidth, y: -64))),
            .parallaxRow(.cycling([.rowTile(.single(.sand, .center))],  ParallaxRowParameters(distance: 4, width: sceneWidth, y: -192))),
        ]
        
        parallax?.spawn(rows, on: scene, from: factory)
    }
    
    private func spawnPlayer() {
        guard let factory = container.factory, let scene = container.scene else { return }
        
        player = factory.create(entity: .player)
        guard let playerNode = player?.skNode else { return }
        
        scene.addChild(playerNode)
        playerNode.position = GameConstants.startPosition
    }
}
