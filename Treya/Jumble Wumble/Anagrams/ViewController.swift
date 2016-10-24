import UIKit

class ViewController: UIViewController {
    
    
    private let controller:GameController
    
    required init(coder aDecoder: NSCoder) {
        controller = GameController()
        super.init(coder: aDecoder)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(patternImage: UIImage(named: "board.jpg")!)
        
        
        let gameView = UIView(frame: CGRectMake(0, 0, ScreenWidth, ScreenHeight))
        self.view.addSubview(gameView)
        controller.gameView = gameView

        
        
        
        
        let hudView = HUDView(frame: CGRect(x: 0, y: 0, width: ScreenWidth, height: ScreenHeight))
        self.view.addSubview(hudView)
        controller.hud = hudView
        
        controller.onAnagramSolved = self.showGradeMenu
        
        controller.whenOver = self.repeatGradeMenu
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        self.showGradeMenu()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func showGradeMenu() {
        let alertController = UIAlertController(title: "Choose Your Grade...then click and drag to spell the jumbled word!",
            message: nil,
            preferredStyle:UIAlertControllerStyle.Alert)
        
        let easiest = UIAlertAction(title: "First Grade", style:.Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(1)
        })
        let easy = UIAlertAction(title: "Second Grade", style:.Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(2)
        })
        let easier = UIAlertAction(title: "Third Grade", style: .Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(3)
        })
        let hard = UIAlertAction(title: "Fourth Grade", style: .Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(4)
        })
        let harder = UIAlertAction(title: "Fifth Grade", style: .Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(5)
        })

        
        
        
        
        alertController.addAction(easiest)
        alertController.addAction(easy)
        alertController.addAction(easier)
        alertController.addAction(hard)
        alertController.addAction(harder)

        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func repeatGradeMenu() {
        let alertController = UIAlertController(title: "Congratulations you won!🎉 Try to beat your time?",
            message: nil,
            preferredStyle:UIAlertControllerStyle.Alert)
        
        let easiest = UIAlertAction(title: "First Grade", style:.Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(1)
        })
        let easy = UIAlertAction(title: "Second Grade", style:.Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(2)
        })
        let easier = UIAlertAction(title: "Third Grade", style: .Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(3)
        })
        let hard = UIAlertAction(title: "Fourth Grade", style: .Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(4)
        })
        let harder = UIAlertAction(title: "Fifth Grade", style: .Default,
            handler: {(alert:UIAlertAction!) in
                self.showGrade(5)
        })
        
        
        
        
        
        alertController.addAction(easiest)
        alertController.addAction(easy)
        alertController.addAction(easier)
        alertController.addAction(hard)
        alertController.addAction(harder)
        
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    
    func showGrade(gradeNumber:Int) {
        controller.grade = Grade(gradeNumber: gradeNumber)
        controller.startStopwatch()
        controller.dealRandomAnagram()
    }
    
}

