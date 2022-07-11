//
//  SitUpsSumView.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/03/09.
//

import SwiftUI
import SwiftUICharts

struct SumGraphView: View {
    @ObservedObject var sumGraphViewModel = SumGraphViewModel()
    @State var pickerSelection = 0
    @State var pickerSelection2 = 0
    var body: some View {
        let bounds = UIScreen.main.bounds
        let height = bounds.height
        ZStack{
            VStack{
                Picker(selection: $pickerSelection, label: Text("Stats")){
                    Text("Back extension").tag(0)
                    Text("Squats").tag(1)
                }.pickerStyle(SegmentedPickerStyle()).padding([.top, .horizontal]).padding(.vertical)
                Picker(selection: $pickerSelection2, label: Text("Stats")){
                    Text("1day").tag(0)
                    Text("1week").tag(1)
                    Text("1month").tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                Spacer()
            }.onAppear{
                pickerSelection2 = 0
            }
            if pickerSelection == 0{
                if pickerSelection2 == 0{
                    LineView(data: sumGraphViewModel.backExtensionDaySumCount, title: "Sit-ups", legend: "Times / 1day")
                        .scaleEffect(CGSize(width: 0.9, height: 0.9))
                        .padding(.top, height * 0.18)
                        .onAppear(perform: {
                            sumGraphViewModel.displayBackExtensionDay()
                        })
                }else if pickerSelection2 == 1 {
                    LineView(data: sumGraphViewModel.backExtensionWeekSumCount, title: "Sit-ups", legend: "Times / 1week")
                        .scaleEffect(CGSize(width: 0.9, height: 0.9))
                        .padding(.top, height * 0.18)
                        .onAppear(perform: {
                            sumGraphViewModel.displayBackExtensionWeek()
                        })
                }else {
                    LineView(data: sumGraphViewModel.backExtensionMonthSumCount, title: "Sit-ups", legend: "Times / 1month")
                        .scaleEffect(CGSize(width: 0.9, height: 0.9))
                        .padding(.top, height * 0.18)
                        .onAppear(perform: {
                            sumGraphViewModel.displayBackExtensionMonth()
                        })
                }
            }else {
                if pickerSelection2 == 0{
                    LineView(data: sumGraphViewModel.squatsDaySumCount, title: "Push-ups", legend: "Times / 1day")
                        .scaleEffect(CGSize(width: 0.9, height: 0.9))
                        .padding(.top, height * 0.18)
                        .onAppear(perform: {
                            sumGraphViewModel.displaySquatsDay()
                        })
                }else if pickerSelection2 == 1 {
                    LineView(data: sumGraphViewModel.squatsWeekSumCount, title: "Push-ups", legend: "Times / 1week")
                        .scaleEffect(CGSize(width: 0.9, height: 0.9))
                        .padding(.top, height * 0.18)
                        .onAppear(perform: {
                            sumGraphViewModel.displaySquatsWeek()
                        })
                }else {
                    LineView(data: sumGraphViewModel.squatsMonthSumCount, title: "Push-ups", legend: "Times / 1month")
                        .scaleEffect(CGSize(width: 0.9, height: 0.9))
                        .padding(.top, height * 0.18)
                        .onAppear(perform: {
                            sumGraphViewModel.displaySquatsMonth()
                        })
                }
            }
            VStack{
                Spacer()
                if pickerSelection == 0{
                    if pickerSelection2 == 0{
                        Text("Total　：　\(Int(sumGraphViewModel.backExtensionDaySumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.022)
                    }else if pickerSelection2 == 1{
                        Text("Total　：　\(Int(sumGraphViewModel.backExtensionWeekSumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.022)
                    }else{
                        Text("Total　：　\(Int(sumGraphViewModel.backExtensionMonthSumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.022)
                    }
                }else{
                    if pickerSelection2 == 0{
                        Text("Total　：　\(Int(sumGraphViewModel.squatsDaySumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.022)
                    }else if pickerSelection2 == 1{
                        Text("Total　：　\(Int(sumGraphViewModel.squatsWeekSumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.022)
                    }else{
                        Text("Total　：　\(Int(sumGraphViewModel.squatsMonthSumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.022)
                    }
                }
            }
        }
    }
}

struct SumView_Previews: PreviewProvider {
    static var previews: some View {
        SumGraphView()
    }
}

