import Foundation
import UIKit
import SpriteKit

class GameController {
    var gameView: UIView!
    var grade: Grade!
    
    private var tiles = [TileView]()
    private var targets = [TargetView]()
    private var gameCounter = 0
    private var points = 0
    
    var hud:HUDView! {
        didSet {

        }
    }
    

    private var secondsLeft: Int = 0
    private var timer: NSTimer?
    private var data = GameData()
    private var audioController: AudioController
    
    var onAnagramSolved:( () -> ())!
    var whenOver:( () -> ())!
    
    init() {
        self.audioController = AudioController()
       self.audioController.preloadAudioEffects(AudioEffectFiles)
   }


    
    
    func dealRandomAnagram () {
       if self.data.points >= 200 {
            self.clearBoard()
            self.stopStopwatch()
            self.data.points = 0
            hud.gamePoints.setValue(data.points, duration: 0.25)
            self.whenOver()
        }
    
        self.clearBoard()
        assert(grade.anagrams.count > 0, "no level loaded")
        

        let randomIndex = randomNumber(minX:0, maxX:UInt32(grade.anagrams.count-1))
        let anagramPair = grade.anagrams[randomIndex]
        
        
        let anagram1 = anagramPair[0] as! String
        let anagram2 = anagramPair[1] as! String
        
        
        let anagram1length = count(anagram1)
        let anagram2length = count(anagram2)
        
        
        println("phrase1[\(anagram1length)]: \(anagram1)")
        println("phrase2[\(anagram2length)]: \(anagram2)")
        
        let tileSide = ceil(ScreenWidth * 0.9 / CGFloat(max(anagram1length, anagram2length))) - TileMargin
        
        var xOffset = (ScreenWidth - CGFloat(max(anagram1length, anagram2length)) * (tileSide + TileMargin)) / 2.0
        
        xOffset += tileSide / 2.0
        
        targets = []
        
        for (index, letter) in enumerate(anagram2) {
            if letter != " " {
                let target = TargetView(letter: letter, sideLength: tileSide)
                target.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4)
                
                gameView.addSubview(target)
                targets.append(target)
                
                
            }
        }
        
        tiles = []
        
        for (index, letter) in enumerate(anagram1) {
            if letter != " " {
                let tile = TileView(letter: letter, sideLength: tileSide)
                tile.center = CGPointMake(xOffset + CGFloat(index)*(tileSide + TileMargin), ScreenHeight/4*3)
                
                tile.randomize()
                tile.dragDelegate = self
                
                gameView.addSubview(tile)
                tiles.append(tile)
                
            }
        }
        
        
        
        
    }
    
    func placeTile(tileView: TileView, targetView: TargetView) {
        
        targetView.isMatched = true
        tileView.isMatched = true
        
        
        tileView.userInteractionEnabled = false
        
        
        UIView.animateWithDuration(0.35,
            delay:0.00,
            options:UIViewAnimationOptions.CurveEaseOut,
            
            animations: {
                tileView.center = targetView.center
                tileView.transform = CGAffineTransformIdentity
            },
            
            completion: {
                (value:Bool) in
                targetView.hidden = true
        })
        
        let explode = ExplodeView(frame:CGRectMake(tileView.center.x, tileView.center.y, 10,10))
        tileView.superview?.addSubview(explode)
        tileView.superview?.sendSubviewToBack(explode)
    }
    
    
    func checkForSuccess() {
        for targetView in targets {
            if !targetView.isMatched {
                return
            }
                }
        
        
        
        audioController.playEffect(SoundWin)
        
        let firstTarget = targets[0]
        let startX:CGFloat = 0
        let endX:CGFloat = ScreenWidth + 300
        let startY = firstTarget.center.y
        
        let stars = StardustView(frame: CGRectMake(startX, startY, 10, 10))
        gameView.addSubview(stars)
        gameView.sendSubviewToBack(stars)
        
        UIView.animateWithDuration(3.0,
            delay:0.0,
            options:UIViewAnimationOptions.CurveEaseOut,
            animations:{
                stars.center = CGPointMake(endX, startY)
            }, completion: {(value:Bool) in
                stars.removeFromSuperview()
                

                self.clearBoard()
                self.dealRandomAnagram()


                
        })
    }
    
    func startStopwatch() {
        secondsLeft = grade.timeToSolve
        hud.stopwatch.setSeconds(secondsLeft)
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector:"tick:", userInfo: nil, repeats: true)
    }
    
    func stopStopwatch() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc func tick(timer: NSTimer) {
        secondsLeft++
        hud.stopwatch.setSeconds(secondsLeft)

    }
    
    @IBAction func buttonTapped (sender: UIButton!) {


    }
    
    func clearBoard() {
        tiles.removeAll(keepCapacity: false)
        targets.removeAll(keepCapacity: false)
        for view in gameView.subviews  {
            view.removeFromSuperview()
        }
    }
    
}

extension GameController:TileDragDelegateProtocol {
    func tileView(tileView: TileView, didDragToPoint point: CGPoint) {
        var targetView: TargetView?
        for tv in targets {
            if tv.frame.contains(point) && !tv.isMatched {
                targetView = tv
                break
            }
        }
        
        if let targetView = targetView {
            
            if targetView.letter == tileView.letter {
                
                self.placeTile(tileView, targetView: targetView)
                
                
                audioController.playEffect(SoundDing)
                
                data.points += grade.pointsPerTile
                hud.gamePoints.setValue(data.points, duration: 0.5)
                
                self.checkForSuccess()
                
            } else {
                
                tileView.randomize()
                
                UIView.animateWithDuration(0.35,
                    delay:0.00,
                    options:UIViewAnimationOptions.CurveEaseOut,
                    animations: {
                        tileView.center = CGPointMake(tileView.center.x + CGFloat(randomNumber(minX:0, maxX:40)-20),
                            tileView.center.y + CGFloat(randomNumber(minX:20, maxX:30)))
                    },
                    completion: nil)
                
                
                audioController.playEffect(SoundWrong)
                
                data.points -= grade.pointsPerTile/2
                hud.gamePoints.setValue(data.points, duration: 0.25)
            }
        }
    }
    
    
}
