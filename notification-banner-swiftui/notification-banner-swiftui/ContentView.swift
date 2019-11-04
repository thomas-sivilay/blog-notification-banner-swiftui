//
//  ContentView.swift
//  notification-banner-swiftui
//
//  Created by thomas on 25/10/19.
//  Copyright © 2019 thomas. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var showBanner: Bool = false
    @State private var tappedIndex: Int = 0
    
    var body: some View {
        NavigationView {
            ScrollView {
                ForEach(0..<allBanners.count) { index in
                    allBanners[index]
                        .makeBanner()
                        .onTapGesture {
                            self.tappedIndex = index
                            self.showBanner = true
                    }
                }
            }
            .animation(.easeInOut)
            .transition(.move(edge: .top))
            .navigationBarTitle("Demo", displayMode: .inline) // large title is always tricky
            .banner(isPresented: $showBanner, data: allBanners[tappedIndex])
        }
    }
    
    private func sectionHeader(title: String) -> some View {
        return Text(title)
            .font(.subheadline)
            .padding(.top, 16)
    }
}

var allBanners = [
    BannerData(title: "Info", level: .info, style: .fullWidth),
    BannerData(title: "Success", level: .success, style: .fullWidth),
    BannerData(title: "Warning", level: .warning, style: .fullWidth),
    BannerData(title: "Error", level: .error, style: .fullWidth),
    
    BannerData(title: "Info", level: .info, style: .popUp),
    BannerData(title: "Success", level: .success, style: .popUp),
    BannerData(title: "Warning", level: .warning, style: .popUp),
    BannerData(title: "Error", level: .error, style: .popUp),
]

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
