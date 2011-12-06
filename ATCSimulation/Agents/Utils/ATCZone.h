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

/**
 * A class representing a zone in the environment. A zone if composed of borders, which are segments instance of the class 
 * ZoneBorderSegment. Each zone has a controller, which is either an AirportController or a ZoneController.
 */
@interface ATCZone : NSObject {
@private
    NSMutableSet *_adjacentZones;
    NSArray *_corners;
    NSMutableArray *_borders;
    NSString *_controllerName;
    BOOL _airport;
}

/**
 * Creates an instance of the zone, with the specified corners, and the name of the controller hosted inside.
 * @param cornersArray An array of all the extremities forming the polygone. These corners are then analyzed
 * by the instance to create the corresponding frontiers.
 * @param controllerName The name of the controller hosted inside the zone.
 * @param airport A boolean telling if the current zone has an airway or not, setting the type of controller which
 * is inside the zone.
 */
- (id)initWithCorners:(NSArray *)cornersArray withControllerName:(NSString *)controllerName andIsAirport:(BOOL)airport;

/**
 * Gets the zones next to this one.
 */
@property (nonatomic, readonly, retain) NSMutableSet *adjacentZones;

/**
 * Gets the corners of the zone.
 */
@property (nonatomic, readonly, retain) NSArray *corners;

/**
 * Gets the borders of the zone.
 */
@property (nonatomic, readonly, retain) NSMutableArray *borders;

/**
 * Gets the type of controller inside the zone.
 */
@property (nonatomic, assign, readonly, getter=isAirport) BOOL airport;

/**
 * Gets the name of the controller.
 */
@property (nonatomic, retain, readonly) NSString *controllerName;


/**
 * Method to add a neighbour to the zone.
 * @param zone The zone which shares a border with the current one.
 */
- (void)addAdjacentZone:(ATCZone *)zone;

/**
 * A method to know the distance from the airplane to the nearest frontier of the zone.
 * @param position The information about the airplane, with useful data such as the current position and the course
 * of the airplane.
 * @return Returns the shortest (straight) distance to the zone, depending on the course of the airplane.
 */
- (float)calculateDistanceToZoneBorderWithPosition:(ATCAirplaneInformation *)position;

/**
 * Tests if a point is inside the zone.
 * @param point The point to test.
 * @return Returns YES if the point is inside the zone.
 */
- (BOOL)pointBelongsToZone:(ATCPoint *)point;

@end
