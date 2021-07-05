import GameplayKit

class ParallaxRowSystem {
    
    private let system: GKComponentSystem<ParallaxRowComponent>
    private var rows: [Entity]
    private var maxSpeed: CGFloat

    init(maxSpeed: CGFloat) {
        system = GKComponentSystem(componentClass: ParallaxRowComponent.self)
        rows = [Entity]()
        self.maxSpeed = maxSpeed
    }
        
    func update(_ delta: TimeInterval) {
        system.components.forEach { $0.moveBy(delta: CGFloat(delta) * maxSpeed) }
    }
    
    func spawn(_ rows: [EntityPrototype], on scene: GameScene, from factory: EntityFactoryProtocol) {
        rows.forEach { prototype in
            let rowEntity = factory.create(entity: prototype)
            addRow(on: rowEntity)
            scene.addChild(rowEntity.skNode)
        }
    }
    
    private func addRow(on entity: Entity) {
        rows.append(entity)
        system.addComponent(foundIn: entity)
    }
}
