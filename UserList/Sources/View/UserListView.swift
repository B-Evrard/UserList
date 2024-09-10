import SwiftUI

struct UserListView: View {
    
    @ObservedObject var viewModel: UserListViewModel
    
    var body: some View {
        NavigationView {
            if !viewModel.isGridView {
                UserListListView(viewModel: viewModel)
            } else {
                UserListGridView(viewModel: viewModel)
            }
        }
        .onAppear {
            Task {
                try await viewModel.fetchUsers()
            }
            
        }
    }
    
}

struct UserListView_Previews: PreviewProvider {
    static var previews: some View {
        UserListView(
            viewModel: UserListViewModel(
                repository: UserListRepository()
            )
        )
    }
}
