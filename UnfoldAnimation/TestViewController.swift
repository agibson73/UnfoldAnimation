//
//  TestViewController.swift
//  FlipAnimationTest
//
//  Created by Alex Gibson on 10/22/15.


import UIKit

class TestViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
       self.navigationItem.hidesBackButton = true
        
        let downSwipe  = UISwipeGestureRecognizer(target: self, action: Selector("swipeHandler:"))
          downSwipe.direction = .Down
            self.view.addGestureRecognizer(downSwipe)
    }
    
    func swipeHandler(sender:UISwipeGestureRecognizer) {
       if (sender.direction == .Down) {
             moveToPrev()
        }
    }
    
    func moveToPrev() {
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
