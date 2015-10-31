//  Created by Alex Gibson on 10/22/15.



import UIKit

class ViewController: UIViewController, UINavigationControllerDelegate {
    
    // animator
    let flipPush = FlipPushTransitioningAnimator()

    var interactionController: UIPercentDrivenInteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: Selector("panHandler:"))
        self.view.addGestureRecognizer(panGesture)
        
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

    func navigationController(navigationController: UINavigationController, interactionControllerForAnimationController animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return self.interactionController
    }

    func panHandler(gestureRecognizer:UIPanGestureRecognizer) {
        
        switch gestureRecognizer.state {
        case .Began:
            self.interactionController = UIPercentDrivenInteractiveTransition()
            moveToNext()
            
        case .Changed:
            let translation = gestureRecognizer.translationInView(self.view)
            let completionProgress = abs(translation.y/CGRectGetHeight(self.view.bounds))
            self.interactionController!.updateInteractiveTransition(completionProgress)
            
        case .Ended:
            let translation = gestureRecognizer.translationInView(self.view)
            let completionProgress = abs(translation.y/CGRectGetHeight(self.view.bounds))
            
            if completionProgress >= 0.5 {
                self.interactionController!.finishInteractiveTransition()
            } else {
                self.interactionController!.cancelInteractiveTransition()
            }
            
            self.interactionController = nil
            
        default:
            self.interactionController?.cancelInteractiveTransition()
            self.interactionController = nil
        }
    }

    func moveToNext() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destination = storyboard.instantiateViewControllerWithIdentifier("NextViewController") as! TestViewController
        self.navigationController!.pushViewController(destination, animated: true)
    }
    

   

}

