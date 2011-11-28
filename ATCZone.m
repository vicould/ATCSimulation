//
//  Zone.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCZone.h"

@interface ATCZone ()

- (NSNumber *)distanceFrom;

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

- (NSNumber *)calculateDistanceToZoneBorderWithCourse:(NSInteger)course fromPositionX:(NSNumber *)airplaneX andPositionY:(NSNumber *)airplaneY {
    
    NSNumber *distance = [[NSNumber alloc] initWithInt:0];
    
    // TODO
    
    
    return distance;
}

- (NSNumber *)distanceFrom {
    
    // TODO
    
    return [[NSNumber alloc] initWithInt:0];
}

- (BOOL)pointBelongsToZone:(ATCPoint *)point {
    // TODO
    
    return FALSE;
}

- (void)dealloc {
    self.corners = nil;
    self.adjacentZones = nil;
    
    [super dealloc];
}

@end
