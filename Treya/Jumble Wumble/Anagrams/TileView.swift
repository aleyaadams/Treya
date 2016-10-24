import Foundation
import UIKit

protocol TileDragDelegateProtocol {
    func tileView(tileView: TileView, didDragToPoint: CGPoint)
}


class TileView:UIImageView {
    
    var letter: Character
    
    
    var isMatched: Bool = false
    
    private var xOffset: CGFloat = 0.0
    private var yOffset: CGFloat = 0.0
    
    var dragDelegate: TileDragDelegateProtocol?
    
    private var tempTransform: CGAffineTransform = CGAffineTransformIdentity
    
    
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(letter:, sideLength:")
    }
    
    init(letter:Character, sideLength:CGFloat) {
        self.letter = letter
        

        let image = UIImage(named: "Tile")!
        

        super.init(image:image)
        

        let scale = sideLength / image.size.width
        self.frame = CGRect(x: 0, y: 0, width: 130, height: 130)
        

        let letterLabel = UILabel(frame: self.bounds)
        letterLabel.textAlignment = NSTextAlignment.Center
        letterLabel.textColor = UIColor(red:0.11, green:0.60, blue:0.55, alpha:1.0)
        letterLabel.backgroundColor = UIColor.clearColor()
        letterLabel.text = String(letter).uppercaseString
        letterLabel.font = UIFont(name: "MarkerFelt-Thin", size: 75.0)
        self.addSubview(letterLabel)
        
        self.userInteractionEnabled = true

        self.layer.shadowColor = UIColor.blackColor().CGColor
        self.layer.shadowOpacity = 0
        self.layer.shadowOffset = CGSizeMake(10.0, 10.0)
        self.layer.shadowRadius = 15.0
        self.layer.masksToBounds = false
        
        let path = UIBezierPath(rect: self.bounds)
        self.layer.shadowPath = path.CGPath
        
    }
    
    func randomize() {

        let rotation = CGFloat(randomNumber(minX:0, maxX:50)) / 100.0 - 0.2
        self.transform = CGAffineTransformMakeRotation(rotation)
        

        let yOffset = CGFloat(randomNumber(minX: 0, maxX: 10) - 10)
        self.center = CGPointMake(self.center.x, self.center.y + yOffset)
    }
        override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let point = touch.locationInView(self.superview)
            xOffset = point.x - self.center.x
            yOffset = point.y - self.center.y
            
        }

        tempTransform = self.transform

        self.transform = CGAffineTransformScale(self.transform, 1.2, 1.2)
        
        self.superview?.bringSubviewToFront(self)
    }
    

    override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        if let touch = touches.first as? UITouch {
            let point = touch.locationInView(self.superview)
            self.center = CGPointMake(point.x - xOffset, point.y - yOffset)
        }
    }
    

    override func touchesEnded(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.touchesMoved(touches, withEvent: event)
        

        self.transform = tempTransform
        
        dragDelegate?.tileView(self, didDragToPoint: self.center)
        self.layer.shadowOpacity = 0.0
    }
    

    override func touchesCancelled(touches: Set<NSObject>!, withEvent event: UIEvent!) {
        self.transform = tempTransform

    }
}