//
//  SquatsCounterModel.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/06/08.
//

import CoreMotion

final class SquatsCounterModel {
    @Published var counter = 0
    
    func countCalculation(data: CMDeviceMotion) {
        var sumPlusAcceleration : Double = 0
        var sumMinusAcceleration : Double = 0
        var plusCountFlag = true
        var minusCountFlag = false
        
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
            plusCountFlag = true
            minusCountFlag = false
            sumPlusAcceleration = 0.0
            sumMinusAcceleration = 0.0
            
            counter += 1
        }
    }
    
    
    func comparePastNow(now: String, past: String) -> Bool {
        var countFlag = false
        if now != past {
            countFlag = true
        }
        else {
            countFlag = false
        }
        return countFlag
    }
    
    func getWeekStart(date: Date) -> Date {
        let thisWeekDay = Calendar.current.dateComponents([.weekday], from: date).weekday! - 1
        let now_ = Calendar.current.date(byAdding: .day, value: -thisWeekDay, to: date)!
        
        return now_
    }
    
    func graphCountSave(countFlag: inout Bool, numArray: String) {
        var valueToSave: [Double] = []
        valueToSave = UserDefaults.standard.array(forKey: "\(numArray)")! as! [Double]
        if countFlag == true {
            countFlag = false
            valueToSave.remove(at: 1)
            valueToSave.append(Double(counter))
        }
        else {
            let temp = valueToSave.removeLast()
            valueToSave.append(Double(counter) + temp)
        }
        UserDefaults.standard.set(valueToSave, forKey: "\(numArray)")
    }
}

