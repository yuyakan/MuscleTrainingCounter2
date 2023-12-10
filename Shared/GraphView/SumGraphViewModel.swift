//
//  SumGraphViewModel.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/06/08.
//

import Foundation

class SumGraphViewModel: ObservableObject{
    @Published var backExtensionDaySumCount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @Published var backExtensionWeekSumCount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @Published var backExtensionMonthSumCount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    @Published var squatsDaySumCount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @Published var squatsWeekSumCount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    @Published var squatsMonthSumCount: [Double] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    
    @Published var day: [String] = ["", "", "", "", "", "", ""]
    @Published var week: [String] = ["", "", "", ""]
    @Published var month: [String] = ["", "", "", "", "", ""]
    
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
    
    func calcDay() {
        day = []
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.current.identifier)
        let weekday = calendar.component(.weekday, from: Date())
        for i in 0..<7 {
            day.append(calendar.shortWeekdaySymbols[(weekday+6-i) % 7])
        }
        day.reverse()
    }
    
    func calcWeek() {
        week = [" 　", " ", "　", String(localized: "this week")]
    }
    
    func calcMonth() {
        month = []
        var calendar = Calendar.current
        calendar.locale = Locale(identifier: Locale.current.identifier)
        let m = calendar.component(.month, from: Date())
        for i in 0..<6 {
            month.append(calendar.shortMonthSymbols[(m-1-i)%12])
        }
        month.reverse()
    }
    
    func displaySitUpsDayTarget() -> Int {
        UD.integer(forKey: "targetSitDayCount")
    }
    
    func displaySitUpsWeekTarget() -> Int {
        UD.integer(forKey: "targetSitWeekCount")
    }
    
    func displaySitUpsMonthTarget() -> Int {
        UD.integer(forKey: "targetSitMonthCount")
    }
    
    func displayPushUpsDayTarget() -> Int {
        UD.integer(forKey: "targetPushDayCount")
    }
    
    func displayPushUpsWeekTarget() -> Int {
        UD.integer(forKey: "targetPushWeekCount")
    }
    
    func displayPushUpsMonthTarget() -> Int {
        UD.integer(forKey: "targetPushMonthCount")
    }
}

