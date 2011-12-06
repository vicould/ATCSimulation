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
 * Adds a list of airplanes to the map.
 * @param newAirplanes The airplanes to add to the interface.
 */
- (void)addAirplanesToMap:(NSArray *)newAirplanes;

/**
 * Add a single airplane to the map.
 * @param newAirplane The airplane to add.
 */
- (void)addAirplaneToMap:(Airplane *)newAirplane;

/**
 * Crashes an airplane, to inform the user a collision or an accident happened.
 * @param airplane
 */
- (void)crashAirplane:(Airplane *)airplane;

/**
 * Lands an airplane once it has reached its destination.
 * @param airplane
 */
- (void)landAirplane:(Airplane *)airplane;

/**
 * Updates the location of the airplanes on the map.
 * @param newAirplanes
 */
- (void)updateAirplanesPositions:(NSArray *)airplanes;

# pragma mark - Methods for the zones and the controllers.

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
