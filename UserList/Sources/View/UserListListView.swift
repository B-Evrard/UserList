//
//  UserListtempView.swift
//  UserList
//
//  Created by Bruno Evrard on 06/09/2024.
//

import SwiftUI

struct UserListListView: View {
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        List(viewModel.users) { user in
            UserListDetailView(user: user, viewModel: viewModel, isList: true)
        }
        .navigationTitle("Users")
        .toolbar {
            ToolbarUserListView(viewModel: viewModel)
        }
    }
}

#Preview {
    UserListListView(
        viewModel: UserListViewModel(
            repository: UserListRepository()
        )
    )
}
