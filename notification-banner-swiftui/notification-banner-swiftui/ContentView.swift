//
//  ContentView.swift
//  notification-banner-swiftui
//
//  Created by thomas on 25/10/19.
//  Copyright © 2019 thomas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var hideAllBanners: Bool = false
    @State private var showBanner: Bool = false
    @State private var tappedIndex: Int = 0
    @State private var countActionTap: Int = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    Text("Example of banners").font(.headline)
                    Text("Tap one of them to show banner in this scroll view").font(.subheadline)
                }.padding()
                Divider()
                ForEach(0..<allBanners.count) { index in
                    allBanners[index]
                        .makeBanner()
                        .onTapGesture {
                            self.tappedIndex = index
                            self.showBanner = true
                        }
                }
                .padding()
                Divider()
                Text("Count tapped on action banner: \(countActionTap)")
            }
            .animation(.easeInOut)
            .transition(.move(edge: .top))
            .navigationBarTitle("Demo", displayMode: .inline) // large title is always tricky
            .banner(isPresented: $showBanner, data: allBanners[tappedIndex], action: {
                self.countActionTap += 1
            })
        }
    }
    
    private func sectionHeader(title: String) -> some View {
        return Text(title)
            .font(.subheadline)
            .padding(.top, 16)
    }
}

var allBanners = [
    BannerData(title: "Success tap to dismiss", level: .success, style: .fullWidth),
    BannerData(title: "Warning tap to dismiss", level: .warning, style: .fullWidth),
    BannerData(title: "Error tap to dismiss", level: .error, style: .fullWidth),
    
    BannerData(title: "Info", level: .info, style: .popUp),
    
    BannerData(title: "Banner with action", actionTitle: "Increment", level: .success, style: .action),
    BannerData(title: "Banner with action", actionTitle: "Decrement", level: .error, style: .action)
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
