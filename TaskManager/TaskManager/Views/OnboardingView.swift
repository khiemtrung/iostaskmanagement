//
//  OnboardingView.swift
//  TaskManager
//
//  Created by Khiem Nguyen Trung on 11/08/2024.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var hasCompletedOnboarding = UserDefaults.standard.bool(forKey: "hasCompletedOnboarding")
    
    var body: some View {
        NavigationView {
            if hasCompletedOnboarding {
                ContentView() // Replace with your main view
            } else {
                TabView(selection: $currentPage) {
                    OnboardingScreen(title: "Welcome to Task Manager",
                                     description: "Manage your tasks efficiently and effectively.",
                                     imageName: "welcomeImage")
                        .tag(0)
                    
                    OnboardingScreen(title: "Track Your Progress",
                                     description: "Stay on top of your tasks and track your progress.",
                                     imageName: "trackImage")
                        .tag(1)
                    
                    OnboardingScreen(title: "Stay Organized",
                                     description: "Organize your tasks into categories for better management.",
                                     imageName: "organizeImage")
                        .tag(2)
                }
                .tabViewStyle(PageTabViewStyle())
                .overlay(
                    Button(action: {
                        // Mark onboarding as completed and navigate to main view
                        UserDefaults.standard.set(true, forKey: "hasCompletedOnboarding")
                        hasCompletedOnboarding = true
                    }) {
                        Text("Get Started")
                            .fontWeight(.bold)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.bottom, 40) // Add space at the bottom of the button
                    .padding(.horizontal)
                    .frame(maxWidth: .infinity, alignment: .center),
                    alignment: .bottom
                )
            }
        }
    }
}
