//
//  LandingView.swift
//  EnhancedTodoList
//
//  Created by junxi Yim on 2024/11/13.
//

import SwiftUI
 
struct LandingView: View {
    var body: some View {
        TabView {
            TodoListView()
                .tabItem {
                    Text("Tasks")
                    Image(systemName: "checklist")
                }
            
            StatisticsView()
                .tabItem {
                    Text("Stats")
                    Image(systemName: "chart.line.uptrend.xyaxis")
                }
        }
    }
}
 
#Preview {
    LandingView()
}
