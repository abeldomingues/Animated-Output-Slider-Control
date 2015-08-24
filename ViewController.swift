//
//  ViewController.swift
//  AnimatedOutputSliderControl
//
//  Created by Abel Domingues on 8/1/15.
//  Copyright (c) 2015 Abel Domingues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet var slider: MOJOSliderControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  @IBAction func printValue(sender: MOJOSliderControl)
  {
    println("value = \(String(stringInterpolationSegment: sender.value))")
  }
}

