//
//  AKSeries.m
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import "AKSeries.h"
#import "AKEpisodeOverview.h"

#define kAKSeriesXMKElementId @"id_series"
#define kAKSeriesXMKElementTitle @"title"
#define kAKSeriesXMKElementETitle @"etitle"
#define kAKSeriesXMKElementInfo @"info"
#define kAKSeriesXMKElementEpisodes @"episodes/eitem"

@implementation AKSeries

-(id)initWithXML:(DDXMLElement*)xmlElement {
    self = [super init];
    
    if (self) {
        _seriesId = [self elementValue:kAKSeriesXMKElementId forXML:xmlElement];
        _title = [self elementValue:kAKSeriesXMKElementTitle forXML:xmlElement];
        _englishTitle = [self elementValue:kAKSeriesXMKElementETitle forXML:xmlElement];
        _info = [self elementValue:kAKSeriesXMKElementInfo forXML:xmlElement];
        
        NSMutableArray* episodesOverview = [[NSMutableArray alloc] init];
        NSArray* episodes = [xmlElement nodesForXPath:kAKSeriesXMKElementEpisodes error:nil];
        for (DDXMLElement *episode in episodes) {
            [episodesOverview addObject:[[AKEpisodeOverview alloc] initWithXML:episode]];
        }
        _episodesOverview = [NSArray arrayWithArray:episodesOverview];
    }
    return self;
}

@end
