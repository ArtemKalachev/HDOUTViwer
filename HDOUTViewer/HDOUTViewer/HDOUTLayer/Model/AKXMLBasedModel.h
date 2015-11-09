//
//  AKXMLBasedModel.h
//  HDOUTViewer
//
//  Created by Artem Kalachev on 06/11/15.
//  Copyright © 2015 Artem Kalachev. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDXML.h"

@interface AKXMLBasedModel : NSObject

-(id)initWithXML:(DDXMLElement*)xmlElement;

-(NSString*)elementValue:(NSString*)element forXML:(DDXMLElement*)xml;
-(NSString*)attributeValue:(NSString*)attribute forXML:(DDXMLElement*)xml;

@end
