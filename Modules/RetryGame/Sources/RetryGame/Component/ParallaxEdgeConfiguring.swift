import SpriteKit

protocol ParallaxEdgeConfiguring {
    func configureNode(_ node: SKNode)
}

class CyclingEdge: ParallaxEdgeConfiguring {
    
    let textures: [SKTexture]
    var index = 0
    
    init(with textures: [SKTexture]) {
        self.textures = textures
    }
    
    func configureNode(_ node: SKNode) {
        node.children.forEach { childNode in
            if let sprite = childNode as? SKSpriteNode {
                sprite.texture = textures[index]
                index = (index + 1) % textures.count
                return
            }
        }
    }
}

class ObstacleEdge: ParallaxEdgeConfiguring {
    
    let entities: [Entity]
    let eventBus: EventBusProtocol
    let generator: ObstacleGeneratingProtocol
    
    var tempCount = 0
    
    init(entities: [Entity], eventBus: EventBusProtocol, generator: ObstacleGeneratingProtocol) {
        self.entities = entities
        self.eventBus = eventBus
        self.generator = generator
    }
    
    func configureNode(_ node: SKNode) {
        guard let nodeEntity = entities.first(where: { $0.skNode === node}) else { return }
        
        scoreIfWasActive(nodeEntity)
        
        if let controlComponent = nodeEntity.component(ofType: ObstacleControlComponent.self) {
            controlComponent.setActive(generator.nextActiveState())
        }
    }
    
    private func scoreIfWasActive(_ entity: Entity) {
        guard let spriteComponent = entity.component(ofType: SpriteComponent.self) else { return }
        if spriteComponent.sprite.isHidden { return }
        
        let event = EventMessage(channel: .score, event: ScoreEvent.incrementBy(GameConstants.obstaclePoints))
        eventBus.notify(of: event)
    }
}
