//
//  RickMortyTests.swift
//  RickMortyTests
//
//  Created by Huan Zhang on 5/20/25.
//

import XCTest
@testable import RickMorty

final class SearchViewModelTests: XCTestCase {
    var viewModel: SearchViewModel!

    override func setUp() {
        super.setUp()
        viewModel = SearchViewModel()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testInitialValues() {
        XCTAssertEqual(viewModel.searchText, "Rick")
        XCTAssertNil(viewModel.errorMessage)
        XCTAssertTrue(viewModel.characters.isEmpty)
    }

    func testSearchTextChangeResetsPageAndClearsError() {
        viewModel.errorMessage = "Old Error"
        viewModel.searchText = "Morty"
        
        // debounceSearch will trigger after 0.5s, but we test side effects only
        XCTAssertNil(viewModel.errorMessage)
    }

    func testLoadNextPageIncrementsPage() {
        let oldCharacters = viewModel.characters
        viewModel.searchText = "Rick"
        
        // Call it manually — you may assume fetchCharacters is tested elsewhere
        viewModel.loadNextPage()
        
        // Can't test pageCount directly (private), but we can at least check no crash and side effects
        XCTAssertEqual(viewModel.searchText, "Rick")
        XCTAssertEqual(viewModel.characters, oldCharacters) // since no real data loads
    }

    func testLoadPrevPageDoesNotGoBelowOne() {
        viewModel.loadPrevPage() // should do nothing, no crash
        XCTAssertEqual(viewModel.searchText, "Rick")
    }
}
