import UIKit

class CounterLabelView: UILabel {

    var value:Int = 0 {

        didSet {
            self.text = " \(value)"
        }
    }
    
    private var endValue: Int = 0
    private var timer: NSTimer? = nil
    
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(font:frame:")
    }
    

    init(font:UIFont, frame:CGRect) {
        super.init(frame:frame)
        self.font = font
        self.backgroundColor = UIColor.clearColor()
    }
    
    func updateValue(timer:NSTimer) {

        if (endValue < value) {
            value -= 1
        } else {
            value += 1
        }
        

        if (endValue == value) {
            timer.invalidate()
            self.timer = nil
        }
    }
    

    func setValue(newValue:Int, duration:Float) {

        endValue = newValue
        

        if timer != nil {
            timer?.invalidate()
            timer = nil
        }
        

        let deltaValue = abs(endValue - value)
        if (deltaValue != 0) {
            var interval = Double(duration / Float(deltaValue))
            if interval < 0.01 {
                interval = 0.01
            }
            
           timer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector:"updateValue:", userInfo: nil, repeats: true)
        }
    }
}
