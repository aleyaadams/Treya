

import UIKit

class HUDView: UIView {
    
    var stopwatch: StopwatchView
    var gamePoints: CounterLabelView
    

    

    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame:CGRect) {
        self.stopwatch = StopwatchView(frame:CGRectMake(ScreenWidth/2-350, 0, 350, 100))
        self.stopwatch.setSeconds(0)
        

        self.gamePoints = CounterLabelView(font: FontHUD, frame: CGRectMake(ScreenWidth-210, 15, 200, 70))
        gamePoints.textColor = UIColor(red:0.11, green:0.60, blue:0.55, alpha:1.0)
        gamePoints.value = 0
        
        super.init(frame:frame)
        
        self.addSubview(gamePoints)
        

        var pointsLabel = UILabel(frame: CGRectMake(ScreenWidth-400, 15, 140, 70))
        pointsLabel.backgroundColor = UIColor.clearColor()
        pointsLabel.font = FontHUD
        pointsLabel.text = " Points:"
        pointsLabel.textColor = UIColor(red:1.00, green:0.87, blue:0.68, alpha:1.0)
        self.addSubview(pointsLabel)
        
        self.addSubview(self.stopwatch)
        
        self.userInteractionEnabled = true
      

    }
    
    override func hitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {

        let hitView = super.hitTest(point, withEvent: event)
        

        if hitView is UIButton {
            return hitView
        }
        

        return nil
    }
    
}
