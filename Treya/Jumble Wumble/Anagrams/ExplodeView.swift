

import Foundation
import UIKit

class ExplodeView: UIView {
    private var emitter:CAEmitterLayer!
    
    required init(coder aDecoder:NSCoder) {
        fatalError("use init(frame:")
    }
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        

        emitter = self.layer as! CAEmitterLayer
        emitter.emitterPosition = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
        emitter.emitterSize = self.bounds.size
        emitter.emitterMode = kCAEmitterLayerAdditive
        emitter.emitterShape = kCAEmitterLayerRectangle
    }
    

    override class func layerClass() -> AnyClass {
        return CAEmitterLayer.self
    }
    
    override func didMoveToSuperview() {

        super.didMoveToSuperview()
        if self.superview == nil {
            return
        }
        

        let texture:UIImage? = UIImage(named:"particle")
        assert(texture != nil, "particle image not found")
        
        let emitterCell = CAEmitterCell()
        
        emitterCell.contents = texture!.CGImage
        
        emitterCell.name = "cell"
        
        emitterCell.birthRate = 1000
        emitterCell.lifetime = 0.75
        
        emitterCell.blueRange = 0.33
        emitterCell.blueSpeed = -0.33
        
        emitterCell.velocity = 160
        emitterCell.velocityRange = 40
        
        emitterCell.scaleRange = 0.5
        emitterCell.scaleSpeed = -0.2
        
        emitterCell.emissionRange = CGFloat(M_PI*2)
        
        emitter.emitterCells = [emitterCell]
        
        var delay = Int64(0.1 * Double(NSEC_PER_SEC))
        var delayTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.disableEmitterCell()
        }
        
        delay = Int64(2 * Double(NSEC_PER_SEC))
        delayTime = dispatch_time(DISPATCH_TIME_NOW, delay)
        dispatch_after(delayTime, dispatch_get_main_queue()) {
            self.removeFromSuperview()
        }
    }
    
    func disableEmitterCell() {
        emitter.setValue(0, forKeyPath: "emitterCells.cell.birthRate")
    }
    
}