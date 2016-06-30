//
//  CanvasViewController.swift
//  canvas
//
//  Created by Angeline Rao on 6/30/16.
//  Copyright © 2016 Angeline Rao. All rights reserved.
//

import UIKit

class CanvasViewController: UIViewController {
    
    @IBOutlet weak var trayView: UIView!
    var trayDownOffset: CGFloat!
    var trayUp: CGPoint!
    var trayDown: CGPoint!
    var newlyCreatedFace: UIImageView!
    var newlyCreatedFaceOriginalCenter: CGPoint!
    
    var trayOriginalCenter: CGPoint!
    override func viewDidLoad() {
        super.viewDidLoad()
        trayDownOffset = 160
        trayUp = trayView.center
        trayDown = CGPoint(x: trayView.center.x, y: trayView.center.y + trayDownOffset)
        
        
    }
    
    @IBAction func didPanTray(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        var velocity = sender.velocityInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            print("began")
            trayOriginalCenter = trayView.center
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            print("changed")
            trayView.center = CGPoint(x: trayOriginalCenter.x, y: trayOriginalCenter.y + translation.y)
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            print("ended")
            
            if velocity.y > 0 {
                UIView.animateWithDuration(0.4, animations: {
                    self.trayView.center = self.trayDown
                })
            } else {
                UIView.animateWithDuration(0.4, animations: {
                    self.trayView.center = self.trayUp
                })
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func onCustomPan(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        
        if sender.state == UIGestureRecognizerState.Began {
            newlyCreatedFace = sender.view as! UIImageView
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            
            UIView.animateWithDuration(0.4, animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(2, 2)
            })
        } else if sender.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
        } else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.4, animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
            })
        }
    }
    
    func onCustomPinch(sender: UIPinchGestureRecognizer) {
        let scale = sender.scale
        print("custom pinch func")
        if (sender.state == UIGestureRecognizerState.Changed || sender.state == UIGestureRecognizerState.Ended) {
            print("pinch sender scale")
            UIView.animateWithDuration(0.4, animations: {
                print("pinch scaling")
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(scale, scale)
            })
        }
    }
    
    @IBAction func didPanFace(sender: UIPanGestureRecognizer) {
        let translation = sender.translationInView(view)
        if sender.state == UIGestureRecognizerState.Began {
            var imageView = sender.view as! UIImageView
            newlyCreatedFace = UIImageView(image: imageView.image)
            view.addSubview(newlyCreatedFace)
            newlyCreatedFace.center = imageView.center
            newlyCreatedFace.center.y += trayView.frame.origin.y
            
            var panGestureRecognizer = UIPanGestureRecognizer(target: self, action: "onCustomPan:")
            var pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: "onCustomPinch")
            
            newlyCreatedFace.userInteractionEnabled = true
            newlyCreatedFace.addGestureRecognizer(panGestureRecognizer)
            newlyCreatedFace.addGestureRecognizer(pinchGestureRecognizer)
            
            newlyCreatedFaceOriginalCenter = newlyCreatedFace.center
            UIView.animateWithDuration(0.4, animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(2, 2)
            })
            
        }
        else if sender.state == UIGestureRecognizerState.Changed {
            newlyCreatedFace.center = CGPoint(x: newlyCreatedFaceOriginalCenter.x + translation.x, y: newlyCreatedFaceOriginalCenter.y + translation.y)
            
        }
        else if sender.state == UIGestureRecognizerState.Ended {
            UIView.animateWithDuration(0.4, animations: {
                self.newlyCreatedFace.transform = CGAffineTransformMakeScale(1, 1)
            })
        }
    }
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */

