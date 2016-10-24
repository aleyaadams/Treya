import Foundation
import UIKit


let ScreenWidth = UIScreen.mainScreen().bounds.size.width
let ScreenHeight = UIScreen.mainScreen().bounds.size.height




func randomNumber(#minX:UInt32, #maxX:UInt32) -> Int {
    let result = (arc4random() % (maxX - minX + 1)) + minX
    return Int(result)
}

let TileMargin: CGFloat = 20.0

let FontHUD = UIFont(name:"Noteworthy-Bold", size: 30.0)!
let FontHUDBig = UIFont(name:"Noteworthy-Bold", size:60.0)!



let SoundDing = "ding.mp3"
let SoundWrong = "wrong.mp3"
let SoundWin = "win.mp3"
let AudioEffectFiles = [SoundDing, SoundWrong, SoundWin]