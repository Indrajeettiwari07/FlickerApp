//
//  HTTPURLEncoderTest.swift
//  FlickerAppTests
//
//  Created by Indrajeet Tiwari on 15/10/2020.
//  Copyright © 2020 Indrajeet Tiwari. All rights reserved.
//

import XCTest
@testable import FlickerApp
class HTTPURLEncoderTest: XCTestCase {

    override func setUpWithError() throws {}

   func test_Parameter() {
          var urlRequest = URLRequest(url: URL(string: "www.google.com")!)
                 urlRequest.httpMethod = "GET"
                 let params = ["param1": "SampleData", "param2": "Sample data 2"]
                 do {
                     try HTTPURLParameterEncoder.encode(urlRequest: &urlRequest, httpParameters: params)
                    XCTAssertTrue(urlRequest.url?.absoluteString == "www.google.com?param1=SampleData&param2=Sample%20data%202" || urlRequest.url?.absoluteString == "www.google.com?param2=Sample%20data%202&param1=SampleData")
              } catch {
                     XCTFail("URL Encoding failed")
                 }
      }

}
