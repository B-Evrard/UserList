//
//  UserListViewModelTests.swift
//  UserListTests
//
//  Created by Bruno Evrard on 02/09/2024.
//

import XCTest
@testable import UserList

final class UserListViewModelTests: XCTestCase {

    
    
    func testFetchUsersModeleView() async throws {
        // Given
        let quantity = 2
        let repository = UserListRepository(executeDataRequest: mockExecuteDataRequest)
        let viewModel =  UserListViewModel(repository: repository, quantity: quantity)
        
        
        // When
        try await viewModel.fetchUsers()
        
        // Then
        XCTAssertEqual(viewModel.users.count, quantity)
        XCTAssertEqual(viewModel.users[0].name.first, "John")
        XCTAssertEqual(viewModel.users[0].name.last, "Doe")
        XCTAssertEqual(viewModel.users[0].dob.age, 31)
        XCTAssertEqual(viewModel.users[0].picture.large, "https://example.com/large.jpg")
        
        XCTAssertEqual(viewModel.users[1].name.first, "Jane")
        XCTAssertEqual(viewModel.users[1].name.last, "Smith")
        XCTAssertEqual(viewModel.users[1].dob.age, 26)
        XCTAssertEqual(viewModel.users[1].picture.medium, "https://example.com/medium.jpg")
    }

    
    
}

private extension UserListViewModelTests {
    // Define a mock for executeDataRequest that returns predefined data
    func mockExecuteDataRequest(_ request: URLRequest) async throws -> (Data, URLResponse) {
        // Create mock data with a sample JSON response
        let sampleJSON = """
            {
                "results": [
                    {
                        "name": {
                            "title": "Mr",
                            "first": "John",
                            "last": "Doe"
                        },
                        "dob": {
                            "date": "1990-01-01",
                            "age": 31
                        },
                        "picture": {
                            "large": "https://example.com/large.jpg",
                            "medium": "https://example.com/medium.jpg",
                            "thumbnail": "https://example.com/thumbnail.jpg"
                        }
                    },
                    {
                        "name": {
                            "title": "Ms",
                            "first": "Jane",
                            "last": "Smith"
                        },
                        "dob": {
                            "date": "1995-02-15",
                            "age": 26
                        },
                        "picture": {
                            "large": "https://example.com/large.jpg",
                            "medium": "https://example.com/medium.jpg",
                            "thumbnail": "https://example.com/thumbnail.jpg"
                        }
                    }
                ]
            }
        """
        
        let data = sampleJSON.data(using: .utf8)!
        let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)!
        return (data, response)
    }
}
