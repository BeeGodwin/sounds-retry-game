import GameplayKit

class ParallaxRowSystem {
    
    let system: GKComponentSystem<ParallaxRowComponent>
    var rows: [Entity]
    
    var maxSpeed: CGFloat

    
    init(maxSpeed: CGFloat) {
        system = GKComponentSystem(componentClass: ParallaxRowComponent.self)
        rows = [Entity]()
        self.maxSpeed = maxSpeed
    }
    
    func spawn(rows toSpawn: [EntityPrototype], on scene: GameScene, from factory: EntityFactoryProtocol) {
        toSpawn.forEach { prototype in
            let rowEntity = factory.create(entity: prototype)
            addRow(on: rowEntity)
            scene.addChild(rowEntity.skNode)
        }
    }
    
    func addRow(on entity: Entity) {
        rows.append(entity)
        system.addComponent(foundIn: entity)
    }
    
    func update(_ delta: TimeInterval) {
        system.components.forEach { $0.moveBy(delta: CGFloat(delta) * maxSpeed) }
    }
}
