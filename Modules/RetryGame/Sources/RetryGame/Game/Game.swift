import SpriteKit

class Game: ObserverProtocol {
    
    let container: GameContainerProtocol
    let scene: GameScene
    
    init(container: GameContainerProtocol, scene: GameScene) {
        self.container = container
        self.scene = scene
    }
    
    func start() {
        createEntities()
    }
    
    func receiveEvent(_ message: EventProtocol) {
        print("\(message.channel) : \(message.event)")
    }
    
    func createEntities() {
        container.eventBus.subscribe(to: .input, with: self)
        
        if let factory: DebugEntityFactory = container.factory {
            if let lightEntity = factory.build(.light) {
                lightEntity.position = CGPoint(x: 0, y: 0)
                scene.addChild(lightEntity)
            }
            if let darkEntity = factory.build(.dark) {
                darkEntity.position = CGPoint(x: 64, y: 0)
                scene.addChild(darkEntity)
            }
        }
    }
    
    func update() {
        
    }
}
