import SpriteKit

class Game: ObserverProtocol {
    private let container: GameContainerProtocol
    private let spawner: GameSpawnerProtocol
    var gameState: GameState
    
    private var parallax: ParallaxRowSystem?
    private var player: Entity?

    
    init(container: GameContainerProtocol, spawner: GameSpawnerProtocol) {
        self.container = container
        self.spawner = spawner
        gameState = .ready
    }
    
    func start() {
        guard let scene = container.scene else { return }
        let bus = container.eventBus
        bus.subscribe(to: .input, with: self)
        bus.subscribe(to: .game, with: self)
        
        spawnGame()
        container.uiManager.spawnUI(on: scene, eventBus: bus)

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
        parallax = spawner.spawnParallax(in: scene, of: sceneWidth, using: factory)
    }
    
    private func spawnPlayer() {
        guard let factory = container.factory, let scene = container.scene else { return }
        player = spawner.spawnPlayer(in: scene, using: factory)
    }
}
