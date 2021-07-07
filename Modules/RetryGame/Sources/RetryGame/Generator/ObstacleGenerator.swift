import GameplayKit

protocol ObstacleGeneratingProtocol {
    func nextActiveState() -> Bool
}

class RandomisedFibonnaciProgressiveDifficultyGenerator: ObstacleGeneratingProtocol {
    
    let fibonacci = [1, 1, 2, 3, 5, 8, 13, 21]
    let levelLength = GameConstants.levelLength
    
    var random = GKShuffledDistribution(forDieWithSideCount: GameConstants.levelLength)
    
    var difficultyIndex = 0
    let minGap = 3
    var gapCounter = 0
    var levelCounter = 0
    
    func nextActiveState() -> Bool {
        
        var state = false
        
        levelCounter += 1
        if levelCounter >= GameConstants.levelLength {
            levelCounter = 0
            difficultyIndex = min(difficultyIndex + 1, fibonacci.count - 1)
            random = GKShuffledDistribution(forDieWithSideCount: GameConstants.levelLength)
        }
        
        let difficulty = fibonacci[difficultyIndex]
        
        let roll = random.nextInt()
        
        if gapCounter >= minGap && roll <= difficulty{
            gapCounter = 0
            state = true
            
        } else {
            gapCounter += 1
        }
        
        return state
    }
}
