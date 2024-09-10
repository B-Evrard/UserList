//
//  UserListViewModel.swift
//  UserList
//
//  Created by Bruno Evrard on 02/09/2024.
//

import Foundation

final class UserListViewModel: ObservableObject {
    
    @Published var users: [User] = []
    @Published var isLoading = false
    @Published var isGridView = false
    
    private let repository: UserListRepository
    private var quantity: Int
    
    init(repository: UserListRepository) {
        self.repository = repository
        self.quantity = 20
    }
    
    init(repository: UserListRepository, quantity: Int) {
        self.repository = repository
        self.quantity = quantity
    }

    @MainActor
    func fetchUsers() async throws{
        isLoading = true
           
        do {
            let users = try await repository.fetchUsers(quantity: quantity)
            
            self.users.append(contentsOf: users)
            isLoading = false
        } catch {
            print("Error fetching users: \(error.localizedDescription)")
        }
       
    }

    
    func shouldLoadMoreData(currentItem item: User) -> Bool {
        guard let lastItem = users.last else { return false }
        return !isLoading && item.id == lastItem.id
    }

   
    func reloadUsers() async throws{
        users.removeAll()
        try await fetchUsers()
    }
    
    func fetchUsersIfMoreData(currentItem item: User) async throws {
        if shouldLoadMoreData(currentItem: item) {
            try await fetchUsers()
        }
    }
    
}
