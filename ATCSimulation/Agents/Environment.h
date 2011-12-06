//
//  Environment.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCZone.h"
#import "Airplane.h"
#import "ATCPoint.h"
#import "ATCAirplaneInformation.h"
#import "AirportController.h"
#import "ZoneController.h"

#import "EnvironmentDisplayDelegate.h"
#import "ArtifactsDelegate.h"

@class ATCZone;
@class Airplane;
@class ATCPoint;
@class ATCAirplaneInformation;
@class AirportController;
@class ZoneController;

/**
 * The environment of the simulation, handling the different agents that interact together, the playground for them
 * (the map, the borders, the zones).
 *
 * It provides several artifacts to these agents, defined either in the Artifacts or in the ArtifactsDelegate, to help
 * them perform certain actions (such as calculate their position, etc.), or access the interface.
 *
 * The environment also owns a reference to the main interface of the application, so that it can display on the screen
 * information to the user.
 */
@interface Environment : NSObject<ArtifactsDelegate> {
    @private
    NSMutableArray *_zones;
    NSMutableArray *_airportControllers;
    NSMutableArray *_zoneControllers;
    NSMutableArray *_airplanes;
    id<EnvironmentDisplayDelegate> _displayDelegate;
}

/**
 * Creates an instance of the environment, and sets the display delegate responding to the methods defined 
 * in the EnvironmentDisplayDelegate protocol, so that the environment can ask to perform certain actions on the
 * interface.
 * @param The delegate allowing access to the interface. All calls to the interface must be made on the main thread.
 */
- (id)initWithDisplayDelegate:(id)object;

/**
 * Gets the zones that cluster the map.
 */
@property (nonatomic, readonly, retain) NSMutableArray *zones;

/**
 * Gets the airport controllers running in the simulation.
 */
@property (nonatomic, readonly, retain) NSMutableArray *airportControllers;

/**
 * Gets the zone controllers running in the simulation.
 */
@property (nonatomic, readonly, retain) NSMutableArray *zoneControllers;

/**
 * Gets the airplanes running in the simulation.
 */
@property (readonly, retain) NSMutableArray *airplanes;

/**
 * Property permitting an access to the interface delegate.
 */
@property (nonatomic, retain) id<EnvironmentDisplayDelegate> displayDelegate;

/**
 * Starts the simulation once it is ready.
 */
- (void)startSimulation;

/**
 * Stops the simulation.
 */
- (void)stopSimulation;

/**
 * Resets the simulation, recreates the environment and the agents interacting in it.
 */
- (void)resetSimulation;

@end