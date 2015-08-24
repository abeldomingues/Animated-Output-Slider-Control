//
//  FillLayer.swift
//  AnimatedOutputSliderControl
//
//  Created by Abel Domingues on 8/1/15.
//  Copyright (c) 2015 Abel Domingues. All rights reserved.
//

import UIKit

class FillLayer: CALayer {
  
  @NSManaged var animatedValue : Float
  dynamic var outValue : Float = 0.0
  
  var animDuration : CFTimeInterval!
  var animTimingFunc : CAMediaTimingFunction!
  
  override init(layer: AnyObject!)
  {
    super.init(layer: layer)
    
    if let layer = layer as? FillLayer {
      animatedValue = layer.animatedValue
    } else {
      animatedValue = 0.0
    }
    animDuration = 0.25 // default
  }
  
  required init(coder aDecoder: NSCoder)
  {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func actionForKey(key: String!) -> CAAction!
  {
    if key == "animatedValue" {
      var animation = CABasicAnimation(keyPath: key)
      animation.duration = animDuration
      animation.timingFunction = animTimingFunc
      animation.fromValue = (self.presentationLayer() as! CALayer).valueForKey(key)
      
      return animation
    }
    
    return super.actionForKey(key)
  }

  override class func needsDisplayForKey(key: String!) -> Bool
  {
    if key == "animatedValue" {
      return true
    }
    return super.needsDisplayForKey(key)
  }
  
  override func display()
  {
    self.outValue = self.presentationLayer().animatedValue
  }
  
}
