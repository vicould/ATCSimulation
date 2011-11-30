//
//  BasicController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicAgent.h"
#import "AgentBehaviorDelegate.h"

@interface BasicController : BasicAgent<AgentBehaviorDelegate> {
    @private
    NSMutableArray *_controlledAirplanes;
    NSInteger _zoneID;
}

@property (nonatomic, readonly, retain) NSMutableArray *controlledAirplanes;
@property (nonatomic, readonly, assign) NSInteger zoneID;

- (void)detectAirplanesInZone;

+ (NSInteger)createZoneID;
+ (NSString *)zoneIdentifierAsStringWithID:(NSInteger)ID;
+ (NSString *)messageIdentifierForZone:(NSInteger)zoneID;

@end
