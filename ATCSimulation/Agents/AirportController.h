//
//  AirportController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicController.h"
#import "ControllerBehaviorDelegate.h"

@interface AirportController : BasicController<ControllerBehaviorDelegate> {
    @private
    NSString *_airportName;
    ATCPoint *_airportLocation;
}

- (id)initWithAirportName:(NSString *)airportName andLocation:(ATCPoint *)airportLocation;

@property (nonatomic, readonly, retain) NSString *airportName;
@property (nonatomic, readonly, retain) ATCPoint *airportLocation;

@end
