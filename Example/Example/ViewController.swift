//
//  ViewController.swift
//  Example
//
//  Created by Steve Barnegren on 16/07/2017.
//  Copyright © 2017 Steve Barnegren. All rights reserved.
//

import UIKit
import SBRunLoop

class ViewController: UIViewController {
    
    var runLoop: SBRunLoop!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        runLoop = SBRunLoop(mode: .semiFixed(timeStep: 1/120))
        runLoop.update = update(dt:)
        runLoop.start()
    }
    
    func update(dt: CFTimeInterval) {
        print("dt: \(dt)")
    }
    
}

