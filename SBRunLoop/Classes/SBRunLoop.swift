@objc class DisplayLink : NSObject {
    
    private var caDisplayLink: CADisplayLink? = nil
    private let handler: (CADisplayLink) -> ()
    
    init(handler: @escaping (CADisplayLink) -> ()) {
        
        self.handler = handler
        
        super.init()
        
        caDisplayLink = CADisplayLink(target: self,
                                      selector: #selector(displayLinkCallback(displaylink:)))
        
        caDisplayLink?.add(to: .current,
                           forMode: .commonModes)
        
    }
    
    func invalidate() {
        caDisplayLink?.invalidate()
    }
    
    @objc private func displayLinkCallback(displaylink: CADisplayLink) {
        self.handler(displaylink)
    }
}

public class SBRunLoop {
    
    // MARK: - Types
    public enum RunLoopMode {
        case variable
        case semiFixed(timeStep: Double)
        case fixed(timeStep: Double)
    }
    
    // MARK: - Public
    
    public init(mode: RunLoopMode) {
        self.mode = mode
    }
    
    public func start() {
        
        if isRunning {
            return
        }
        
        savedTimeStamp = nil
        displayLink = DisplayLink(handler: tick)
    }
    
    public func stop() {
        
        if !isRunning {
            return
        }
        
        displayLink = nil        
    }
    
    public var mode: RunLoopMode
    
    /** preupdate is called once at the start of the loop. It passes in a variable timestamp for the whole frame */
    public var preUpdate: (CFTimeInterval) -> () = {_ in}
    
    /** update is called once each loop for variable modes, and can be called multiple times for fixed modes. Dt will be fixed or semi-fixed for a fixed or semi-fixed timesteps */
    public var update: (CFTimeInterval) -> () = {_ in}
    
    /** postUpdate is called once at the start of the loop. It passes in a variable timestamp for the whole frame */
    public var postUpdate: (CFTimeInterval) -> () = {_ in}
    
    // MARK: - Properties
    private var isRunning = false
    private var displayLink: DisplayLink?
    private var savedTimeStamp: CFTimeInterval?
    private var broughtOverTime = CFTimeInterval(0)
    
    // MARK: - Methods
    
    func tick(displayLink: CADisplayLink) {
        
        // We need a previous timestamp to compare to, save and return if we don't already have one
        guard let lastTimeStamp = savedTimeStamp else {
            savedTimeStamp = displayLink.timestamp
            return
        }
        
        // Get delta time since last update
        let timeStamp = displayLink.timestamp
        let dt = timeStamp - lastTimeStamp

        // Pre update
        preUpdate(dt)
        
        // Update based on mode
        switch mode {
        case .variable:
            update(dt)
            
        case .semiFixed(let timeStep):
            
            var remaining = dt
            while remaining - timeStep > 0 {
                update(timeStep)
                remaining -= timeStep
            }
            update(remaining)
            
        case .fixed(let timeStep):
            
            var remaining = dt + broughtOverTime
            while remaining - timeStep > 0 {
                update(timeStep)
                remaining -= timeStep
            }
            broughtOverTime = remaining
        }
        
        // Post update
        postUpdate(dt)
        
        // Save the timestamp
        savedTimeStamp = timeStamp
    }
}
