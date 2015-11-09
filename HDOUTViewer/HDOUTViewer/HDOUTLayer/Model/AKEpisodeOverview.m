//
//  AKEpisodeOverview.m
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import "AKEpisodeOverview.h"

#define kAKEpisodeOverviewXMKElementId @"id_episodes"
#define kAKEpisodeOverviewXMKElementSeasonNum @"snum"
#define kAKEpisodeOverviewXMKElementEpisideNum @"enum"
#define kAKEpisodeOverviewXMKElementTitle @"title"
#define kAKEpisodeOverviewXMKElementETitle @"etitle"
#define kAKEpisodeOverviewXMKElementProgress @"vposp"

@implementation AKEpisodeOverview

-(id)initWithXML:(DDXMLElement*)xmlElement {
    self = [super init];
    
    if (self) {
        _episodeId = [self elementValue:kAKEpisodeOverviewXMKElementId forXML:xmlElement];
        _seasonNum = [self elementValue:kAKEpisodeOverviewXMKElementSeasonNum forXML:xmlElement];
        _episodeNum = [self elementValue:kAKEpisodeOverviewXMKElementEpisideNum forXML:xmlElement];
        _title = [self elementValue:kAKEpisodeOverviewXMKElementTitle forXML:xmlElement];
        _englishTitle = [self elementValue:kAKEpisodeOverviewXMKElementETitle forXML:xmlElement];
        _progress = [self elementValue:kAKEpisodeOverviewXMKElementProgress forXML:xmlElement];
    }
    return self;
}

@end