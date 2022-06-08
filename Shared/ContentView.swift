//
//  ContentView.swift
//  Shared
//
//  Created by 上別縄祐也 on 2022/03/09.
//

import SwiftUI
import SwiftUICharts

struct ContentView: View {
    @State var tabIndex:Int = 0
    @State var visit = UserDefaults.standard.bool(forKey: "visit")
    var body: some View {
        VStack{
            TabView(selection: $tabIndex){
                BackExtensionView().tabItem{
                    Group{
                        Image("h3")
                        Text("BackExtension")
                    }
                }.tag(0)
                SumGraphView()
                    .tabItem{
                    Group{
                        Image(systemName: "chart.bar")
                        Text("Charts")
                    }
                }.tag(1)
                SquatsView().tabItem{
                    Group{
                        Image("s3")
                        Text("Squats")
                    }
                }
            }.padding(.bottom)
                .fullScreenCover(isPresented: $visit, content: {
                    TutorialView(visit: $visit)
                })
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
