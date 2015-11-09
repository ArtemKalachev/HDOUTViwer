//
//  AKSeries.h
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKXMLBasedModel.h"

@interface AKSeries : AKXMLBasedModel

@property (nonatomic, strong, readonly) NSString* seriesId;
@property (nonatomic, strong, readonly) NSString* title;
@property (nonatomic, strong, readonly) NSString* englishTitle;
@property (nonatomic, strong, readonly) NSString* info;
@property (nonatomic, strong, readonly) NSArray* episodesOverview;

@end
