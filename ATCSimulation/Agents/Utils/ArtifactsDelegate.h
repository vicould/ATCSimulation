//
//  ArtifactsDelegate.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCAirplaneInformation.h"


/**
 * Protocol declaring abstract methods that can be used by the agents. These methods, or artifacts, are 
 * implemented by the environment, and provide some kind of services at disposition.
 */
@protocol ArtifactsDelegate <NSObject>

/**
 * Asks the environment to display on the map the informations retrieved by the controllers.
 * @param informations An array containing ATCAirplaneInformation objects, as created by the caller.
 */
- (void)updateInterfaceWithInformationsForZone:(NSArray *)informations;

/**
 * Asks the environment to hide the specified airplane, as it has reached its destination.
 * @param airplane The informations about the airplane that should land.
 */
- (void)landAirplane:(ATCAirplaneInformation *)airplane;

/**
 * Asks the environment to hide the specified airplane, as it crashed (after running out of fuel or
 * colliding with another airplane).
 * @param airplane The informations about the airplane that just had an accident.
 */
- (void)crashAirplane:(ATCAirplaneInformation *)airplane;

@end
