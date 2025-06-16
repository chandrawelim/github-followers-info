//
//  SearchSnapshotTests.swift
//  GithubFollowersiOSTests
//
//  Created by Chandra Welim on 16/06/25.
//

import XCTest
import GithubFollowersiOS
@testable import GithubFollowers

final class SearchSnapshotTests: XCTestCase {

    func test_search() {
        let sut = makeSUT()
        
        assert(snapshot: sut.snapshot(for: .iPhone(style: .light)), named: "SEARCH_light")
        assert(snapshot: sut.snapshot(for: .iPhone(style: .dark)), named: "SEARCH_dark")
    }
    
    private func makeSUT() -> SearchVC {
        let vc = SearchVC()
        vc.loadViewIfNeeded()
        return vc
    }
}
