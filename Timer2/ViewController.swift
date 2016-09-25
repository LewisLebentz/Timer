//
//  ViewController.swift
//  Timer2
//
//  Created by Lewis Lebentz on 19/09/2016.
//  Copyright © 2016 Lewis Lebentz. All rights reserved.
//

import UIKit
import AVFoundation
class ViewController: UIViewController, UITextFieldDelegate {
    
    
    var number = 0
    var timer = Timer()
    
    
    @IBAction func pause(_ sender: AnyObject) {
        
        timer.invalidate()
        
    }
    
    @IBAction func minusTen(_ sender: AnyObject) {
        
        number -= 10
        time.text = String(number)
        
    }
    @IBAction func reset(_ sender: AnyObject) {
        
        timer.invalidate()
        number = 0
        time.text = String(number)
        labeltwo.isHidden = true
        label.isHidden = false
        buttonView.isHidden = false
        userEntry.isHidden = false
        time.isHidden = true
        
    }
    @IBAction func plusTen(_ sender: AnyObject) {
        
        number += 10
        time.text = String(number)
        
    }
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var labeltwo: UILabel!
    @IBOutlet weak var userEntry: UITextField!
    @IBOutlet weak var buttonView: UIButton!
    @IBOutlet weak var landscapeBackground: UIImageView!
    @IBOutlet weak var portraitBackground: UIImageView!
    @IBOutlet weak var portraitPhoneBackground: UIImageView!
    @IBOutlet weak var landscapePhoneBackground: UIImageView!
    @IBAction func submit(_ sender: AnyObject) {
        dismissKeyboard()
        if let userEnteredString = userEntry.text {
            if let userEnteredInteger = Int(userEnteredString) {
                number = userEnteredInteger
            
                print(number)
                if number != 0 {
                    buttonView.isHidden = true
                    userEntry.isHidden = true
                    label.isHidden = true
                    time.text = String(number)
                    time.isHidden = false
                    print("Number from if \(number)")
                    
                }
                
            }
            else {
                   print("Something went wrong") }
            
        }
        
        
    }
    

    
    
    @IBAction func play(_ sender: AnyObject) {
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(ViewController.decreaseTimer), userInfo: nil, repeats: true)
        print("read from here")
        print(time.text)
        print(number)
        print("Play pressed")
        
    }
    
    func decreaseTimer() {
        print("decreaseTimer number \(number)")
        if number > 0 {
            
            number -= 1
            
            time.text = String(number)
            print(number)
            playSound2()
            
        } else {
            
            timer.invalidate()
            playSound()
            labeltwo.isHidden = false
            label.isHidden = false
            buttonView.isHidden = false
            userEntry.isHidden = false
            time.isHidden = true
            
        }
    }
    
    
    
    
    var player: AVAudioPlayer?
    
    func playSound() {
        let url = Bundle.main.url(forResource: "soundName", withExtension: "mp3")!
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    
    func playSound2() {
        let url = Bundle.main.url(forResource: "soundName2", withExtension: "mp3")!
        
        if (player?.isPlaying == true) {
            print("Playing")
        }
        else{
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }
            
            player.prepareToPlay()
            player.play()
        } catch let error as NSError {
            print(error.description)
        }
    }
    }

    func rotated()
    {
        if(UIDeviceOrientationIsLandscape(UIDevice.current.orientation))
        {
            if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
                //iPad
                print("Landscape")
                landscapeBackground.isHidden = false
                portraitBackground.isHidden = true
                portraitPhoneBackground.isHidden = true
                landscapePhoneBackground.isHidden = true
            }
            else {
                //iPhone
                print("Landscape")
                landscapeBackground.isHidden = true
                portraitBackground.isHidden = true
                portraitPhoneBackground.isHidden = true
                landscapePhoneBackground.isHidden = false
            }
        }
        
        if(UIDeviceOrientationIsPortrait(UIDevice.current.orientation))
        {
            if(UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad) {
                //iPad
                print("Portrait")
                landscapeBackground.isHidden = true
                portraitBackground.isHidden = false
                portraitPhoneBackground.isHidden = true
                landscapePhoneBackground.isHidden = true
            }
            else {
                //iPhone
                print("Portrait")
                landscapeBackground.isHidden = true
                portraitBackground.isHidden = true
                portraitPhoneBackground.isHidden = false
                landscapePhoneBackground.isHidden = true
            }
        }
    
        
    }

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        time.isHidden = true
        labeltwo.isHidden = true
        rotated()
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)

        
    }
    
    //Calls this function when the tap is recognized.
        func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
            player?.stop()
            labeltwo.isHidden = true
            
    }
    
    


    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

