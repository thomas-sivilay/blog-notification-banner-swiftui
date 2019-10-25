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
    @State private var tappedIndex: Int? = nil
    
    private var allBanners = [
        BannerData(title: "Info", level: .info, style: .fullWidth),
        BannerData(title: "Success", level: .success, style: .fullWidth),
        BannerData(title: "Warning", level: .warning, style: .fullWidth),
        BannerData(title: "Error", level: .error, style: .fullWidth),

        BannerData(title: "Info", level: .info, style: .popUp),
        BannerData(title: "Success", level: .success, style: .popUp),
        BannerData(title: "Warning", level: .warning, style: .popUp),
        BannerData(title: "Error", level: .error, style: .popUp),
    ]
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                if showBanner && tappedIndex != nil {
                    self.makeBanner(with: self.allBanners[tappedIndex!])
                        .animation(.easeInOut)
                        .transition(AnyTransition.move(edge: .top).combined(with: .opacity))
                        .zIndex(11)
                        .onTapGesture {
                            self.tappedIndex = nil
                            self.showBanner = false
                        }
                }
                ScrollView {
                    ForEach(0..<self.allBanners.count) { index  in
                        self.makeBanner(with: self.allBanners[index])
                            .onTapGesture {
                                self.tappedIndex = index
                                self.showBanner = true
                            }
                    }
                }
                .animation(.easeInOut)
                .transition(.move(edge: .top))
//                .offset(x: 0, y: showBanner ? 50 : 0) // To add if we want to move the list down
                .navigationBarTitle("Demo", displayMode: .inline) // large title is always tricky
                .zIndex(1)
            }
        }
    }
    
    private func sectionHeader(title: String) -> some View {
        return Text(title)
            .font(.subheadline)
            .padding(.top, 16)
    }
    
    private func makeBanner(with data: BannerData) -> some View {
        switch data.style {
        case .popUp:
            return AnyView(LocalNotification(data: data))
        case .fullWidth:
            return AnyView(FullWidthBanner(data: data))
        }
    }
}

struct BannerData {
    let title: String
    let subtitle: String? = nil
    var level: Level = .info
    
    let style: Style
    
    enum Style {
        case fullWidth
        case popUp
    }
    
    enum Level {
        case warning
        case info
        case error
        case success
        
        var tintColor: Color {
            switch self {
            case .error: return .red
            case .info: return .white
            case .success: return .green
            case .warning: return .yellow
            }
        }
    }
}

struct FullWidthBanner: View {
    let data: BannerData
    
    var body: some View {
        HStack {
            Spacer()
            Text(data.title)//.foregroundColor(.white)
            Spacer()
            Image(systemName: "arrow.right").foregroundColor(.white)
        }
        .padding(EdgeInsets(top: 12, leading: 8, bottom: 12, trailing: 8))
        .background(data.level.tintColor)
    }
}

struct LocalNotification: View {
    let data: BannerData

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(data.title)
                    .bold()
                if data.subtitle != nil {
                    Text(data.subtitle!)
                }
            }
            .multilineTextAlignment(.leading)
            .foregroundColor(.black)
            Spacer()
            Image(systemName: "arrow.right").foregroundColor(.black)
        }
        .padding(EdgeInsets(top: 12, leading: 14, bottom: 12, trailing: 12))
        .background(Color.white)
        .cornerRadius(8, antialiased: true)
        .shadow(color: Color.black.opacity(0.1), radius: 8, x: 0, y: 8)
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
