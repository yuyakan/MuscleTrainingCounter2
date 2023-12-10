//
//  SitUpsSumView.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/03/09.
//

import SwiftUI

struct SumGraphView: View {
    @ObservedObject var sumGraphViewModel = SumGraphViewModel()
    @State var pickerSelection = 0
    @State var pickerSelection2 = 0
    var body: some View {
        let bounds = UIScreen.main.bounds
        let width = bounds.width
        VStack{
            Spacer()
            if pickerSelection == 0 {
                Text(LocalizedStringKey("BackExtension"))
                    .font(.system(.largeTitle, design: .monospaced))
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                Spacer()
                Picker(selection: $pickerSelection2, label: Text("Stats")){
                    Text(LocalizedStringKey("1day")).tag(0)
                    Text(LocalizedStringKey("1week")).tag(1)
                    Text(LocalizedStringKey("1month")).tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                    .frame(width: width * 0.8)
                    .padding(.bottom, 2)
                if pickerSelection2 == 0 {
                    GraphView(sumGraghViewModel: sumGraphViewModel, spanType: .day, traingType: .sit)
                }else if pickerSelection2 == 1 {
                    GraphView(sumGraghViewModel: sumGraphViewModel, spanType: .week, traingType: .sit)
                }else {
                    GraphView(sumGraghViewModel: sumGraphViewModel, spanType: .month, traingType: .sit)
                }
            }else {
                Text(LocalizedStringKey("Squats"))
                    .font(.system(.largeTitle, design: .monospaced))
                    .fontWeight(.bold)
                    .frame(alignment: .leading)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                Spacer()
                Picker(selection: $pickerSelection2, label: Text("Stats")){
                    Text(LocalizedStringKey("1day")).tag(0)
                    Text(LocalizedStringKey("1week")).tag(1)
                    Text(LocalizedStringKey("1month")).tag(2)
                }.pickerStyle(SegmentedPickerStyle())
                    .frame(width: width * 0.8)
                    .padding(.bottom, 2)
                if pickerSelection2 == 0{
                    GraphView(sumGraghViewModel: sumGraphViewModel, spanType: .day, traingType: .push)
                }else if pickerSelection2 == 1 {
                    GraphView(sumGraghViewModel: sumGraphViewModel, spanType: .week, traingType: .push)
                }else {
                    GraphView(sumGraghViewModel: sumGraphViewModel, spanType: .month, traingType: .push)
                }
            }
            Spacer()
            Picker(selection: $pickerSelection, label: Text("Stats")){
                Text(LocalizedStringKey("BackExtension")).tag(0)
                Text(LocalizedStringKey("Squats")).tag(1)
            }.pickerStyle(SegmentedPickerStyle())
                .padding(.bottom, 30)
                .padding(.horizontal)
        }.onAppear() {
            sumGraphViewModel.calcDay()
            sumGraphViewModel.calcWeek()
            sumGraphViewModel.calcMonth()
        }
    }
}

struct SitUpsSumView_Previews: PreviewProvider {
    static var previews: some View {
        SumGraphView()
    }
}
