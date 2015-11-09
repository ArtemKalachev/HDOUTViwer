//
//  AKHDOUTWebClient.h
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^WebClientResponse)(id data, NSError *error);

@interface AKHDOUTWebClient : NSObject

-(id)initWithURLSession:(NSURLSession*)session;

-(void)loginWithUserName:(NSString*)userName andPassword:(NSString*)password withCompletionBlock:(WebClientResponse)completionBlock;
-(void)logoutWithCompletionBlock:(WebClientResponse)completionBlock;

-(void)mySeriesWithCompletionBlock:(WebClientResponse)completionBlock;
-(void)seriaDetails:(NSString*)episodeId withCompletionBlock:(WebClientResponse)completionBlock;

@end
