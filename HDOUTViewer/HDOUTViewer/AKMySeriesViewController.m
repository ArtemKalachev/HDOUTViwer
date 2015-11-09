//
//  ViewController.m
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import "AKMySeriesViewController.h"
#import "AKHDOUTWebClient.h"

@interface AKMySeriesViewController ()

@property (nonatomic, strong) AKHDOUTWebClient* webClient;
@property (nonatomic, strong) NSArray* mySeries;

@end

@implementation AKMySeriesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.webClient = [[AKHDOUTWebClient alloc] initWithURLSession:[NSURLSession sharedSession]];
    [self.webClient loginWithUserName:@"battleart" andPassword:@"nbh893mz" withCompletionBlock:^(id data, NSError *error) {
        [self.webClient mySeriesWithCompletionBlock:^(NSArray mySeries, NSError *error) {
            self.mySeries = mySeries;
        }];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
