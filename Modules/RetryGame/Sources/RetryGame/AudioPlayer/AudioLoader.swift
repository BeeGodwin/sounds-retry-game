import AVFoundation

class AudioLoader {
    
    func load(from soundDefinitions: [Sound: (String, String)]) -> [Sound: [AVAudioPlayer]] {
        
        var soundPlayers = [Sound: [AVAudioPlayer]]()
        
        soundDefinitions.forEach { (soundName: Sound, assetSet: (String, String)) in
            soundPlayers[soundName] = createAVAudioPlayerArray(for: assetSet)
        }
        
        return soundPlayers
    }
    
    private func createAVAudioPlayerArray(for assetSet: (String, String)) -> [AVAudioPlayer] {
        
        var players = [AVAudioPlayer]()
        
        let assetSetPaths = getPaths(for: assetSet)

        assetSetPaths.forEach { path in
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
    
    private func getPaths(for assetSet: (String, String)) -> [String] {
        
        let (prefix, fileType) = assetSet
        var paths = [String]()
        
        if let pathWithUnindexedPrefix = Bundle.main.path(forResource: prefix, ofType: fileType) {
            paths.append(pathWithUnindexedPrefix)
        }
    
        var index = 1
        var indexedPath: String?
        
        repeat {
            indexedPath = nil
            let indexedPrefix = prefix + String(index)
            if let path = Bundle.main.path(forResource: indexedPrefix, ofType: fileType) {
                indexedPath = path
                paths.append(path)
                index += 1
            }
        } while indexedPath != nil
        
        return paths
    }
}
