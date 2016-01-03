//
//  ViewController.swift
//  Whapped
//
//  Created by Kristin Ho on 5/5/15.
//  Copyright (c) 2015 Kristin Ho. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    struct Holder {
        static var pressedWhip = false
        static var pressedSlap = false
        static var pressedPunch = false
        static var pressedLightsaber = false
    }
    
    
    var whip = AVAudioPlayer()
    var lightsaber = AVAudioPlayer()
    var slap = AVAudioPlayer()
    var punch = AVAudioPlayer()
    
 
    
    @IBAction func buttonPressed(sender: UIButton) {
        switch (sender.titleLabel!.text!){
        case "Whip":
            Holder.pressedWhip = true
            Holder.pressedPunch = false
            Holder.pressedSlap = false
            Holder.pressedLightsaber = false
            break
        case "Slap":
            Holder.pressedSlap = true
            Holder.pressedPunch = false
            Holder.pressedWhip = false
            Holder.pressedLightsaber = false
            break
        case "Punch":
            Holder.pressedPunch = true
            Holder.pressedWhip = false
            Holder.pressedSlap = false
            Holder.pressedLightsaber = false
            break
        case "Lightsaber":
            Holder.pressedLightsaber = true
            Holder.pressedPunch = false
            Holder.pressedSlap = false
            Holder.pressedWhip = false
            break
        default:
            break
        }
        
    }
    
    // THIS METHOD MEANS THE VIEW CONTROLLER CAN RESPOND TO TOUCH EVENTS
    override func canBecomeFirstResponder() -> Bool {
        return true
    }
    
    // THIS METHOD DETECTS THE ACTUAL SHAKE
    override func motionEnded(motion: UIEventSubtype, withEvent event: UIEvent) {
        if motion == .MotionShake {
            if Holder.pressedWhip{
                whip.play()
            }
            else if Holder.pressedLightsaber{
                lightsaber.play()
            }
            else if Holder.pressedPunch{
                punch.play()
            }
            else if Holder.pressedSlap{
                slap.play()
            }
        }
    }
    
    
    // HELPER METHOD THAT RETURNS AN AV AUDIOPLAYER OBJECT AND TAKES TWO ARGUMENTS: FILE NAME AND TYPE
    func setupAudioPlayerWithFile(file:NSString, type:NSString) -> AVAudioPlayer  {
        
        //1: NSBundle.mainBundle() tells you where in the project to look for the file, path needs to be converted to a url form
        var path = NSBundle.mainBundle().pathForResource(file as String, ofType: type as String)
        var url = NSURL.fileURLWithPath(path!)
        
        //2: NSError object stores an error message if sth goes wrong setting up the AVAudioPlayer
        var error: NSError?
        
        //3: Passing in the URL!!! Error will be filled in if sth goes wrong
        var audioPlayer:AVAudioPlayer?
        audioPlayer = AVAudioPlayer(contentsOfURL: url, error: &error)
        
        //4: AVAudioPlayer object is returned if all is well
        return audioPlayer!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        whip = self.setupAudioPlayerWithFile("whip", type:"wav")
        lightsaber = self.setupAudioPlayerWithFile("lightsaber", type:"wav")
        punch = self.setupAudioPlayerWithFile("punch", type:"wav")
        slap = self.setupAudioPlayerWithFile("slap", type:"wav")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

