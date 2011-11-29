//
//  Zone.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCZone.h"

@interface ATCZone ()

@end

@implementation ATCZone

- (id)initWithCorners:(NSArray *)cornersArray {
    self = [super init];
    
    if (self) {
        self.corners = cornersArray;
    }
    
    return self;
}

@synthesize adjacentZones = _adjacentZones;
@synthesize corners = _corners;

- (void)addAdjacentZone:(ATCZone *)zone {
    [self.adjacentZones addObject:zone];
}

- (NSNumber *)calculateDistanceToZoneBorderWithPosition:(ATCPosition *)position {
    
    NSNumber *distance = [NSNumber numberWithFloat:MAXFLOAT];
    
    // tests all segments composing the borders to have the nearest intersection
    for (ATCZoneBorderSegment *segment in self.corners) {
        NSNumber *currentDistance = [segment calculateDistanceToSegment:position];
        if ([currentDistance compare:distance] == NSOrderedDescending) {
            // new minimum
            [distance release];
            distance = [currentDistance retain];
        }
    }
    
    return [distance autorelease];
}

- (BOOL)pointBelongsToZone:(ATCPoint *)point {
    for (ATCZoneBorderSegment *segment in self.corners) {
        if (![segment pointBelongsToGeneratedHalfSpace:point]) {
            return NO;
        }
    }
    
    return YES;
}

- (void)dealloc {
    self.corners = nil;
    self.adjacentZones = nil;

    [super dealloc];
}

@end
