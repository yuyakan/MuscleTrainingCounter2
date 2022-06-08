//
//  SumGraphViewModel.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/06/08.
//

import Foundation

class SumGraphViewModel: ObservableObject{
    @Published var backExtensionDaySumCount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @Published var backExtensionWeekSumCount: [Double] = [0.0, 0.0, 0.0, 0.0]
    @Published var backExtensionMonthSumCount: [Double] = [0.0, 0.0, 0.0, 0.0]
    
    @Published var squatsDaySumCount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @Published var squatsWeekSumCount: [Double] = [0.0, 0.0, 0.0, 0.0]
    @Published var squatsMonthSumCount: [Double] = [0.0, 0.0, 0.0, 0.0]
    
    let UD = UserDefaults.standard
    
    func displayBackExtensionDay(){
        backExtensionDaySumCount = (UD.array(forKey: "NumArray") ?? [0.0]) as! [Double]
    }
    
    func displayBackExtensionWeek(){
        backExtensionWeekSumCount = (UD.array(forKey: "NumArray_w") ?? [0.0]) as! [Double]
    }
    
    func displayBackExtensionMonth(){
        backExtensionMonthSumCount = (UD.array(forKey: "NumArray_m") ?? [0.0]) as! [Double]
    }
    
    func displaySquatsDay(){
        squatsDaySumCount = (UD.array(forKey: "NumArray_p") ?? [0.0]) as! [Double]
    }
    
    func displaySquatsWeek(){
        squatsWeekSumCount = (UD.array(forKey: "NumArray_w_p") ?? [0.0]) as! [Double]
    }
    
    func displaySquatsMonth(){
        squatsMonthSumCount = (UD.array(forKey: "NumArray_m_p") ?? [0.0]) as! [Double]
    }
}

