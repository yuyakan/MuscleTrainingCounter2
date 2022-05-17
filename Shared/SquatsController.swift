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

class SquatsController: UIViewController, CMHeadphoneMotionManagerDelegate, ObservableObject{
    @Published var counter = 0
    @Published var daySumCount: [Double] = [0.0]
    @Published var weekSumCount: [Double] = [0.0]
    @Published var monthSumCount: [Double] = [0.0]
    
    let airpods = CMHeadphoneMotionManager()
    
    var sumPlusAcceleration : Double = 0
    var sumMinusAcceleration : Double = 0
    var plusCountFlag = true
    var minusCountFlag = false
    
    func startCalc(){
        print("start")
        airpods.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler: {[weak self] motion, error  in
            guard let motion = motion else { return }
            self?.getDataAccel(motion)
        })
    }
    
    func getDataAccel(_ data: CMDeviceMotion){
        let z = data.userAcceleration.z
        if (z > 0.0 && plusCountFlag == true){
            sumPlusAcceleration += z
            print(sumPlusAcceleration)
        }else if(z < 0.0 && minusCountFlag == true){
            sumMinusAcceleration += z
        }
        if (sumPlusAcceleration > 2.0){
            minusCountFlag = true
            sumPlusAcceleration = 0.0
            sumMinusAcceleration = 0.0
        }
        if (sumMinusAcceleration < -3.0 && minusCountFlag == true){
            counter += 1
            plusCountFlag = true
            minusCountFlag = false
            sumPlusAcceleration = 0.0
            sumMinusAcceleration = 0.0
        }
    }
    
    func stopCalc(){
        print("stop")
        airpods.stopDeviceMotionUpdates()
    }
    
    func plus(){
        counter += 1
    }
    
    func minus(){
        counter -= 1
    }
    
    func reset(){
        counter = 0
    }
    
    let UD = UserDefaults.standard
    var valueToSave: [Double] = []
    var temp: Double = 0.0
    let dayFormatter = DateFormatter()
    let monthFormatter = DateFormatter()
    func saveDate(){
        dayFormatter.dateFormat = "yyyy/MM/dd"
        monthFormatter.dateFormat = "yyyy/MM"
        
        let date = Date(timeIntervalSinceNow: 60 * 60 * 9)
        
        var dayCountFlag = Bool()
        var weekCountFlag = Bool()
        var monthCountFlag = Bool()

        var daySpan = 0
        var weekSpan = 0

        if UD.object(forKey: "today_p") != nil {
            let pastDay = UD.object(forKey: "today_p") as! Date
            let now = dayFormatter.string(from: date)
            let past = dayFormatter.string(from: pastDay)
            let span = date.timeIntervalSince(pastDay)
            daySpan = Int(span/60/60/24)
            
            let thisMonth = monthFormatter.string(from: date)
            let pastMonth = monthFormatter.string(from: pastDay)
            
            let thisWeekDay = Calendar.current.dateComponents([.weekday], from: date).weekday! - 1
            let now_ = Calendar.current.date(byAdding: .day, value: -thisWeekDay, to: date)!
            let thisWeek = dayFormatter.string(from: now_)
            let pastWeekDay = Calendar.current.dateComponents([.weekday], from: pastDay).weekday! - 1
            let past_ = Calendar.current.date(byAdding: .day, value: -pastWeekDay, to: pastDay)!
            let pastWeek = dayFormatter.string(from: past_)
            weekSpan = Int(now_.timeIntervalSince(past_)/60/60/24/7)

             //日にちが変わっていた場合
            if now != past {
                dayCountFlag = true
            }
            else {
                dayCountFlag = false
            }
            
            if thisWeek != pastWeek {
                weekCountFlag = true
                UD.set([0.0], forKey: "NumArray_p")
            }
            else {
                weekCountFlag = false
            }

            if thisMonth != pastMonth {
               monthCountFlag = true
                UD.set([0.0], forKey: "NumArray_w_p")
            }
            else {
               monthCountFlag = false
            }
            UD.set(date, forKey: "today_p")
         }
         //初回実行のみelse
         else {
             dayCountFlag = true
             weekCountFlag = true
             monthCountFlag = true
             
             UD.set(date, forKey: "today_p")
             UD.set([0.0], forKey: "NumArray_p")
             UD.set([0.0], forKey: "NumArray_w_p")
             UD.set([0.0], forKey: "NumArray_m_p")
         }

         /* 日付が変わった場合はtrueの処理 */
         if dayCountFlag == true {
              dayCountFlag = false
             if UD.array(forKey: "NumArray_p") != nil {
                 valueToSave = UD.array(forKey: "NumArray_p")! as! [Double]
                 if daySpan > 1 {
                     for i in 2...daySpan{
                         print(i)
                         valueToSave.append(0.0)
                     }
                 }
             }else{
                 UD.set(valueToSave, forKey: "NumArray_p")
             }
             valueToSave.append(Double(counter))
             UserDefaults.standard.set(valueToSave, forKey: "NumArray_p")
             
         }
         else {
             if UD.array(forKey: "NumArray_p") != nil {
                 valueToSave = UD.array(forKey: "NumArray_p")! as! [Double]
                 temp = valueToSave.removeLast()
                 valueToSave.append(Double(counter) + temp)
             }else{
                 UD.set(valueToSave, forKey: "NumArray_p")
                 valueToSave.append(Double(counter))
             }
             UserDefaults.standard.set(valueToSave, forKey: "NumArray_p")
         }
        
        if weekCountFlag == true {
             weekCountFlag = false
            if UD.array(forKey: "NumArray_w_p") != nil {
                valueToSave = UD.array(forKey: "NumArray_w_p")! as! [Double]
                if weekSpan > 1 {
                    for i in 2...weekSpan{
                        print(i)
                        valueToSave.append(0.0)
                    }
                }
            }else{
                UD.set(valueToSave, forKey: "NumArray_w_p")
            }
            valueToSave.append(Double(counter))
            UserDefaults.standard.set(valueToSave, forKey: "NumArray_w_p")
            
        }
        else {
            if UD.array(forKey: "NumArray_w_p") != nil {
                valueToSave = UD.array(forKey: "NumArray_w_p")! as! [Double]
                temp = valueToSave.removeLast()
                valueToSave.append(Double(counter) + temp)
            }else{
                UD.set(valueToSave, forKey: "NumArray_w_p")
                valueToSave.append(Double(counter))
            }
            UserDefaults.standard.set(valueToSave, forKey: "NumArray_w_p")
        }
        
        if monthCountFlag == true {
             monthCountFlag = false
            if UD.array(forKey: "NumArray_m_p") != nil {
                valueToSave = UD.array(forKey: "NumArray_m_p")! as! [Double]
            }else{
                UD.set(valueToSave, forKey: "NumArray_m_p")
            }
            valueToSave.append(Double(counter))
            UserDefaults.standard.set(valueToSave, forKey: "NumArray_m_p")
            
        }
        else {
            if UD.array(forKey: "NumArray_m_p") != nil {
                valueToSave = UD.array(forKey: "NumArray_m_p")! as! [Double]
                temp = valueToSave.removeLast()
                valueToSave.append(Double(counter) + temp)
            }else{
                UD.set(valueToSave, forKey: "NumArray_m_p")
                valueToSave.append(Double(counter))
            }
            UserDefaults.standard.set(valueToSave, forKey: "NumArray_m_p")
        }
        counter = 0
        sumPlusAcceleration = 0
        sumMinusAcceleration = 0
        plusCountFlag = true
        minusCountFlag = false
    }
    
    func ArrayDisplay(){
        daySumCount = (UD.array(forKey: "NumArray_p") ?? [0.0]) as! [Double]
    }
    
    func ArrayDisplayW(){
        weekSumCount = (UD.array(forKey: "NumArray_w_p") ?? [0.0]) as! [Double]
    }
    
    func ArrayDisplayM(){
        monthSumCount = (UD.array(forKey: "NumArray_m_p") ?? [0.0]) as! [Double]
    }
}

