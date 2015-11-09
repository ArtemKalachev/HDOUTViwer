//
//  AKHDOUTWebClient.m
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import "AKHDOUTWebClient.h"
#import "DDXML.h"
#import "AKSeries.h"

#define kAKHDOUTWebClientBaseUrl @"http://hdout.tv/"
#define kAKHDOUTWebClientLoginUrl @""
#define kAKHDOUTWebClientLogoutUrl @"Logout/"
#define kAKHDOUTWebClientMyListUrl @"List/my/XML/"
#define kAKHDOUTWebClientEpisodDetailsUrl @"EpisodeLink/XML/"

#define kAKHDOUTWebClientDefaultTimeInterval 60.0

#define kAKHDOUTWebClientAuthenticationUsernameParam @"login"
#define kAKHDOUTWebClientAuthenticationPasswordParam @"password"

typedef void (^NSURLSessionCompletionBlock)(NSData * data, NSURLResponse *response, NSError *);

static NSString *const AKHDOUTErrorDomain = @"AKHDOUTErrorDomain";

@interface AKHDOUTWebClient ()

-(void)performRequest:(NSURLRequest *)request withCompetionBlock:(NSURLSessionCompletionBlock)completionBlock;
-(NSURL*)urlWithSufix:(NSString*)suffix;
-(NSError*)errorWithString:(NSString*)errorString;

@property (nonatomic, strong) NSURLSession* currentSession;

@end

@implementation AKHDOUTWebClient

#pragma mark - Initialization

-(id)initWithURLSession:(NSURLSession*)session {
    self = [super init];
    
    if (self) {
        self.currentSession = session;
    }
    
    return self;
}

#pragma mark - Public

-(void)loginWithUserName:(NSString*)userName andPassword:(NSString*)password withCompletionBlock:(WebClientResponse)completionBlock {
    NSURL* loginURL = [self urlWithSufix:kAKHDOUTWebClientLoginUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:loginURL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:kAKHDOUTWebClientDefaultTimeInterval];

    [request setHTTPMethod:@"POST"];
    NSString *postString = [NSString stringWithFormat:@"%@=%@&%@=%@",
                            kAKHDOUTWebClientAuthenticationUsernameParam, userName,
                            kAKHDOUTWebClientAuthenticationPasswordParam, password];

    [request setHTTPBody:[postString dataUsingEncoding:NSUTF8StringEncoding]];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    
    [self performRequest:request withCompetionBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSNumber* resVal = [NSNumber numberWithBool:NO];
        NSError* resErr = (error == nil) ? [self errorWithString:@"Authentication Problem"] : error;

        NSString* responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (error == nil && responseStr != nil && [responseStr rangeOfString:userName].location != NSNotFound) {
            resVal = [NSNumber numberWithBool:YES];
            resErr = nil;
        }
        completionBlock(resVal, resErr);
    }];
}

-(void)logoutWithCompletionBlock:(WebClientResponse)completionBlock {
    NSURL* logoutURL = [self urlWithSufix:kAKHDOUTWebClientLogoutUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:logoutURL
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:kAKHDOUTWebClientDefaultTimeInterval];
    
    [request setHTTPMethod:@"GET"];
    
    [self performRequest:request withCompetionBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSNumber* resVal = [NSNumber numberWithBool:NO];
        NSError* resErr = (error == nil) ? [self errorWithString:@"Authentication Problem"] : error;
        
        NSString* responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (error == nil && responseStr != nil) {
            resVal = [NSNumber numberWithBool:YES];
            resErr = nil;
        }
        completionBlock(resVal, resErr);
    }];
}

-(void)mySeriesWithCompletionBlock:(WebClientResponse)completionBlock {
    NSURL* mySeries = [self urlWithSufix:kAKHDOUTWebClientMyListUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:mySeries
                                                           cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                       timeoutInterval:kAKHDOUTWebClientDefaultTimeInterval];
    
    [request setHTTPMethod:@"GET"];
    
    [self performRequest:request withCompetionBlock:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSArray* resVal = nil;
        NSError* resErr = (error == nil) ? [self errorWithString:@"List of serries is empty"] : error;
        
        NSString* responseStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        if (error == nil && responseStr != nil) {
            NSError *xmlError;
            DDXMLDocument* xml = [[DDXMLDocument alloc] initWithData:data options:0 error:&xmlError];
            if (xmlError || !xml) {
                resErr = [self errorWithString:@"Error with content"];
            } else {
                NSMutableArray* mutableResVal = [[NSMutableArray alloc] init];
                NSArray *series = [xml nodesForXPath:@"document/fp/serieslist/item" error:&error];
                for (DDXMLElement *item in series) {
                    AKSeries* series = [[AKSeries alloc] initWithXML:item];
                    [mutableResVal addObject:series];
                }
                resVal = [NSArray arrayWithArray:mutableResVal];
                resErr = nil;
            }
        }
        completionBlock(resVal, resErr);
    }];

}

-(void)seriaDetails:(NSString*)episodeId withCompletionBlock:(WebClientResponse)completionBlock {

}

#pragma mark - Private

-(void)performRequest:(NSURLRequest *)request withCompetionBlock:(NSURLSessionCompletionBlock)completionBlock {
    NSURLSessionDataTask* task = [self.currentSession dataTaskWithRequest:request completionHandler:completionBlock];
    [task resume];
}

-(NSURL*)urlWithSufix:(NSString*)suffix {
    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kAKHDOUTWebClientBaseUrl, suffix]];
}

-(NSError*)errorWithString:(NSString*)errorString {
    
    NSDictionary *userInfo = @{
                               NSLocalizedDescriptionKey: errorString,
                               NSLocalizedFailureReasonErrorKey: errorString
                               };
    NSError *error = [NSError errorWithDomain:AKHDOUTErrorDomain
                                         code:-1
                                     userInfo:userInfo];
    return error;
}

@end
