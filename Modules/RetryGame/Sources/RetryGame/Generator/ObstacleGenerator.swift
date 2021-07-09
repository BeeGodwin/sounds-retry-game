import GameplayKit

protocol ObstacleGeneratingProtocol {
    func nextActiveState() -> Bool
}

class RandomisedProgressiveDifficultyGenerator: ObstacleGeneratingProtocol {
    
    let difficultyLevels = GameConstants.difficultyLevels
    let levelLength = GameConstants.levelLength
    let minGap = GameConstants.minimumGap
    
    var random = GKShuffledDistribution(forDieWithSideCount: GameConstants.levelLength)
    
    var difficultyIndex = 0
    var gapCounter = 0
    var levelCounter = 0
    
    func nextActiveState() -> Bool {
        
        var state = false
        
        levelCounter += 1
        if levelCounter >= GameConstants.levelLength {
            levelCounter = 0
            difficultyIndex = min(difficultyIndex + 1, difficultyLevels.count - 1)
            random = GKShuffledDistribution(forDieWithSideCount: GameConstants.levelLength)
        }
        
        let difficulty = difficultyLevels[difficultyIndex]
        
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
