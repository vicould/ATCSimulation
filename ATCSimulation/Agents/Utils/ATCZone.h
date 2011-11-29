//
//  Zone.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCPoint.h"
#import "ATCZoneBorderSegment.h"

@class ATCPoint;
@class ATCZoneBorderSegment;

@interface ATCZone : NSObject {
@private
    NSMutableSet *_adjacentZones;
    NSArray *_corners;
}

- (id)initWithCorners:(NSArray *)cornersArray;

@property (nonatomic, retain) NSMutableSet *adjacentZones;
@property (nonatomic, retain) NSArray *corners;

- (void)addAdjacentZone:(ATCZone *)zone;
- (NSNumber *)calculateDistanceToZoneBorderWithPosition:(ATCPosition *)position;
- (BOOL)pointBelongsToZone:(ATCPoint *)point;

@end
