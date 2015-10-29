//  Created by Alex Gibson on 10/22/15.



import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    // animator
    let flipPush = FlipPushTransitioningAnimator()

    override func viewDidLoad() {
        super.viewDidLoad()
        
     
        let upSwipe   = UISwipeGestureRecognizer(target: self, action: Selector("swipeHandler:"))
        
        
        upSwipe.direction   = .Up
      
        
        self.view.addGestureRecognizer(upSwipe)
        
        
        
        self.navigationController?.delegate = self
        self.navigationController?.view.backgroundColor = UIColor.whiteColor()
    }

    override func viewDidAppear(animated: Bool) {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - UINavigationControllerDelegate

    func navigationController(navigationController: UINavigationController, animationControllerForOperation operation: UINavigationControllerOperation, fromViewController fromVC: UIViewController, toViewController toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if fromVC == self && toVC.isKindOfClass(TestViewController){
            
            flipPush.reverse = false
        
            return flipPush
        }
            
        else if fromVC.isKindOfClass(TestViewController) && toVC == self{

            flipPush.reverse = true
            
            return flipPush
        }
            
            
        else {
            return nil
        }

     
    }

    func swipeHandler(sender:UISwipeGestureRecognizer) {
        if (sender.direction == .Up) {
            moveToNext()
        } else if (sender.direction == .Down) {
           // moveToPrev()
        }
    }

    func moveToNext() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewControllerWithIdentifier("NextViewController") as! TestViewController
        self.navigationController!.pushViewController(destination, animated: true)
    }
    

   

}

