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

# pragma mark - Methods for the controllers.

/**
 * Asks the environment to display on the map the informations retrieved by the controllers.
 * @param informations An array containing ATCAirplaneInformation objects, as created by the caller.
 */
- (void)updateInterfaceWithInformations:(NSArray *)informations;

/**
 * A method to create a unique ID for each class.
 * @return Returns an unique id that can be used to identify the zones.
 */
- (int)createZoneID;

# pragma mark Routes decisions

- (ATCPoint *)calculatePlanesIntersectionWithPlane1Infos:(ATCAirplaneInformation *)plane1 andPlane2Infos:(ATCAirplaneInformation *)plane2;

# pragma mark - Methods for the airplane.

# pragma mark Display
/**
 * Asks the environment to display on the map one object. This methods is typically invoked from the airplane.
 * @param information The information to display on the map.
 */
- (void)updateAirplaneInformation:(ATCAirplaneInformation *)information;

/**
 * Asks the environment to hide the specified airplane, as it has reached its destination.
 * @param airplane The informations about the airplane that should land.
 */
- (void)landAirplane:(NSString *)airplaneName;

/**
 * Asks the environment to hide the specified airplane, as it crashed (after running out of fuel or
 * colliding with another airplane).
 * @param airplane The informations about the airplane that just had an accident.
 */
- (void)crashAirplane:(ATCAirplaneInformation *)airplaneInfo;

/**
 * Method used by the controllers to remove an airplane from the simulation when it exited the map.
 * @param airplane The airplane to remove from the simulation.
 */
- (void)removeAirplane:(NSString *)airplaneName;

# pragma mark position

/**
 * Returns the id of the current zone where the plane is located.
 * @param location The position of the airplane.
 * @return The ID of the zone where the plane is at.
 */
- (NSInteger)calculateCurrentZoneFromPoint:(ATCPoint *)location;

/**
 * Calculates the distance to the next zone with the route and the initial position.
 * @param position The point where the airplane currently is located.
 * @param route The azimut it follows.
 * @return The distance to the next zone on a straight line.
 */
- (float)distanceFromNextZone:(ATCPoint *)position onRoute:(NSInteger *)route;

/**
 * Convenient method to calculate the new point reached by the airplane after flying for a certain time,
 * with the parameters of the flight given in the other parameter.
 * @param currentPosition The information about the current airplane, such as the route, the speed, and the initial position.
 * @param interval The length of the flight.
 * @return Returns the new location of the airplane.
 */
- (ATCPoint *)calculateNewPositionFromCurrent:(ATCAirplaneInformation *)currentPosition afterInterval:(NSTimeInterval)interval;

/**
 * Get the name of the controller for the specified zone ID.
 * @param zoneID The id of the zone where the controller's name is desired.
 * @return The name of the controller managing the zone.
 */
- (NSString *)controllerNameForZoneID:(int)zoneID;

/**
 * Method to calculate the course to follow to reach the destination.
 * @param destination The destination to fly to.
 * @param currentLocation The current location of the airplane.
 * @return The course, in degrees, to follow to reach the airport.
 */
- (float)calculateAzimutToDestination:(NSString *)destination fromPoint:(ATCPoint *)currentLocation;

- (void)lineEquationFromPoint:(ATCPoint *)initialPoint andCourse:(float)course WithA:(float *)a b:(float *)b andC:(float *)c;

- (BOOL)checkIfPointIsOnRunway:(ATCPoint *)point fromZone:(int)zoneID;

@end
