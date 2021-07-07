import AVFoundation

class AudioLoader {
    
    func load(pathFragments: [(String, String)]) -> [AVAudioPlayer] {
        
        var players = [AVAudioPlayer]()
        
        var paths = [String]()
        
        pathFragments.forEach { (prefix, fileType) in
            if let barePath = Bundle.main.path(forResource: prefix, ofType: fileType) {
                paths.append(barePath)
            }
            
            var count = 1
            var indexedPath: String?
            
            repeat {
                let indexedPrefix = prefix + String(count)
                if let path = Bundle.main.path(forResource: indexedPrefix, ofType: fileType) {
                    indexedPath = path
                    paths.append(path)
                    count += 1
                } else {
                    indexedPath = nil
                }
            } while indexedPath != nil
            
        }
        
        paths.forEach { path in
            let url = URL(fileURLWithPath: path)
            do {
                let audioPlayer = try AVAudioPlayer(contentsOf: url)
                players.append(audioPlayer)
            } catch {
                print("failed with \(path)")
            }
        }
    
    return players
    }
}



