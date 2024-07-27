//
//  SplashScreenView.swift
//  StatFit
//
//  Created by Nawaf Mahmood on 2024-07-26.
//

import SwiftUI

struct SplashScreenView: View {
    
    @State private var isActive = false
    @State private var size = 0.4
    @State private var opacity = 0.5
    @StateObject var viewModel = MainViewViewModel()
    
    init() {
        UITabBar.setCustomAppearance()
    }
    
    var body: some View {
        
        if isActive {
            VStack {
                if viewModel.isSignedIn, !viewModel.currentUserId.isEmpty{
                    TabView{
                        HomeView(userId: viewModel.currentUserId)
                            .tabItem {
                                Label("Home", systemImage: "house")
                            }
                        
                        SplitsView(userId: viewModel.currentUserId)
                            .tabItem {
                                Label("Splits", systemImage: "dumbbell")
                            }
                        
                        StatsView()
                            .tabItem {
                                Label("Stats", systemImage: "list.clipboard.fill")
                            }
                        
                        ProfileView()
                            .tabItem {
                                Label("Profile", systemImage: "person.circle")
                            }
                    }
                    .accentColor(.white)
                    
                } else{
                    LoginView()
                }
                
            }
        } else {
            
            VStack {
                VStack{
                    Image("screen")
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear {
                    withAnimation(.easeIn(duration: 1.1)) {
                        self.size = 0.5
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                    withAnimation {
                        self.isActive = true
                    }
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
