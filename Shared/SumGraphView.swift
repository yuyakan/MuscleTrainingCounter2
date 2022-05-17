//
//  SitUpsSumView.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/03/09.
//

import SwiftUI
import SwiftUICharts

struct SumGraphView: View {
    @ObservedObject var backExtensionController = BackExtensionController()
    @ObservedObject var squatsController = SquatsController()
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
                    LineView(data: backExtensionController.daySumCount, title: "Sit-ups", legend: "Times / 1day")
                        .padding()
                        .padding(.vertical, height * 0.18)
                        .onAppear(perform: {
                            backExtensionController.displayDay()
                        })
                }else if pickerSelection2 == 1 {
                    LineView(data: backExtensionController.weekSumCount, title: "Sit-ups", legend: "Times / 1week")
                        .padding()
                        .padding(.vertical, height * 0.18)
                        .onAppear(perform: {
                            backExtensionController.displayWeek()
                        })
                }else {
                    LineView(data: backExtensionController.monthSumCount, title: "Sit-ups", legend: "Times / 1month")
                        .padding()
                        .padding(.vertical, height * 0.18)
                        .onAppear(perform: {
                            backExtensionController.displayMonth()
                        })
                }
            }else {
                if pickerSelection2 == 0{
                    LineView(data: squatsController.daySumCount, title: "Push-ups", legend: "Times / 1day")
                        .padding()
                        .padding(.vertical, height * 0.18)
                        .onAppear(perform: {
                            squatsController.ArrayDisplay()
                        })
                }else if pickerSelection2 == 1 {
                    LineView(data: squatsController.weekSumCount, title: "Push-ups", legend: "Times / 1week")
                        .padding()
                        .padding(.vertical, height * 0.18)
                        .onAppear(perform: {
                            squatsController.ArrayDisplayW()
                        })
                }else {
                    LineView(data: squatsController.monthSumCount, title: "Push-ups", legend: "Times / 1month")
                        .padding()
                        .padding(.vertical, height * 0.18)
                        .onAppear(perform: {
                            squatsController.ArrayDisplayM()
                        })
                }
            }
            VStack{
                Spacer()
                if pickerSelection == 0{
                    if pickerSelection2 == 0{
                        Text("Total　：　\(Int(backExtensionController.daySumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.05)
                    }else if pickerSelection2 == 1{
                        Text("Total　：　\(Int(backExtensionController.weekSumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.05)
                    }else{
                        Text("Total　：　\(Int(backExtensionController.monthSumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.05)
                    }
                }else{
                    if pickerSelection2 == 0{
                        Text("Total　：　\(Int(squatsController.daySumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.05)
                    }else if pickerSelection2 == 1{
                        Text("Total　：　\(Int(squatsController.weekSumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.05)
                    }else{
                        Text("Total　：　\(Int(squatsController.monthSumCount.reduce(0, +)))")
                            .font(.largeTitle)
                            .padding(.bottom, height * 0.05)
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

