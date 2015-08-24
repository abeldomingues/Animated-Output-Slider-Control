 //
//  MOJOSliderControl.swift
//  AnimatedOutputSliderControl
//
//  Created by Abel Domingues on 8/1/15.
//  Copyright (c) 2015 Abel Domingues. All rights reserved.
//

import UIKit

class MOJOSliderControl: UIControl {

  var fillLayer = FillLayer(layer: CALayer())
  
  var value : Float = 0.0 {
    didSet {
      self.sendActionsForControlEvents(.ValueChanged)
    }
  }
  
  private var outValueContext : UInt8 = 1 // KVO context
  
  var animationDur : CFTimeInterval!
  {
    get { return fillLayer.animDuration }
    set { fillLayer.animDuration = newValue }
  }
  
  var animationTimingFunc : CAMediaTimingFunction!
  {
    get { return fillLayer.animTimingFunc }
    set { fillLayer.animTimingFunc = newValue }
  }
  
  // MARK: Init
  required init(coder aDecoder: NSCoder)
  {
    super.init(coder: aDecoder)
    fillLayer.addObserver(self, forKeyPath: "outValue", options: .New, context: &outValueContext)
    setup()
  }
  
  deinit
  {
    fillLayer.removeObserver(self, forKeyPath: "outValue")
  }
  
  // MARK: Config
  func setup()
  {
    self.backgroundColor = UIColor.whiteColor()
    self.clipsToBounds = true
    
    self.layer.cornerRadius = CGFloat(12.0)
    fillLayer.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.size.height, width: self.bounds.size.width, height: 0)
    self.fillLayer.backgroundColor = UIColor.darkGrayColor().CGColor
    self.layer.insertSublayer(fillLayer, below: self.layer)
  }
  
  override func observeValueForKeyPath(keyPath: String, ofObject object: AnyObject, change: [NSObject : AnyObject], context: UnsafeMutablePointer<Void>)
  {
    if context == &outValueContext {
      self.value = fillLayer.outValue
    }
  }
  
  // MARK: Touch Handling
  func convertTouchToValue(touchY: CGFloat)
  {
    let valueForTouch = self.bounds.size.height - touchY
    let valueToAnimate = Float(valueForTouch / self.bounds.size.height)
    
    self.fillLayer.animatedValue = valueToAnimate
    CATransaction.begin()
    CATransaction.setAnimationDuration(animationDur)
    CATransaction.setAnimationTimingFunction(animationTimingFunc)
    fillLayer.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.size.height, width: self.bounds.size.width, height: -valueForTouch)
    CATransaction.commit()
  }
  
  override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
    let newTouch = touch.locationInView(self)
    animationDur = 0.25 as CFTimeInterval // longer animation for initial touches
    animationTimingFunc = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    convertTouchToValue(newTouch.y)
    
    return true
  }
  
  override func continueTrackingWithTouch(touch: UITouch, withEvent event: UIEvent) -> Bool {
    let newTouch = touch.locationInView(self)
    animationDur = 0.03 as CFTimeInterval // shorter animation for continuous dragging movements
    animationTimingFunc = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseIn)
    convertTouchToValue(newTouch.y)

    return true
  }
  
}
