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
#import "ATCPosition.h"
#import "EnvironmentDisplayDelegate.h"

@class ATCZone;
@class Airplane;
@class ATCPoint;
@class ATCPosition;

@interface Environment : NSObject {
    @private
    NSArray *_zones;
    NSMutableArray *_airplanes;
    id<EnvironmentDisplayDelegate> _displayDelegate;
}

@property (nonatomic, retain) NSArray *zones;
@property (nonatomic, readonly, retain) NSMutableArray *airplanes;
@property (nonatomic, retain) id<EnvironmentDisplayDelegate> displayDelegate;

- (Airplane *)createAirplaneWithName:(NSString *)airplaneName andDestination:(NSString *)destination;

@end