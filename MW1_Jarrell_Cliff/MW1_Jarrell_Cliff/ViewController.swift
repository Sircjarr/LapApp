//
//  ViewController.swift
//  MW1_Jarrell_Cliff
//
//  Created by Clifford Kyle Jarrell on 9/24/18.
//  Copyright © 2018 OSU CS Department. All rights reserved.
//

import UIKit

// main interface of the application for the runner to record lap times

class ViewController: UIViewController {
    
    @IBOutlet weak var lblTotalTime: UILabel!
    @IBOutlet weak var lblLapNumber: UILabel!
    @IBOutlet weak var lblCurrentLapTime: UILabel!
    @IBOutlet weak var btnLogoAndNewLap: UIButton!
    @IBOutlet weak var btnStartAndStop: UIButton!
    
    // double tap the stop/start button to reset the app
    @IBAction func doubleTap(_ sender: UITapGestureRecognizer) {
        reset()
    }
    
    // keep track of the total time and current lap times
    var totalTime: Time?
    var currentLapTime: Time?
    
    // reference the timer from anywhere
    var timer: Timer?
    
    // keep track of the lap times
    var lapTimes: [Time]?
    
    // determines if we should begin counting or stop counting
    var startState: Bool = true
    
    // current lap
    var lapNumber: Int = 0
    
    // begin counting or stop counting when button pressed
    @IBAction func btnStartStop(_ sender: Any) {
        
        if startState {
            
            // update the button images
            btnStartAndStop.setBackgroundImage(UIImage(named: "stop"), for: .normal)
            btnLogoAndNewLap.setBackgroundImage(UIImage(named: "button_new_lap"), for: .normal)
            
            // increment lap number
            lapNumber = (lapNumber == 0) ? 1 : lapNumber
            lblLapNumber.text = String(lapNumber)
            
            // timer to update the lap times
            timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
                
                self.totalTime!.increment()
                self.lblTotalTime.text = self.totalTime!.time
                
                self.currentLapTime!.increment()
                self.lblCurrentLapTime.text = self.currentLapTime!.time
            }
            
            startState = false
        }
        else {
            
            //update button images
            btnStartAndStop.setBackgroundImage(UIImage(named: "start"), for: .normal)
            btnLogoAndNewLap.setBackgroundImage(UIImage(named: "lap_app_logo"), for: .normal)
        
            timer!.invalidate()
            
            startState = true
        }
        
    }
    
    // depending on state, go to table or begin new lap
    @IBAction func btnLogoAndNewLap(_ sender: Any) {
        if startState {
            // go to laps table view
        }
        else {
            
            // keep track of a new lap
            lapTimes!.append(currentLapTime!.clone())
            currentLapTime!.reset()
            lblCurrentLapTime.text = currentLapTime!.time
            
            lapNumber+=1
            lblLapNumber.text = String(lapNumber)
        }
    }

    // hide top navigation bar and toolbar when view appears
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.setToolbarHidden(true, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // instantiate variables
        totalTime = Time()
        currentLapTime = Time()
        lapTimes = []
    }

    // perform the segue if not tracking time, else act as the lap button
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        return startState
    }
    
    // pass the lapTimes array to the table segue
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let second = segue.destination as! TableViewController
        second.lapTimes = lapTimes
    }
    
    // restart the app, triggered with a double tap on the stop/start button
    func reset() {
        
        if timer != nil {
            timer!.invalidate()
        }
        
        lapNumber = 0
        totalTime!.reset()
        currentLapTime!.reset()
        lapTimes!.removeAll()
        
        lblLapNumber.text = String(lapNumber)
        lblTotalTime.text = totalTime!.time
        lblCurrentLapTime.text = currentLapTime!.time
        
        startState = true
        
        btnStartAndStop.setBackgroundImage(UIImage(named:"start"), for: .normal)
    }
    
}

