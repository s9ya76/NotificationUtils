//
//  OverlayUtils.swift
//  NotificationUtils
//
//  Created by 關貿開發者 on 2016/7/15.
//  Copyright © 2016年 關貿開發者. All rights reserved.
//

import UIKit
import Foundation

public class OverlayUtils: NSObject {
    
    // Annoying notifications on top
    static let bannerDissapearAnimationDuration = 0.5
    
    public class func showAnnoyingNotificationOnTop(notificationView: UIView, duration: NSTimeInterval,
                                                    animated: Bool = true, hiddeOnTouch: Bool = true) {
        
        let selector = #selector(closeAnnoyingNotificationOnTop)
        if(hiddeOnTouch) {
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: selector)
            notificationView.addGestureRecognizer(gestureRecognizer)
        }
        
        notificationView.hidden = false
        
        if animated {
            let frame = notificationView.frame
            let origin = CGPoint(x: 0, y: -frame.height)
            notificationView.frame = CGRect(origin: origin, size: frame.size)
            
            // Show appearing animation, schedule calling closing selector after completed
            UIView.animateWithDuration(bannerDissapearAnimationDuration, animations: {
                let frame = notificationView.frame
                notificationView.frame = frame.offsetBy(dx: 0, dy: frame.height)
                }, completion: { (finished) in
                    self.performSelector(selector, withObject: notificationView, afterDelay: duration)
            })
        } else {
            // Schedule calling closing selector right away
            self.performSelector(selector, withObject: notificationView, afterDelay: duration)
        }
    }
    
    public class func closeAnnoyingNotification(notificationView: UIView?) {
        UIView.animateWithDuration(bannerDissapearAnimationDuration,
                                   animations: { () -> Void in
                                    if let frame = notificationView?.frame {
                                        notificationView?.frame = frame.offsetBy(dx: 0, dy: -frame.size.height)
                                    }
            },
                                   completion: { (finished) -> Void in
                                    notificationView?.hidden = true
                                    
            }
        )
    }
    
    class func closeAnnoyingNotificationOnTop(sender: AnyObject) {
        NSObject.cancelPreviousPerformRequestsWithTarget(self)
        
        var notificationView: UIView?
        
        if sender.isKindOfClass(UITapGestureRecognizer) {
            notificationView = (sender as! UITapGestureRecognizer).view!
        } else if sender.isKindOfClass(UIView) {
            notificationView = (sender as! UIView)
        }
        
        closeAnnoyingNotification(notificationView)
    }
    
}

public extension UIViewController {
    
    public var notificationLabel: UILabel {
        let viewTag = 500001
        var labelview :UILabel = UILabel()
        if(self.view.viewWithTag(viewTag) == nil) {
            print("View with tag \(viewTag) not found.")
            self.view.viewWithTag(viewTag)
            labelview.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.width, height: 70)
            labelview.alpha = 0.8
            labelview.backgroundColor = UIColor.blackColor()
            labelview.userInteractionEnabled = true
            labelview.multipleTouchEnabled = true
            labelview.textColor = UIColor.whiteColor()
            labelview.textAlignment = NSTextAlignment.Center
            labelview.tag = viewTag
            labelview.hidden = true
            self.view.addSubview(labelview)
        } else {
            labelview = self.view.viewWithTag(viewTag) as! UILabel
        }
        return labelview
    }
    
    public class func showNotificationOnTop(notificationView: UIView,
                                            duration: NSTimeInterval = Double(INT64_MAX),
                                            animated: Bool = true, hiddeOnTouch: Bool = true) {
        OverlayUtils.showAnnoyingNotificationOnTop(notificationView, duration: duration,
                                                   animated: animated, hiddeOnTouch: hiddeOnTouch)
    }
    
    public class func closeNotificationOnTop(notificationView: UIView) {
        OverlayUtils.closeAnnoyingNotification(notificationView)
    }
    
    public class func notificationOnTopIsShow(notificationView: UIView) -> Bool {
        return !notificationView.hidden
    }
}