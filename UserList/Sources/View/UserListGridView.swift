//
//  UserListGridView.swift
//  UserList
//
//  Created by Bruno Evrard on 06/09/2024.
//

import SwiftUI

struct UserListGridView: View {
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 150))]) {
                ForEach(viewModel.users) { user in
                    UserListDetailView(user: user, viewModel: viewModel, isList: false)
                }
            }
        }
        .navigationTitle("Users")
        .toolbar {
            ToolbarUserListView(viewModel: viewModel)
        }
        // MARK
    }
}

#Preview {
    UserListGridView(
        viewModel: UserListViewModel(
            repository: UserListRepository()
        )
    )
}
