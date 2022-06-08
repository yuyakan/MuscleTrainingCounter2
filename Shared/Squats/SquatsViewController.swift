//
//  PushController.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/03/09.
//

import UIKit
import CoreMotion
import SwiftUI
import AVFoundation
import Combine

class SquatsViewController: UIViewController, CMHeadphoneMotionManagerDelegate, ObservableObject{
    private let squatsCounterModel = SquatsCounterModel()
    private var subscriptions = Set<AnyCancellable>()
    
    @Published var counter = "0"

    let airpods = CMHeadphoneMotionManager()
    
    init(){
        super.init(nibName: nil, bundle: nil)
        squatsCounterModel.$counter.map{ counter in
            "\(counter)"
        }.assign(to: \.counter, on: self)
            .store(in: &subscriptions)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startCalc(){
        print("start")
        airpods.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
            guard let motion = motion else { return }
            self?.squatsCounterModel.countCalculation(data: motion)
        })
    }
    
    func stopCalc(){
        print("stop")
        airpods.stopDeviceMotionUpdates()
    }
    
    func plus(){
        squatsCounterModel.counter += 1
    }
    
    func minus(){
        squatsCounterModel.counter -= 1
    }
    
    func reset(){
        squatsCounterModel.counter = 0
    }
    
    func saveDate(){
        let UD = UserDefaults.standard
        let dayFormatter = DateFormatter()
        let monthFormatter = DateFormatter()
        self.counter = "0"
        
        dayFormatter.dateFormat = "yyyy/MM/dd"
        monthFormatter.dateFormat = "yyyy/MM"
        
        let date = Date()
        
        var dayCountFlag = Bool()
        var weekCountFlag = Bool()
        var monthCountFlag = Bool()

        if UD.object(forKey: "today_p") == nil {
            dayCountFlag = true
            weekCountFlag = true
            monthCountFlag = true
            
            UD.set(date, forKey: "today_p")
         }
         else {
             
             let pastDate = UD.object(forKey: "today_p") as! Date
             
             let now = dayFormatter.string(from: date)
             let past = dayFormatter.string(from: pastDate)

             let thisWeekStart = squatsCounterModel.getWeekStart(date: date)
             let thisWeek = dayFormatter.string(from: thisWeekStart)
             
             let pastWeekStart = squatsCounterModel.getWeekStart(date: pastDate)
             let pastWeek = dayFormatter.string(from: pastWeekStart)
             
             
             let thisMonth = monthFormatter.string(from: date)
             let pastMonth = monthFormatter.string(from: pastDate)
             
             dayCountFlag = squatsCounterModel.comparePastNow(now: now, past: past)
             weekCountFlag = squatsCounterModel.comparePastNow(now: thisWeek, past: pastWeek)
             monthCountFlag = squatsCounterModel.comparePastNow(now: thisMonth, past: pastMonth)
     
             UD.set(date, forKey: "today_p")
         }
        

        squatsCounterModel.graphCountSave(countFlag: &dayCountFlag, numArray: "NumArray_p")
        
        squatsCounterModel.graphCountSave(countFlag: &weekCountFlag, numArray: "NumArray_w_p")
        
        squatsCounterModel.graphCountSave(countFlag: &monthCountFlag, numArray: "NumArray_m_p")
        
        squatsCounterModel.counter = 0
    }
}
