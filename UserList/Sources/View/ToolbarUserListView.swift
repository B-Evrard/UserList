//
//  ToolbarUserListView.swift
//  UserList
//
//  Created by Bruno Evrard on 06/09/2024.
//

import SwiftUI

struct ToolbarUserListView: ToolbarContent {
    
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some ToolbarContent {
        ToolbarItem(placement: .navigationBarTrailing) {
            Picker(selection: $viewModel.isGridView, label: Text("Display")) {
                Image(systemName: "rectangle.grid.1x2.fill")
                    .tag(true)
                    .accessibilityLabel(Text("Grid view"))
                Image(systemName: "list.bullet")
                    .tag(false)
                    .accessibilityLabel(Text("List view"))
            }
            .pickerStyle(SegmentedPickerStyle())
        }
        ToolbarItem(placement: .navigationBarTrailing) {
            Button(action: {
                Task {
                    try await viewModel.reloadUsers()
                }
                
            }) {
                Image(systemName: "arrow.clockwise")
                    .imageScale(.large)
            }
        }
    }
    
    
}

