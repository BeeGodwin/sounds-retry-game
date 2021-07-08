import GameplayKit

struct GameConstants {
    
    // MARK: dev
    static let isDebugMode = true
    
    // MARK: parallax
    static let acceleration: CGFloat = 128.0
    static let maxSpeed: CGFloat = 256.0
    static let tileSize: CGFloat = 64.0

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
    
    // MARK: scoring
    static let obstaclePoints = 100
    
    // MARK: UI
    static let scoreLabelPosition = CGPoint(x: 192, y: 256)
    static let promptLabelPosition = CGPoint(x: 0, y: 160)
    
    // MARK: Strings
    static let startGamePromptText = "Tap to start!"
    static let gameOverPromptText = "Game over! Tap to retry."
    
    // MARK: Audio assets
    static let sounds = [
        "jump": ("boing", "wav"),
        "score": ("bing", "wav"),
        "die": ("no", "wav"),
        "music": ("ukeloop", "mp3"),
    ]
}
