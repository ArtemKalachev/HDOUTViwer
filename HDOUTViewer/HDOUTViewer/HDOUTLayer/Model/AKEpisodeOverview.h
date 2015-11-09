//
//  AKEpisodeOverview.h
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AKXMLBasedModel.h"

@interface AKEpisodeOverview : AKXMLBasedModel

@property (nonatomic, strong, readonly) NSString* episodeId;
@property (nonatomic, assign, readonly) NSString* seasonNum;
@property (nonatomic, assign, readonly) NSString* episodeNum;
@property (nonatomic, strong, readonly) NSString* title;
@property (nonatomic, strong, readonly) NSString* englishTitle;
@property (nonatomic, assign, readonly) NSString* progress;

@end
