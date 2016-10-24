import Foundation
import UIKit

class TargetView: UIImageView {
    var letter: Character
    var isMatched:Bool = false
    

    required init(coder aDecoder:NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }
    
    init(letter:Character, sideLength:CGFloat) {
        self.letter = letter
        
        let image = UIImage(named: "Slot")!
        super.init(image:image)
        
        let scale = sideLength / image.size.width
        self.frame = CGRectMake(0, 0, 130, 130)
    }
}