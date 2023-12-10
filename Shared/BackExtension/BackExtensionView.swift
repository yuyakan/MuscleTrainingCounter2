//
//  SitUpsView.swift
//  MuscleTrainingCounter2
//
//  Created by 上別縄祐也 on 2022/03/09.
//

import SwiftUI

struct BackExtensionView: View {
    @ObservedObject var interstitial = Interstitial()
    @ObservedObject var backExtensionViewController = BackExtensionViewController()
    @State var saveFlag = false
    @State var revise = false
    @State var stopFlag = false
    @State var status = 0
    var body: some View {
        ZStack{
            Image("h")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .opacity(0.5)
            VStack{
                Spacer()
                if status == 0 {
                    Text(LocalizedStringKey("BackExtension"))
                        .font(.system(.largeTitle, design: .monospaced))
                        .fontWeight(.bold)
                        .padding()
                }else if status == 1{
                    HStack {
                        Text(LocalizedStringKey("Measuring"))
                            .font(.system(.largeTitle, design: .monospaced))
                            .fontWeight(.bold)
                            .padding()
                        DotView()
                        DotView(delay: 0.2)
                        DotView(delay: 0.4)
                            }
                }else if status == 2{
                    Text(LocalizedStringKey("Stop measurement"))
                        .font(.system(.largeTitle, design: .monospaced))
                        .fontWeight(.bold)
                        .padding()
                }
                Spacer()
                Text("\(backExtensionViewController.counter)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding()
                Spacer()
                HStack{
                    Spacer()
                    if saveFlag {
                        Button(action: {
                            backExtensionViewController.startCalc()
                            saveFlag = false
                            status = 1
                            stopFlag = true
                        }, label: {
                            Image(systemName: "play.fill")
                                .padding()
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 160.0, height: 120.0)
                                .background(Color("startColor"))
                                .clipShape(Circle())
                                .shadow(color: .gray, radius: 4, x: 0, y: 0)
                        })
                            .padding()
                    }else {
                        Button(action: {
                            backExtensionViewController.startCalc()
                            saveFlag = false
                            status = 1
                            stopFlag = true
                        }, label: {
                            Image(systemName: "play.fill")
                                .padding()
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 160.0, height: 120.0)
                                .background(Color("startColor"))
                                .clipShape(Circle())
                                .shadow(color: stopFlag ? .white : .gray, radius: 4, x: 0, y: 0)
                        })
                            .disabled(stopFlag)
                            .opacity(stopFlag ? 0.1:1)
                            .padding()
                    }
                    Spacer()
                    if(saveFlag){
                        Button(action: {
                            Thread.sleep(forTimeInterval: 0.1)
                            backExtensionViewController.saveDate()
                            saveFlag = false
                            status = 0
                            interstitial.presentInterstitial()
                        }) {
                            Image(systemName: "list.bullet.clipboard.fill")
                                .padding(.horizontal)
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 160.0, height: 120.0)
                                .background(Color("saveColor"))
                                .clipShape(Circle())
                                .shadow(color: .gray, radius: 4, x: 0, y: 0)
                        }.padding()
                    }else{
                        Button(action: {
                            Thread.sleep(forTimeInterval: 0.1)
                            backExtensionViewController.stopCalc()
                            saveFlag = true
                            status = 2
                            stopFlag = false
                        }, label: {
                            Image(systemName: "stop.fill")
                                .padding(.horizontal)
                                .font(.title)
                                .foregroundColor(Color.white)
                                .frame(width: 160.0, height: 120.0)
                                .background(Color("stopColor"))
                                .clipShape(Circle())
                                .shadow(color: .gray, radius: 4, x: 0, y: 0)
                        }).padding()
                        
                    }
                    Spacer()
                }.padding(.horizontal)
                HStack{
                    Toggle(isOn: $revise) {
                    }.labelsHidden()
                        .padding()
                    Spacer()
                }.padding(.leading)
                if revise {
                    HStack{
                        Button(action: {
                            backExtensionViewController.minus()
                        }, label: {
                            Text("ー")
                                .font(.title)
                                .padding(.leading)
                        }).padding([.leading, .bottom])
                        Spacer()
                        Button(action: {
                            backExtensionViewController.plus()
                        }, label: {
                            Text("＋")
                                .font(.title)
                        }).padding(.bottom)
                        Spacer()
                        Button(action: {
                            backExtensionViewController.reset()
                        }, label: {
                            Image(systemName: "gobackward")
                                .font(.title)
                                .padding(.trailing)
                        }).padding([.trailing, .bottom])
                    }.padding()
                }
                if !revise {
                    Text(" ").padding(.bottom)
                }
            }.onAppear() {
                interstitial.loadInterstitial()
            }
        }
    }
}


