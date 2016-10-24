import Foundation
struct Grade {
    let pointsPerTile: Int
    let timeToSolve: Int
    var anagrams: [NSArray]
    
    
    init (gradeNumber: Int) {
        let fileName = "grade\(gradeNumber).plist"
        let gradePath = "\(NSBundle.mainBundle().resourcePath!)/\(fileName)"
        
        
        let gradeDictionary: NSDictionary? = NSDictionary(contentsOfFile: gradePath)
        

        assert(gradeDictionary != nil, "Level configuration file not found")
        

        self.pointsPerTile = gradeDictionary!["pointsPerTile"] as! Int
        self.timeToSolve = gradeDictionary!["timeToSolve"] as! Int
        self.anagrams = gradeDictionary!["anagrams"] as! [NSArray]
    }
}

