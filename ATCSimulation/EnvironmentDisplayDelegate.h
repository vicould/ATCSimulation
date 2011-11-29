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
- (void)removeAirplaneFromMap:(Airplane *)airplane byLandingIt:(BOOL)landed;
- (void)updateAirplanesPositions:(NSArray *)airplanes;

@end
