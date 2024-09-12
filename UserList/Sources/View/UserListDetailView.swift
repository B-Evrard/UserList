//
//  UserListDetailView.swift
//  UserList
//
//  Created by Bruno Evrard on 07/09/2024.
//

import SwiftUI

struct UserListDetailView: View {
    
    var user: User
    @StateObject var viewModel: UserListViewModel
    var isList: Bool
    
    var body: some View {
        NavigationLink(destination: UserDetailView(user: user)) {
            if (isList) {
                HStack {
                    userView(user: user, viewModel: viewModel, isList: isList)
                }.onAppear {
                    Task {
                        await viewModel.fetchUsersIfMoreData(currentItem: user)
                    }
                }
            } else {
                VStack {
                    userView(user: user, viewModel: viewModel, isList: isList)
                }.onAppear {
                    Task {
                        await viewModel.fetchUsersIfMoreData(currentItem: user)
                    }
                }
            }
            
            
        }
    }
}

struct userView: View {
    var user: User
    var viewModel: UserListViewModel
    var isList: Bool
    
    var body: some View {
        AsyncImage(url: URL(string: isList ? user.picture.thumbnail : user.picture.medium)) { image in
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: isList ? 50 : 150 , height: isList ? 50 : 150)
                .clipShape(Circle())
        } placeholder: {
            ProgressView()
                .frame(width: isList ? 50 : 150, height: isList ? 50 : 150)
                .clipShape(Circle())
        }
        
        if isList {
            VStack(alignment: .leading) {
                Text("\(user.name.first) \(user.name.last)")
                    .font(.headline)
                Text("\(user.dob.date)")
                    .font(.subheadline)
            }
        } else {
            Text("\(user.name.first) \(user.name.last)")
                .font(.headline)
                .multilineTextAlignment(.center)
        }
        
    }
}
