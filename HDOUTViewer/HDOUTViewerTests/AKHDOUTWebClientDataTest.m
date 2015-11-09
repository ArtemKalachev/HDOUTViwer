//
//  AKHDOUTWebClientDataTest.m
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "AKHDOUTWebClient.h"

#define USER_NAME @"HDOUTViewerTest"
#define PASSWORD @"GD9MtPA"

@interface AKHDOUTWebClientDataTest : XCTestCase

-(void)login;
-(void)logout;

@property (nonatomic, strong) AKHDOUTWebClient* webClient;

@end

@implementation AKHDOUTWebClientDataTest

- (void)setUp {
    [super setUp];
    self.webClient = [[AKHDOUTWebClient alloc] initWithURLSession:[NSURLSession sharedSession]];
    [self login];
}

- (void)tearDown {
    [self logout];
    [super tearDown];
}

- (void)testMySeries {
    XCTestExpectation* webClinetMySerieceRequestExpectation = [self expectationWithDescription:@"HDOUT My Series"];

    [self.webClient mySeriesWithCompletionBlock:^(NSArray* data, NSError *error) {
        XCTFail(@"My Seriece Request is failed");
        XCTAssertNil(error);
        XCTAssertNotNil(data);
        XCTAssertTrue([data count] > 0);
        //TODO: extend with parsing testing (add test for base model)
        [webClinetMySerieceRequestExpectation fulfill];
    }];
    [self waitForExpectationsWithTimeout:10 handler:^(NSError *error) {
        XCTAssertNil(error);
        if (error) {
            NSLog(@"My Seriece Request is failed; Error: %@",[error localizedDescription]);
            XCTFail(@"My Seriece Request is failed");
        }
    }];
}

#pragma mark - private

-(void)login {
    XCTestExpectation* webClinetLoginRequestExpectation = [self expectationWithDescription:@"HDOUT Login"];
    [self.webClient loginWithUserName:USER_NAME andPassword:PASSWORD withCompletionBlock:^(NSNumber* data, NSError *error) {
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
}

-(void)logout {
    XCTestExpectation* webClinetLogoutRequestExpectation = [self expectationWithDescription:@"HDOUT Logout"];
    [self.webClient logoutWithCompletionBlock:^(NSNumber* data, NSError *error) {
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

@end
