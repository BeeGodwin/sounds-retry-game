import GameplayKit

protocol ObstacleGeneratingProtocol {
    func nextActiveState() -> Bool
}

class RandomisedFibonnaciProgressiveDifficultyGenerator: ObstacleGeneratingProtocol {
    
    let fibonacci = [1, 1, 2, 3, 5, 8, 13, 21]
    
    var random = GKShuffledDistribution(forDieWithSideCount: 25)

    var difficultyIndex = 0
    
    let minGap = 3
    var gapCounter = 0

    let levelLength = 25
    var levelCounter = 0
    
    func nextActiveState() -> Bool {
        
        var state = false
        
        levelCounter += 1
        if levelCounter >= levelLength {
            levelCounter = 0
            difficultyIndex = min(difficultyIndex + 1, fibonacci.count - 1)
            random = GKShuffledDistribution(forDieWithSideCount: 20)
        }
        
        let difficulty = fibonacci[difficultyIndex]
         
        if gapCounter >= minGap {
            let roll = random.nextInt()
            if roll <= difficulty {
                gapCounter = 0
                state = true
            }
        } else {
            gapCounter += 1
        }
        
        return state
    }
}
