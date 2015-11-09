//
//  AKHDOUTWebClientTest.m
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AKHDOUTWebClient.h"

#define USER_NAME @"HDOUTViewerTest"
#define PASSWORD @"GD9MtPA"

@interface AKHDOUTWebClientAuthenticationTest : XCTestCase

@end

@implementation AKHDOUTWebClientAuthenticationTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testAuthentication {
    AKHDOUTWebClient* webClient = [[AKHDOUTWebClient alloc] initWithURLSession:[NSURLSession sharedSession]];

    XCTAssertNotNil(webClient);
    XCTestExpectation* webClinetLoginRequestExpectation = [self expectationWithDescription:@"HDOUT Login"];

    [webClient loginWithUserName:USER_NAME andPassword:PASSWORD withCompletionBlock:^(NSNumber* data, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(data);
        XCTAssertTrue([data boolValue]);
        [webClinetLoginRequestExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        XCTAssertNil(error);
        if (error) {
            NSLog(@"Authentication is failed; Error: %@",[error localizedDescription]);
            XCTFail(@"Authentication is failed");
        }
    }];
    
    XCTestExpectation* webClinetLogoutRequestExpectation = [self expectationWithDescription:@"HDOUT Logout"];
    [webClient logoutWithCompletionBlock:^(NSNumber* data, NSError *error) {
        XCTAssertNil(error);
        XCTAssertNotNil(data);
        XCTAssertTrue([data boolValue]);
        [webClinetLogoutRequestExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        XCTAssertNil(error);
        if (error) {
            NSLog(@"Authentication is failed; Error: %@",[error localizedDescription]);
            XCTFail(@"Authentication is failed");
        }
    }];
}

- (void)testBadAuthentication {
    AKHDOUTWebClient* webClient = [[AKHDOUTWebClient alloc] initWithURLSession:[NSURLSession sharedSession]];
    
    XCTAssertNotNil(webClient);
    XCTestExpectation* webClinetLoginRequestExpectation = [self expectationWithDescription:@"HDOUT Login"];
    
    [webClient loginWithUserName:USER_NAME andPassword:USER_NAME withCompletionBlock:^(NSNumber* data, NSError *error) {
        XCTAssertNotNil(error);
        XCTAssertNotNil(data);
        XCTAssertFalse([data boolValue]);
        [webClinetLoginRequestExpectation fulfill];
    }];
    
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        XCTAssertNil(error);
        if (error) {
            NSLog(@"Authentication is failed; Error: %@",[error localizedDescription]);
            XCTFail(@"Authentication is failed");
        }
    }];
}


@end
