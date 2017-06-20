//
//  ViewController.swift
//  SBRunLoop
//
//  Created by steve.barnegren@gmail.com on 06/20/2017.
//  Copyright (c) 2017 steve.barnegren@gmail.com. All rights reserved.
//

import UIKit
import SBRunLoop

class ViewController: UIViewController {
    
    // MARK: - Properties
    var runLoop: SBRunLoop?
    
    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        runLoop = SBRunLoop(mode: .semiFixed(timeStep: 1.0 / 200))
        runLoop?.update = update
        runLoop?.preUpdate = preUpdate
        runLoop?.postUpdate = postUpdate
        runLoop!.start()
    }
    
    func preUpdate(dt: CFTimeInterval) {
        print("PreUpdate: \(dt)")
    }
    
    func update(dt: CFTimeInterval) {
        print("Upate: \(dt)")
    }
    
    func postUpdate(dt: CFTimeInterval) {
        print("PostUpdate: \(dt)")
    }

    
    

}

