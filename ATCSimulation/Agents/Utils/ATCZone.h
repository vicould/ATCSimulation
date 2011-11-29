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
#import "BasicController.h"

@class ATCPoint;
@class ATCZoneBorderSegment;
@class BasicController;

@interface ATCZone : NSObject {
@private
    NSMutableSet *_adjacentZones;
    NSArray *_corners;
    NSString *_controllerName;
    BOOL _airport;
}

- (id)initWithCorners:(NSArray *)cornersArray withControllerName:(NSString *)controllerName andIsAirport:(BOOL)airport;

@property (nonatomic, retain) NSMutableSet *adjacentZones;
@property (nonatomic, retain) NSArray *corners;
@property (nonatomic, assign, readonly, getter=isAirport) BOOL airport;
@property (nonatomic, retain, readonly) NSString *controllerName;

- (void)addAdjacentZone:(ATCZone *)zone;
- (NSNumber *)calculateDistanceToZoneBorderWithPosition:(ATCPosition *)position;
- (BOOL)pointBelongsToZone:(ATCPoint *)point;

@end
