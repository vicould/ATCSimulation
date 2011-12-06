//
//  Artifacts.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCAirplaneInformation.h"

@class ATCAirplaneInformation;

/**
 * Some other methods, that don't need any specific link to an actual instance of the objects, explaining why they all are static.
 */
@interface Artifacts : NSObject

/**
 * Returns the id of the current zone where the plane is located.
 * @param location The position of the airplane.
 * @return The ID of the zone where the plane is at.
 */
+ (NSInteger)calculateCurrentZonefromPoint:(ATCPoint *)location;

/**
 * Calculates the distance to the next zone with the route and the initial position.
 * @param position The point where the airplane currently is located.
 * @param route The azimut it follows.
 * @return The distance to the next zone on a straight line.
 */
+ (float)distanceFromNextZone:(ATCPoint *)position onRoute:(NSInteger *)route;

/**
 * Convenient method to calculate the new point reached by the airplane after flying for a certain time,
 * with the parameters of the flight given in the other parameter.
 * @param currentPosition The information about the current airplane, such as the route, the speed, and the initial position.
 * @param interval The length of the flight.
 * @return Returns the new location of the airplane.
 */
+ (ATCPoint *)calculateNewPositionFromCurrent:(ATCAirplaneInformation *)currentPosition afterInterval:(NSTimeInterval)interval;

@end
