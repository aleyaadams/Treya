import UIKit

class StopwatchView: UILabel {

    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        self.textColor = UIColor(red:1.00, green:0.87, blue:0.68, alpha:1.0)
        self.font = FontHUDBig
    }
    

    func setSeconds(seconds:Int) {
        self.text = String(format: " %02i : %02i", seconds/60, seconds % 60)
    }
}
