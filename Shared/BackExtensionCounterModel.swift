//
//  BackExtensionCounterModel.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/06/08.
//

import CoreMotion

final class BackExtensionCounterModel {
    @Published var counter = 0
    
    func countCalculation(data: CMDeviceMotion) {
        var sumPlusRotationRate : Double = 0.0
        var sumMinusRotationRate : Double = 0.0
        var plusCountFlag = false
        var minusCountFlag = true
        let x = data.rotationRate.x
        if (x > 0.0 && plusCountFlag == true){
            sumPlusRotationRate += x
            print(sumPlusRotationRate)
        }else if(x < 0.0 && minusCountFlag == true){
            sumMinusRotationRate += x
        }
        if (sumMinusRotationRate < -10.0){
            plusCountFlag = true
            sumMinusRotationRate = 0.0
            sumPlusRotationRate = 0.0
        }
        if (sumPlusRotationRate > 10.0 && plusCountFlag == true){
            plusCountFlag = false
            minusCountFlag = true
            sumPlusRotationRate = 0.0
            sumMinusRotationRate = 0.0
            
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
