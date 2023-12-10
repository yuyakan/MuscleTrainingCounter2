//
//  SetUp.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/06/08.
//

import Foundation

func setup(){
    let isVisit = UserDefaults.standard.bool(forKey: "visit")
    if isVisit {
        print("二回目以降")
    } else {
        print("初回起動")
        
        UserDefaults.standard.set([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], forKey: "NumArray")
        UserDefaults.standard.set([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], forKey: "NumArray_w")
        UserDefaults.standard.set([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], forKey: "NumArray_m")
        
        UserDefaults.standard.set([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], forKey: "NumArray_p")
        UserDefaults.standard.set([0.0, 0.0, 0.0, 0.0, 0.0, 0.0], forKey: "NumArray_w_p")
        UserDefaults.standard.set([0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0], forKey: "NumArray_m_p")
        
        UserDefaults.standard.set(30, forKey: "targetSitDayCount")
        UserDefaults.standard.set(30, forKey: "targetPushDayCount")
        UserDefaults.standard.set(100, forKey: "targetSitWeekCount")
        UserDefaults.standard.set(100, forKey: "targetPushWeekCount")
        UserDefaults.standard.set(300, forKey: "targetSitMonthCount")
        UserDefaults.standard.set(300, forKey: "targetPushMonthCount")
    }
}
