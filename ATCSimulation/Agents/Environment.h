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

@interface Environment : NSObject<ArtifactsDelegate> {
    @private
    NSMutableArray *_zones;
    NSMutableArray *_airportControllers;
    NSMutableArray *_zoneControllers;
    NSMutableArray *_airplanes;
    id<EnvironmentDisplayDelegate> _displayDelegate;
    NSTimer *_displayUpdateTimer;
}

- (id)initWithDisplayDelegate:(id)object;

@property (nonatomic, readonly, retain) NSMutableArray *zones;
@property (nonatomic, readonly, retain) NSMutableArray *airportControllers;
@property (nonatomic, readonly, retain) NSMutableArray *zoneControllers;
@property (readonly, retain) NSMutableArray *airplanes;
@property (nonatomic, retain) id<EnvironmentDisplayDelegate> displayDelegate;

- (void)startSimulation;
- (void)stopSimulation;
- (void)resetSimulation;

@end