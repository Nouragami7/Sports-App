//
//  FakeNetworkServiceTests.swift
//  Sports-AppTests
//
//  Created by macOS on 05/06/2025.
//

import Foundation
@testable import Sports_App
import XCTest

final class FakeNetworkServiceTests: XCTestCase {

    var fakeConnectObject: FakeNetworkService!
    var fakeFailObject: FakeNetworkService!

    override func setUpWithError() throws {
        fakeConnectObject = FakeNetworkService(shouldReturnData: true)
        fakeFailObject = FakeNetworkService(shouldReturnData: false)
    }

    override func tearDownWithError() throws {
        fakeConnectObject = nil
        fakeFailObject = nil
    }

    func testFetchLeaguesSuccess() {
        let expectation = self.expectation(description: "Fetch leagues success")

        fakeConnectObject.fetchLeagues(for: "football") { response in
            if response == nil {
                XCTFail("Expected non-nil response for success")
            } else {
                XCTAssertNotNil(response)
                XCTAssertEqual(response?.result.first?.league_name, "Fake Premier League")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }
    
    func testFetchUpcomingEventsSuccess() {
        let expectation = XCTestExpectation(description: "Fetch upcoming events success")
        let fakeService = FakeNetworkService(shouldReturnData: true)

        fakeService.fetchUpcommingEvents(from: "2025-06-01", to: "2025-06-10", for: "football", leagueId: "200") { response in
            XCTAssertNotNil(response, "Response should not be nil")
            XCTAssertEqual(response?.result?.first?.event_home_team, nil, "Home team should be 'Fake City'")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }



    func testFetchLeaguesFail() {
        let expectation = self.expectation(description: "Fetch leagues failure")

        fakeFailObject.fetchLeagues(for: "football") { response in
            if response == nil {
                XCTAssertNil(response)
            } else {
                XCTFail("Expected nil response for failure")
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }
    
    func testFetchUpcomingEventsFailure() {
        let expectation = XCTestExpectation(description: "Fetch upcoming events failure")

        fakeFailObject.fetchUpcommingEvents(from: "2025-06-01", to: "2025-06-10", for: "football", leagueId: "200") { response in
            if response == nil {
                XCTAssertNil(response)
            } else {
                XCTFail("Expected nil response for failure")
            }
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 1.0)
    }
    
    func testFetchTeamsSuccess() {
        let expectation = self.expectation(description: "Fetch Teams Success")

        fakeConnectObject.fetchTeams(for: "football", leagueId: "200") { response in
            XCTAssertNotNil(response, "Expected response to be non-nil")
            XCTAssertEqual(response?.result.first?.team_name, "Fake United")
            expectation.fulfill()
        }

        waitForExpectations(timeout: 1)
    }


       func testFetchTeamsFailure() {
           let expectation = self.expectation(description: "Fetch Teams Failure")

           fakeFailObject.fetchTeams(for: "football", leagueId: "200") { response in
               if response == nil {
                   XCTAssertNil(response)
               } else {
                   XCTFail("Expected nil response for failure")
               }
               expectation.fulfill()
           }

           waitForExpectations(timeout: 1)
       }

    
    
}
