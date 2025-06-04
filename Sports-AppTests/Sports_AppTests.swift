//
//  Sports_AppTests.swift
//  Sports-AppTests
//
//  Created by macOS on 29/05/2025.
//

import XCTest
@testable import Sports_App

final class Sports_AppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testFetchLeagues() {
             let expectation = self.expectation(description: "Fetch Leagues from Network")

             LeaguesNetworkService.fetchLeagues(for: "football") { response in
                 XCTAssertNotNil(response, "Expected non-nil response from API")

                 if let leagues = response?.result {
                     XCTAssertFalse(leagues.isEmpty, "Expected non-empty leagues array")
                     print("Fetched leagues count: \(leagues.count)")
                 } else {
                     XCTFail("Expected leagues list to be non-nil")
                 }

                 expectation.fulfill()
             }

             waitForExpectations(timeout: 20)
         }
        
        func testFetchUpCommingEvents() {
            let expectation = self.expectation(description: "Fetch upcoming events from Network")

            LeaguesDetailsNetworkService.fetchUpcommingEvents(
                from: "2025-05-01",
                to: "2025-05-10",
                for: "football",
                leagueId: "200"
            ) { response in
                XCTAssertNotNil(response, "Expected non-nil response from API")

                if let upcoming = response?.result {
                    XCTAssertFalse(upcoming.isEmpty, "Expected non-empty upcoming events array")
                } else {
                    XCTFail("Expected upcoming events list to be non-nil")
                }

                expectation.fulfill()
            }

            waitForExpectations(timeout: 1000)
        }
        
        
        func testFetchTeams() {
            let expectation = self.expectation(description: "Fetch Teams from Network")

            LeaguesDetailsNetworkService.fetchTeams(
                for: "football",
                leagueId: "200"
            ) { response in
                XCTAssertNotNil(response, "Expected non-nil response from API")

                if let teams = response?.result {
                    XCTAssertFalse(teams.isEmpty, "Expected non-empty teams array")
                    print("Fetched teams count: \(teams.count)")
                    print("First team name: \(teams.first?.team_name ?? "N/A")")
                } else {
                    XCTFail("Expected teams list to be non-nil")
                }

                expectation.fulfill()
            }

            waitForExpectations(timeout: 20)
        }

        


}
