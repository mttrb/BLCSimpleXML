//
//  BLCXML.m
//  XML Parser
//
//  Created by Matthew Robinson on 6/11/12.
//  Copyright (c) 2012 Matthew Robinson. All rights reserved.
//

#import "BLCSimpleXML.h"

@implementation BLCSimpleXML

- (id)initWithContentsOfURL:(NSURL *)url {
    self = [super initWithContentsOfURL:url];
    
    if (self) {
        [self setDelegate:self];
    }
    
    return self;
}

- (id)initWithData:(NSData *)data {
    self = [super initWithData:data];
    
    if (self) {
        [self setDelegate:self];
    }
    
    return self;
}

- (id)initWithStream:(NSInputStream *)stream {
    self = [super initWithStream:stream];
    
    if (self) {
        [self setDelegate:self];
    }
    
    return self;
}


- (void)parserDidStartDocument:(NSXMLParser *)parser {
    if ([self respondsToSelector:@selector(document)]) {
        [self performSelector:@selector(document)];
    }
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
    if ([self respondsToSelector:@selector(documentEnd)]) {
        [self performSelector:@selector(documentEnd)];
    }
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    [_element release], _element = nil;
    _element = [elementName retain];
    
    [_attributes release], _attributes = nil;
    _attributes = [attributeDict retain];
    
    [_namespaceURI release], _namespaceURI = nil;
    _namespaceURI = [namespaceURI retain];
    
    [_qualifiedName release], _qualifiedName = nil;
    _qualifiedName = [qualifiedName retain];
    
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@Element", elementName]);
    
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector];
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    
    [_element release], _element = nil;
    [_attributes release], _attributes = nil;
    [_namespaceURI release], _namespaceURI = nil;
    [_qualifiedName release], _qualifiedName = nil;
    
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@ElementEnd", elementName]);
    
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector];
    }
    
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@Characters:", _element]);
    
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:string];
    }
}

- (void)parser:(NSXMLParser *)parser foundComment:(NSString *)comment {
    if ([self respondsToSelector:@selector(comment:)]) {
        [self performSelector:@selector(comment:) withObject:comment];
    }
}

- (void)parser:(NSXMLParser *)parser foundCDATA:(NSData *)CDATABlock {
    SEL selector = NSSelectorFromString([NSString stringWithFormat:@"%@CDATA", _element]);
    
    if ([self respondsToSelector:selector]) {
        [self performSelector:selector withObject:CDATABlock];
    }
}

@end
