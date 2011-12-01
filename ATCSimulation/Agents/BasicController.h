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
    NSInteger _zoneID;
    id<ControllerBehaviorDelegate> _controllerDelegate;
}

@property (nonatomic, readonly, retain) NSMutableDictionary *controlledAirplanes;
@property (nonatomic, readonly, assign) NSInteger zoneID;

- (void)detectAirplanesInZone;

+ (NSInteger)createZoneID;
+ (NSString *)zoneIdentifierAsStringWithID:(NSInteger)ID;
+ (NSString *)messageIdentifierForZone:(NSInteger)zoneID;

@end
