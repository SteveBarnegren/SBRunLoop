# SBRunLoop

[![Version](https://img.shields.io/cocoapods/v/SBRunLoop.svg?style=flat)](http://cocoapods.org/pods/SBRunLoop)
[![License](https://img.shields.io/cocoapods/l/SBRunLoop.svg?style=flat)](http://cocoapods.org/pods/SBRunLoop)
[![Platform](https://img.shields.io/cocoapods/p/SBRunLoop.svg?style=flat)](http://cocoapods.org/pods/SBRunLoop)

SBRunLoop is a wrapper for CADisplayLink that allows for easy creation of run loops with either a variable, fixed, or semi-fixed timestep.

[WTF is a timestep?](https://gafferongames.com/post/fix_your_timestep/)

## Usage

Create an instance of SBRunLoop, you will want to reatin it so that it doesn't become deallocated. Pass in the callback functions that you want to use.

Complete implementation of a run loop in a view controller:

```swift
class ViewController: UIViewController {
    
    var runLoop: SBRunLoop!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    	 runLoop = SBRunLoop(mode: .variable)
    	 runLoop.update = update(dt:)
    	 runLoop.start()
    }
    
    func update(dt: CFTimeInterval) {
    	 // This method will be called every frame
    }
}
```
## Timesteps

#### Variable


The update function will be called once each frame. **dt** will be equal to the amount of time that it took to render the last frame.

```swift
SBRunLoop(mode: .variable)
```

#### Fixed

The update function will be called only in increments of the provided step size, and any left over time will be carried over to the next frame. Update may be alled multiple times per frame. For instance, for `120hz` update, pass in `1/120`. If the device is able to render at 60fps, this update will be called on average twice per frame. **dt** will always be the fixed step size.

```swift
SBRunLoop(mode: .fixed(timeStep: 1/120))
```

#### Semi Fixed

The update function will be called in the increments provided, and the once again with the remainder. For instance, if there is `0.1s` to render, and the step size is `0.03s`, update will be called with dt `0.03, 0.03, 0.03, 0.01`. With this time step, there is not time carried over to the next frame.

```swift
.semiFixed(timeStep: 1/120)
```

## Callbacks

**Pre Update:** Called Once before update occurs. **dt** is always complete frame time.

```swift
public var preUpdate: (CFTimeInterval) -> () = {_ in}
```

**Update:** Called once or multiple times. **dt** according to time step.

```swift
public var update: (CFTimeInterval) -> () = {_ in}
```

**Post Update:** Called Once after update occurs. **dt** is always complete frame time.

```swift
public var postUpdate: (CFTimeInterval) -> () = {_ in}
```

## Installation

SBRunLoop is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SBRunLoop"
```

## Author

Steve Barnegren, steve.barnegren@gmail.com

## License

SBRunLoop is available under the MIT license. See the LICENSE file for more info.
