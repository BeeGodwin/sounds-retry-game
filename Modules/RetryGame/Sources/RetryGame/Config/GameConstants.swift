import GameplayKit

struct GameConstants {
    
    // MARK: dev
    static let isDebugMode = true
    static let audioVolume: Float = 1.0
    
    // MARK: parallax
    static let acceleration: CGFloat = 128.0
    static let maxSpeed: CGFloat = 256.0
    static let tileSize: CGFloat = 64.0
    
    // MARK: animation
    static let defaultFrameInterval = 0.1

    // MARK: player
    static let startPosition: CGPoint = CGPoint(x: -128, y: 64)
    static let jumpForce: CGFloat = 650.0
    
    // MARK: world
    static let collisionBitMask: UInt32 = 0x00001
    static let playerName = "player"
    static let obstacleName = "obstacle"
    static let floorName = "floor"
    
    // MARK: obstacle generation
    static let levelLength = 25
    static let obstacleSprites: [Sprite] = [.bee, .ladybug, .saw, .slimeBlock, .slimePurple, .snail]
    
    // MARK: scoring
    static let obstaclePoints = 100
    
    // MARK: UI
    static let scoreLabelPosition = CGPoint(x: 192, y: 256)
    static let promptLabelPosition = CGPoint(x: 0, y: 160)
    
    // MARK: Strings
    static let startGamePromptText = "Tap to start!"
    static let gameOverPromptText = "Game over! Tap to retry."
    
    // MARK: Obviously this is a horrible way to import assets for anything real, there should be a build script.

    // MARK: Audio assets
    static let sounds: [Sound: (String, String)] = [
        .jump: ("boing", "wav"),
        .score: ("bing", "wav"),
        .die: ("no", "wav"),
        .music: ("ukeloop", "mp3"),
    ]
        
    // MARK: Sprite assets
    static let spriteAtlas = "sprite"
    
    static let sprites: [Sprite: [String]] = [
        .playerWalk: ["alienPink_walk1", "alienPink_walk2"],
        .playerJump: ["alienPink_jump1"],
        .playerDie: ["alienPink_hit1"],
        .bee: ["bee1", "bee2"],
        .ladybug: ["ladybug1", "ladybug2"],
        .saw: ["saw1", "saw2"],
        .slimeBlock: ["slimeBlock1", "slimeBlock2"],
        .slimePurple: ["slimePurple1", "slimePurple2"],
        .snail: ["snail1", "snail2"],
    ]
    
    static let worldAtlas = "world"
    
    static let groundTileNames: [TextureSet: [String]] = [
        .dirt: ["dirtMid", "dirtCenter"],
        .grass: ["grassMid", "grassCenter"],
        .planet: ["planetMid", "planetCenter"],
        .sand: ["sandMid", "sandCenter"],
        .stone: ["stoneMid", "stoneCenter"],
    ]
}
