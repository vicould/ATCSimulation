//
//  BasicController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicAgent.h"
#import "AgentBehaviorDelegate.h"
#import "ControllerBehaviorDelegate.h"
#import "ATCAirplaneInformation.h"

@class ATCAirplaneInformation;

@interface BasicController : BasicAgent<AgentBehaviorDelegate> {
    @private
    NSMutableDictionary *_controlledAirplanes;
    int _zoneID;
    id<ControllerBehaviorDelegate> _controllerDelegate;
    NSTimer *positionUpdatePollingTimer;
}

@property (readonly, retain) NSMutableDictionary *controlledAirplanes;
@property (nonatomic, readonly, assign) int zoneID;
@property (nonatomic, retain) id<ControllerBehaviorDelegate> controllerDelegate;

- (void)detectAirplanesInZone;

+ (int)createZoneID;
+ (NSString *)zoneIdentifierAsStringWithID:(int)ID;
+ (NSString *)messageIdentifierForZone:(int)zoneID;

@end
