//
//  ViewController.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/03/09.
//

import UIKit
import CoreMotion
import SwiftUI
import AVFoundation
import Combine

class BackExtensionViewController: UIViewController, CMHeadphoneMotionManagerDelegate, ObservableObject{
    private let backExtensionCounterModel = BackExtensionCounterModel()
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var counter = "0"
    @Published var daySumCount: [Double] = [0.0]
    @Published var weekSumCount: [Double] = [0.0]
    @Published var monthSumCount: [Double] = [0.0]
    
    let airpods = CMHeadphoneMotionManager()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        backExtensionCounterModel.$counter.map{ counter in
            "\(counter)"
        }.assign(to: \.counter, on: self)
            .store(in: &subscriptions)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        airpods.delegate = self
    }

    override func viewWillAppear(_ plusCountFlag: Bool){
        super.viewWillAppear(plusCountFlag)
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func startCalc(){
        print("start")
        airpods.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
            guard let motion = motion else { return }
            self?.backExtensionCounterModel.countCalculation(data: motion)
        })
    }
    
    
    func stopCalc(){
        print("stop")
        airpods.stopDeviceMotionUpdates()
    }
    
    func plus(){
        backExtensionCounterModel.counter += 1
    }
    
    func minus(){
        backExtensionCounterModel.counter -= 1
    }
    
    func reset(){
        backExtensionCounterModel.counter = 0
    }
    
    let UD = UserDefaults.standard
    func saveDate(){
        let dayFormatter = DateFormatter()
        let monthFormatter = DateFormatter()
        self.counter = "0"
        
        dayFormatter.dateFormat = "yyyy/MM/dd"
        monthFormatter.dateFormat = "yyyy/MM"
        
        let date = Date()
        
        var dayCountFlag = Bool()
        var weekCountFlag = Bool()
        var monthCountFlag = Bool()
        

        if UD.object(forKey: "today") == nil {
            dayCountFlag = true
            weekCountFlag = true
            monthCountFlag = true
            
            UD.set(date, forKey: "today")
         }
         else {
             
             let pastDate = UD.object(forKey: "today") as! Date
             
             let now = dayFormatter.string(from: date)
             let past = dayFormatter.string(from: pastDate)

             let thisWeekStart = backExtensionCounterModel.getWeekStart(date: date)
             let thisWeek = dayFormatter.string(from: thisWeekStart)
             
             let pastWeekStart = backExtensionCounterModel.getWeekStart(date: pastDate)
             let pastWeek = dayFormatter.string(from: pastWeekStart)
             
             let thisMonth = monthFormatter.string(from: date)
             let pastMonth = monthFormatter.string(from: pastDate)
             
             dayCountFlag = backExtensionCounterModel.comparePastNow(now: now, past: past)
             weekCountFlag = backExtensionCounterModel.comparePastNow(now: thisWeek, past: pastWeek)
             monthCountFlag = backExtensionCounterModel.comparePastNow(now: thisMonth, past: pastMonth)
     
             UD.set(date, forKey: "today")
         }
        
        backExtensionCounterModel.graphCountSave(countFlag: &dayCountFlag, numArray: "NumArray")
        
        backExtensionCounterModel.graphCountSave(countFlag: &weekCountFlag, numArray: "NumArray_w")
        
        backExtensionCounterModel.graphCountSave(countFlag: &monthCountFlag, numArray: "NumArray_m")
        
        backExtensionCounterModel.counter = 0
    }
}



