//
//  BLCXML.h
//  XML Parser
//
//  Created by Matthew Robinson on 6/11/12.
//  Copyright (c) 2012 Matthew Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BLCSimpleXML : NSXMLParser <NSXMLParserDelegate>

@property (nonatomic, readonly) NSString *element;
@property (nonatomic, readonly) NSDictionary *attributes;
@property (nonatomic, readonly) NSString *namespaceURI;
@property (nonatomic, readonly) NSString *qualifiedName;

@end
