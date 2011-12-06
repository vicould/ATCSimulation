//
//  BasicController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicController.h"

@interface BasicController ()

@property (retain) NSMutableDictionary *controlledAirplanes;
@property (nonatomic, assign) int zoneID;

@end

@implementation BasicController

- (id)init {
    int ID = [BasicController createZoneID];
    self = [super initWithAgentName:[BasicController zoneIdentifierAsStringWithID:ID]];
    
    if (self) {
        _zoneID = ID;
        _controlledAirplanes = [[NSMutableDictionary alloc] init];
        
        self.agentBehaviorDelegate = self;
        
    }
    
    return self;
}

- (void)dealloc {
    self.controlledAirplanes = nil;
    self.controllerDelegate = nil;
    [positionUpdatePollingTimer invalidate];
    [positionUpdatePollingTimer release];
}

@synthesize controlledAirplanes = _controlledAirplanes;
@synthesize zoneID = _zoneID;
@synthesize controllerDelegate = _controllerDelegate;

- (void)startSimulation {
    [self detectAirplanesInZone];
    
    // inits a timer to regulary poll new data from the airplanes
    positionUpdatePollingTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(detectAirplanesInZone) userInfo:nil repeats:YES];    
}

- (void)stopSimulation {
    // stops position polling timer
    [positionUpdatePollingTimer invalidate];
}

# pragma mark - Messages

# pragma mark Emission
- (void)detectAirplanesInZone {
    // sends a broadcast message to all airplanes currently in zone
    [self sendMessage:@"" fromType:NVMessageCurrentPosition toAgent:[BasicController messageIdentifierForZone:self.zoneID]];
}

# pragma mark Processing
- (void)analyzeMessage:(NSDictionary *)messageContent withOriginalDestinator:(NSString *)destinator {
    int code = [(NSNumber *)[messageContent objectForKey:kNVKeyCode] intValue];

    // common messages evaluation
    
    // otherwise passes the message for further analysis to the delegate
    [self.controllerDelegate finishMessageAnalysis:(NSString *)[messageContent objectForKey:kNVKeyContent] withMessageCode:(NSInteger)code from:(NSString *)[messageContent objectForKey:kNVKeyOrigin] originallyTo:destinator];
}

# pragma mark - Class stuff

static int lastID = 0;

+ (int)createZoneID {
    lastID++;
    return lastID;
}

+ (NSString *)zoneIdentifierAsStringWithID:(int)ID {
    return [NSString stringWithFormat:@"Zone %d", ID];
}

+ (NSString *)messageIdentifierForZone:(int)zoneID {
    return [NSString stringWithFormat:@"Zone %d messages", zoneID];
}

@end
