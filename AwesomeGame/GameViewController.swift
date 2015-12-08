

import UIKit
import SpriteKit
import iAd

class GameViewController: UIViewController, ADBannerViewDelegate {
    
    var iAdBanner = ADBannerView()
    
    var bannerVisible = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        iAdBanner.frame = CGRectMake(0, self.view.frame.size.height, self.view.frame.width, 100)
        iAdBanner.delegate = self
        bannerVisible = false

    }
    
    func bannerViewDidLoadAd(banner: ADBannerView!) {
        if(bannerVisible == false) {
            
            // Add banner Ad to the view
            if(iAdBanner.superview == nil) {
                self.view.addSubview(iAdBanner)
            }
            
            // Move banner into visible screen frame
            UIView.beginAnimations("iAdBannerShow", context: nil)
            banner.center = CGPoint(x: self.view.frame.width * 0.5, y: self.view.frame.height * 0.10)
            UIView.commitAnimations()
            
            bannerVisible = true
        }
    }
    
    override func viewWillLayoutSubviews() {
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .AspectFill
            scene.size = self.view.frame.size
            
            
            skView.presentScene(scene)
            

        }
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
}
