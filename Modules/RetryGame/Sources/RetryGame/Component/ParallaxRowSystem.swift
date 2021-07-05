import GameplayKit

class ParallaxRowSystem {
    
    private let system: GKComponentSystem<ParallaxRowComponent>
    private var rows: [Entity]
    private var speed: CGFloat = 0
    private var maxSpeed: CGFloat
    private var acceleration: CGFloat

    init(maxSpeed: CGFloat, acceleration: CGFloat) {
        system = GKComponentSystem(componentClass: ParallaxRowComponent.self)
        rows = [Entity]()
        self.maxSpeed = maxSpeed
        self.acceleration = acceleration
    }
        
    func update(_ delta: TimeInterval) {
        let timeDelta = CGFloat(delta)
        speed = min(speed + (acceleration * timeDelta), maxSpeed)
        system.components.forEach { $0.moveBy(delta: timeDelta * speed) }
    }
    
    func spawn(_ rows: [EntityPrototype], on scene: GameScene, from factory: EntityFactoryProtocol) {
        rows.forEach { prototype in
            let rowEntity = factory.create(entity: prototype)
            addRow(on: rowEntity)
            scene.addChild(rowEntity.skNode)
        }
    }
    
    func destroy(scene: GameScene) {
        rows.forEach { row in
            system.removeComponent(foundIn: row)
            scene.removeChildren(in: [row.skNode])
        }
    }
    
    private func addRow(on entity: Entity) {
        rows.append(entity)
        system.addComponent(foundIn: entity)
    }
}
