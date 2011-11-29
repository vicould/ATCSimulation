//
//  EnvironmentDisplayDelegate.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol EnvironmentDisplayDelegate <NSObject>

- (BOOL)addAirplaneToMap:(Airplane *)newAirplane;
- (BOOL)removeAirplaneFromMap:(Airplane *)airplane byLandingIt:(BOOL)landed;
- (void)updateAirplanesPositions:(NSArray *)airplanes;

@end
