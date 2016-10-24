import Foundation

class GameData {
    var points:Int = 0 {
        didSet {
            points = max(points, 0)
        }
    }
}

