import AVFoundation

class AudioLoader {
    
    func load(from soundDefinitions: [String: (String, String)]) -> [String: [AVAudioPlayer]] {
        
        var soundPlayers = [String: [AVAudioPlayer]]()
        
        // TODO: decompose this spaghetti
        soundDefinitions.forEach { (soundName: String, assetSet: (String, String)) in
            let (prefix, fileType) = assetSet
            var paths = [String]()
            var players = [AVAudioPlayer]()
                if let barePath = Bundle.main.path(forResource: prefix, ofType: fileType) {
                    paths.append(barePath)
                }
                
                var count = 1
                var indexedPath: String?
                
                repeat {
                    indexedPath = nil
                    let indexedPrefix = prefix + String(count)
                    if let path = Bundle.main.path(forResource: indexedPrefix, ofType: fileType) {
                        indexedPath = path
                        paths.append(path)
                        count += 1
                    }
                } while indexedPath != nil

            paths.forEach { path in
                let url = URL(fileURLWithPath: path)
                do {
                    let audioPlayer = try AVAudioPlayer(contentsOf: url)
                    players.append(audioPlayer)
                } catch {
                    print("failed with \(path)")
                }
            }
            soundPlayers[soundName] = players
        }
        return soundPlayers
    }
}
