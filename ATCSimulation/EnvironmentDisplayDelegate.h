//
//  EnvironmentDisplayDelegate.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Defines a protocol a view controller needs to respond to in order for the environment to create a representation of the 
 * simulation.
 */
@protocol EnvironmentDisplayDelegate <NSObject>

# pragma mark - Methods for the airplanes.

/**
 * Update the position of one airplane. The information is received directly from the airplane, 
 * as opposed to thee method \ref updateDetectedAirplanes:.
 * @param correspondingInfo The info on the airplane needing an update
 */
- (void)updateAirplanePositionWithInfo:(ATCAirplaneInformation *)correspondingInfo;

/**
 * Crashes an airplane, to inform the user a collision or an accident happened.
 * @param airplane
 */
- (void)crashAirplane:(ATCAirplaneInformation *)airplaneData;

/**
 * Lands an airplane once it has reached its destination.
 * @param airplane
 */
- (void)landAirplane:(ATCAirplaneInformation *)airplaneData;

# pragma mark - Methods for the zones and the controllers.

/**
 * Adds a list of airplanes to the map.
 * @param airplanesInfo The airplanes to add to the interface.
 */
- (void)updateDetectedAirplanes:(NSArray *)airplanesInfo;

/**
 * Removes an airplane from the view when it is outside of the map.
 * @param airplane The information about the airplane to remove.
 */
- (void)removeAirplaneFromView:(ATCAirplaneInformation *)airplaneData;

/**
 * Prints the borders on the map.
 * @param zones An array containing all the zones, each one referencing its segments.
 */
- (void)displayZones:(NSArray *)zones;

/**
 * Displays the zone controllers on the map.
 * @param zonesControllers
 */
- (void)displayZonesControllers:(NSDictionary *)zonesControllers;

/**
 * Displays the runway on the map.
 * @param airportsControllers
 */
- (void)displayAirportControllers:(NSDictionary *)airportsControllers;

@end
