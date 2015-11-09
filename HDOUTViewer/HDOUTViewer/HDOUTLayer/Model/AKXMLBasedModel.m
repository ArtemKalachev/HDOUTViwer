//
//  AKXMLBasedModel.m
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import "AKXMLBasedModel.h"

@implementation AKXMLBasedModel

-(id)initWithXML:(DDXMLElement*)xmlElement {
    self = [super init];
    return self;
}

-(NSString*)elementValue:(NSString*)element forXML:(DDXMLElement*)xml {
    return [[[xml elementsForName:element] firstObject] stringValue];
}

-(NSString*)attributeValue:(NSString*)attribute forXML:(DDXMLElement*)xml {
    return [[xml attributeForName:attribute] stringValue];
}


@end
