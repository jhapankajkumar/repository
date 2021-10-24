//
//  PKRepositoryViewModelTests.swift
//  RepositoryTests
//
//  Created by pankaj.k.jha on 24/10/21.
//

import XCTest
@testable import Repository

class MockCoordinator: PKRepositoryListCoordinateProtocol {
    var selectedRepository = false
    func didSelectRepository(repository: PKRepository, from controller: PKRepositoryListViewProtocol) {
        selectedRepository = true
    }
}
class MockRepositoryService: PKRepositoryServiceProtocol {
    var isFetchRepositoryCalled = false
    var response: PKListResponse? = StubGenerator().stubResponse()
    var completeClosure: ((PKListResponse?, PKNetworkError?) -> ())!
    func fetchRepositoryList(url: String?, _ completion: @escaping (PKListResponse?, PKNetworkError?) -> Void) {
        isFetchRepositoryCalled = true
        completeClosure = completion
    }
    
    func fetchSuccess() {
        completeClosure( response, nil )
    }
    
    func fetchFail(error: PKNetworkError?) {
        completeClosure( nil, error )
    }
}

class MockRepositoryListView: PKRepositoryListViewModelDelegate, PKRepositoryListViewProtocol  {
    required init(with viewModel: PKRepositoryListViewModelProtocol) {
        
    }
    
    var didSuccessCalled = false
    func viewModelDidFinishWithSuccess() {
        didSuccessCalled = true
    }
    
    var didFailCalled = false
    var networkError: PKNetworkError?
    func viewModelDidFinishWith(error: PKNetworkError) {
        didFailCalled = true
        networkError = error
    }
}

class PKRepositoryViewModelTests: XCTestCase {
    var sut: PKRepositoryListViewModel!
    var service: MockRepositoryService!
    var view: MockRepositoryListView!
    var coordinator: MockCoordinator!
    override func setUp() {
        coordinator = MockCoordinator()
        service = MockRepositoryService()
        sut = PKRepositoryListViewModel(service: service!)
        view = MockRepositoryListView(with: sut)
        sut.viewDelegate = view
        sut.coordinator = coordinator
    }
    override func setUpWithError() throws {
        
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        service = nil
    }
    
    func test_fetch_repository() {
        //When
        sut?.fetchRepositoryList()
        
        service.fetchSuccess()
        // Assert
        XCTAssertTrue(service.isFetchRepositoryCalled)
        XCTAssertTrue(view.didSuccessCalled)
    }
    
    func test_fetch_repository_fail() {
        // Given a failed fetch with a certain failure
        let error = PKNetworkError.notFound
        
        // When
        sut.fetchRepositoryList()
        
        service.fetchFail(error: error )
        
        // Sut should display predefined error message
        XCTAssertTrue(view.didFailCalled)
        XCTAssertNotNil(view.networkError)
        XCTAssertEqual(view.networkError, .notFound)
    }
    
    func test_create_data_view_model() {
        let response = StubGenerator().stubResponse()
        
        //When
        sut.fetchRepositoryList()
        service.fetchSuccess()
        
        //Cell Data View Model Count
        XCTAssertEqual(sut.cellViewModels.count, response?.values?.count)
    }
    
    func test_respository_data() {
        //Given
        let response = StubGenerator().stubResponse()
        service.response = response
        
        //When
        sut.fetchRepositoryList()
        service.fetchSuccess()
        let indexPath = IndexPath(row: 0, section: 0)
        let data = sut.dataForRowAt(indexPath: indexPath)
        
        
        //Check Data
        XCTAssertEqual(data?.uuid, response?.values?[0].uuid)
    }
    
    func test_user_selected_repository () {
        //Given
        let response = StubGenerator().stubResponse()
        service.response = response
        
        //When
        sut.fetchRepositoryList()
        service.fetchSuccess()
        let indexPath = IndexPath(row: 0, section: 0)
        sut.didSelectRowAt(indexPath: indexPath, fromView: view)
        
        
        //Check Naviation
        XCTAssertTrue(coordinator.selectedRepository)
    }
    
}

class StubGenerator {
    func stubResponse() -> PKListResponse? {
        if let responseData = JSONHelper.readJson(type(of: self), fromFile: "repositories") {
            let response = try? JSONDecoder().decode(PKListResponse.self, from: responseData)
            return response
        } else {
            return nil
        }
    }
}
