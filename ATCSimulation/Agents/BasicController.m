//
//  BasicController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicController.h"

@interface BasicController ()

@property (nonatomic, retain) NSMutableArray *controlledAirplanes;
@property (nonatomic, assign) NSInteger zoneID;

@end

@implementation BasicController

- (id)init {
    NSInteger ID = [BasicController createZoneID];
    self = [super initWithAgentName:[BasicController zoneIdentifierAsStringWithID:ID]];
    
    if (self) {
        _zoneID = ID;
        _controlledAirplanes = [[NSMutableArray alloc] init];
        
    }
    
    return self;
}

@synthesize controlledAirplanes = _controlledAirplanes;
@synthesize zoneID = _zoneID;

- (void)detectAirplanesInZone {
    // send a broadcast message to all airplanes currently in zone
    [self sendMessage:@"" fromType:NVMessageCurrentPosition toAgent:[BasicController zoneIdentifierAsStringWithID:self.zoneID]];
}

- (void)startSimulation {
    [self detectAirplanesInZone];
}

- (void)analyzeMessage:(NSDictionary *)messageContent withOriginalDestinator:(NSString *)destinator {
    
}

# pragma mark - Class stuff

static NSInteger lastID = 0;

+ (NSInteger)createZoneID {
    lastID++;
    return lastID;
}

+ (NSString *)zoneIdentifierAsStringWithID:(NSInteger)ID {
    return [NSString stringWithFormat:@"Zone %d", ID];
}

@end
