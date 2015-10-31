


//  Created by Alex Gibson on 10/22/15.




import UIKit

class FlipPushTransitioningAnimator: NSObject, UIViewControllerAnimatedTransitioning {

    
    var reverse: Bool = false
    

    func degreesToRadian(x:CGFloat)->CGFloat{
        return CGFloat(M_PI) * CGFloat(x) / CGFloat(180.0)
    }
        
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
       
        let containerView   = transitionContext.containerView()!
        let toView          = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)?.view
        let fromView        = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)?.view
        let duration        = 1.0 //transitionDuration(transitionContext)
        
        if reverse == false{

        // Get Screenshots
        let toViewSnapshot = createSnapshots(toView!, afterUpdate: true)
        let flippedSectionOfToView = toViewSnapshot[1]// UP of toView
    
            
        
        let fromViewSnapshot = createSnapshots(fromView!, afterUpdate: false)
        let flippedSectionOfFromView = fromViewSnapshot[0] // DOWN of fromView
        
        // Prepare rotation
        var transform = CATransform3DIdentity
        transform.m34 = -0.003
        containerView.layer.sublayerTransform = transform
            
            
        
            
        
        updateAnchorPointAndOffset(CGPointMake(0.5, 0.0), view: flippedSectionOfFromView)
        updateAnchorPointAndOffset(CGPointMake(0.5, 1.0 ),view: flippedSectionOfToView)
        
        
        
        let animationView = UIView(frame: containerView.frame)
        animationView.addSubview(toView!)
            
        // we still need the to view in the container at the bottom
        containerView.addSubview(animationView)
        containerView.addSubview(toView!)
        containerView.insertSubview(toView!, belowSubview: animationView)
            
        // now all in animationView
            
        animationView.addSubview(toViewSnapshot[0])
        
        let trans = CATransform3DIdentity
        flippedSectionOfToView.layer.transform = CATransform3DRotate(trans, CGFloat(-M_PI_2), 1, 0, 0)
        flippedSectionOfToView.alpha = 0

    
        animationView.addSubview(flippedSectionOfFromView)
        animationView.addSubview(fromViewSnapshot[1])
        animationView.addSubview(flippedSectionOfToView)
            
   
            // we really need shadows
            

        
        UIView.animateKeyframesWithDuration(duration, delay: 0, options: UIViewKeyframeAnimationOptions.LayoutSubviews, animations: {
            
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: { () -> Void in
                flippedSectionOfFromView.layer.transform = CATransform3DMakeRotation(CGFloat(M_PI_2), 1.0, 0.0, 0.0)
                
        
            })
            UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.01, animations: {
            
                
                flippedSectionOfToView.alpha = 1
                // for some reason this is very important.  I need to study this more
                flippedSectionOfToView.layer.zPosition = 5
               
            })
            
            UIView.addKeyframeWithRelativeStartTime(0.51, relativeDuration: 0.49, animations: { () -> Void in
                flippedSectionOfToView.layer.transform =  CATransform3DRotate(trans,CGFloat((M_PI_2/180)), 1, 0, 0)

            })
            
            
            
            }, completion: { finished in
                if transitionContext.transitionWasCancelled() {
                    print("Cancelled")
                    transitionContext.completeTransition(false)
                } else {
                    print("Finished")
                    transitionContext.completeTransition(true)
                }
                
                /**
                *  Remove the animationView.  I think this will also get rid of all of our snapshots
                */
                animationView.removeFromSuperview()
            
                
        })

        }
     
        
        else
        {
            
            print("Reversing")
            // Get Screenshots
            let toViewSnapshot = createSnapshots(toView!, afterUpdate: true)
            let flippedSectionOfToView = toViewSnapshot[0] // Bottomof toView
            
            
            
            let fromViewSnapshot = createSnapshots(fromView!, afterUpdate: false)
            let flippedSectionOfFromView = fromViewSnapshot[1] // Top of fromView
            
            // Prepare rotation
            var transform = CATransform3DIdentity
            transform.m34 = -0.002
            containerView.layer.sublayerTransform = transform
            
            
            
            
            
            updateAnchorPointAndOffset(CGPointMake(0.5, 0.0), view: flippedSectionOfToView)
            updateAnchorPointAndOffset(CGPointMake(0.5, 1.0 ),view: flippedSectionOfFromView)
            
            
            // order matters
            let animationView = UIView(frame: containerView.frame)
            animationView.addSubview(toView!)
            containerView.addSubview(animationView)
            containerView.addSubview(toView!)
            containerView.insertSubview(toView!, belowSubview: animationView)
            animationView.addSubview(toViewSnapshot[0])
            animationView.addSubview(toViewSnapshot[1])
            animationView.addSubview(fromViewSnapshot[0])
            animationView.addSubview(flippedSectionOfToView)
            animationView.addSubview(flippedSectionOfFromView)
            
            
            let trans = CATransform3DIdentity
            flippedSectionOfToView.layer.transform = CATransform3DRotate(trans, CGFloat(M_PI_2), 1, 0, 0)
            flippedSectionOfToView.alpha = 0

            
            
            
            UIView.animateKeyframesWithDuration(duration, delay: 0, options: UIViewKeyframeAnimationOptions.LayoutSubviews, animations: {
                
                
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5, animations: { () -> Void in
                    flippedSectionOfFromView.layer.transform = CATransform3DMakeRotation(CGFloat(-M_PI_2), 1.0, 0.0, 0.0)
                    
                    
                })
                UIView.addKeyframeWithRelativeStartTime(0.5, relativeDuration: 0.0001, animations: {
                    
                    
                    flippedSectionOfToView.alpha = 1
                    flippedSectionOfToView.layer.zPosition = 5
                    
                })
                
                UIView.addKeyframeWithRelativeStartTime(0.51, relativeDuration: 0.4999, animations: { () -> Void in
                    flippedSectionOfToView.layer.transform =  CATransform3DRotate(trans,CGFloat((-M_PI_2/180)), 1, 0, 0)
    
                })
                
                
                
                }, completion: { finished in
                   
                    if transitionContext.transitionWasCancelled() {
                        print("Cancelled")
                        transitionContext.completeTransition(false)
                    } else {
                        print("Finished")
                        transitionContext.completeTransition(true)
                    }
                    
                    /**
                    *  Remove the animationView.  I think this will also get rid of all of our snapshots
                    */
                    animationView.removeFromSuperview()
                    
                    
            })
            
        }
            
    }
    
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning?) -> NSTimeInterval {
        return 1.0
    }
    
    
    
    /**
     this method needs cleaned up.  The things that need done are add the snapshots to the animation layer in the correct order for reverse and push.  This could be done fairly easily.  The bigger issue is accounting for the navigation bar and status bar.  Ideally this would be create to work with a modal transition as well.  Also take away hard coded values for navigation bar
     
     - parameter view:        takes a view from the transition context
     - parameter afterUpdate: whether to snapshot before or after screen updates
     
     - returns: returns a snapshot of the down and up views in an array.
     */

    func createSnapshots(view:UIView, afterUpdate:Bool) -> Array<UIView> {
        var snapshotRegion = CGRectZero

       
    
        // Snapshot DOWN
        snapshotRegion = CGRectMake(0, view.frame.size.height/2 , view.frame.size.width, view.frame.size.height/2 + 64);
        let downHandView = view.resizableSnapshotViewFromRect(snapshotRegion, afterScreenUpdates: afterUpdate, withCapInsets: UIEdgeInsetsZero)
        
        // this is good so we dont have to set this when adding to animation view
        downHandView.frame = snapshotRegion

        
        // Snapshot  UP
        let upSnapshotRegion = CGRectMake(0, 64, view.frame.size.width, view.frame.size.height/2 - 64)
        let upHandView = view.resizableSnapshotViewFromRect(upSnapshotRegion, afterScreenUpdates: afterUpdate, withCapInsets: UIEdgeInsetsZero)
        
    
        // this is good so we dont have to set this when adding to animation view
        upHandView.frame = upSnapshotRegion
 

        
        return[downHandView, upHandView]
    
      }
    
   
    
    func updateAnchorPointAndOffset(anchorPoint:CGPoint, view:UIView) {
        view.layer.anchorPoint = anchorPoint

        let xOffset = anchorPoint.x - 0.5
        view.frame = CGRectOffset(view.frame, xOffset * view.frame.size.width, 0)
        
        let yOffset = anchorPoint.y  - 0.5
        view.frame = CGRectOffset(view.frame, 0, yOffset * view.frame.size.height )
    }
    
    func removeOtherViews(viewToKeep:UIView) {
        UIApplication.sharedApplication().keyWindow!.addSubview(viewToKeep)
    }
}
 