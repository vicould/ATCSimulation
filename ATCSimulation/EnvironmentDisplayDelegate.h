//
//  EnvironmentDisplayDelegate.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EnvironmentDisplayDelegate <NSObject>

- (void)addAirplanesToMap:(NSArray *)newAirplanes;
- (void)addAirplaneToMap:(Airplane *)newAirplane;
- (void)crashAirplane:(Airplane *)airplane;
- (void)landAirplane:(Airplane *)airplane;
- (void)updateAirplanesPositions:(NSArray *)airplanes;

- (void)displayZones:(NSArray *)zonesBorders;
- (void)displayZonesControllers:(NSArray *)zonesControllers;
- (void)displayAirportControllers:(NSArray *)airportsControllers;

@end
