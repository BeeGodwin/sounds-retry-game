import SpriteKit

protocol GameSpawnerProtocol {
    func spawnParallax(in scene: GameScene, of width: CGFloat, using factory: EntityFactoryProtocol) -> ParallaxRowSystem
    func spawnPlayer(in scene: GameScene, using factory: EntityFactoryProtocol) -> Entity
}

class GameSpawner: GameSpawnerProtocol {
    func spawnParallax(in scene: GameScene, of width: CGFloat, using factory: EntityFactoryProtocol) -> ParallaxRowSystem {
        
        let parallax = ParallaxRowSystem(maxSpeed: GameConstants.maxSpeed, acceleration: GameConstants.acceleration)

        let rows: [EntityPrototype] = [
            .parallaxRow(.cycling([.rowTile(.single(.planet, .center))], ParallaxRowParameters(distance: 0.125, width: width, y: 314, scale: 32))),
            .parallaxRow(.cycling([.rowTile(.single(.planet, .center))], ParallaxRowParameters(distance: 0.125, width: width, y: 160, scale: 32))),
            .parallaxRow(.cycling([.rowTile(.single(.dirt, .mid))], ParallaxRowParameters(distance: 0.25, width: width, y: 72))),
            .parallaxRow(.cycling([.rowTile(.single(.dirt, .mid))],  ParallaxRowParameters(distance: 0.5, width: width, y: 48))),
            .parallaxRow(.cycling([.rowTile(.single(.grass, .mid))],  ParallaxRowParameters(distance: 1, width: width, y: 0, isGround: true))),
            .parallaxRow(.obstacles(ParallaxRowParameters(distance: 1, width: width, y: 64))),
            .parallaxRow(.cycling([.rowTile(.single(.sand, .center))],  ParallaxRowParameters(distance: 2, width: width, y: -96))),
            .parallaxRow(.cycling([.rowTile(.single(.sand, .center))],  ParallaxRowParameters(distance: 4, width: width, y: -256))),
            .parallaxRow(.cycling([.rowTile(.single(.sand, .center))],  ParallaxRowParameters(distance: 8, width: width, y: -576))),
        ]
        parallax.spawn(rows, on: scene, from: factory)
        return parallax
    }
    
    func spawnPlayer(in scene: GameScene, using factory: EntityFactoryProtocol) -> Entity {
        let player = factory.create(entity: .player)
        scene.addChild(player.skNode)
        player.skNode.position = GameConstants.startPosition
        return player
    }
}
