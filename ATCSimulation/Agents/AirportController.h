//
//  AirportController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicController.h"
#import "ControllerBehaviorDelegate.h"

/**
 * One of the two specialized agent playing the role of controller. The airport controller handles 
 * as the name can let it guess an airport, and the zone surrounding it. It is not able to 
 * track the planes inside the zone but can still use the default messaging ability of every agent.
 */
@interface AirportController : BasicController<ControllerBehaviorDelegate> {
    @private
    NSString *_airportName;
    ATCPoint *_airportLocation;
}

/**
 * Creates one instance of the agent, with some specific attributes.
 * @param airportName The name of the airport, used by the airplanes to track their destination.
 * @param airportLocation The position of the runway.
 */
- (id)initWithAirportName:(NSString *)airportName location:(ATCPoint *)airportLocation andID:(int)ID;

/**
 * Gets the name of the airport.
 */
@property (nonatomic, readonly, retain) NSString *airportName;

/**
 * Gets the position of the runway.
 */
@property (nonatomic, readonly, retain) ATCPoint *airportLocation;

@end
