//
//  ZoneController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ZoneController.h"
#import "ZoneController+Collision.h"

@interface ZoneController ()

@property (nonatomic, retain) NSTimer *positionUpdatePollingTimer;
@property (nonatomic, retain) NSMutableSet *modifiedAirplanes;

- (void)analyzePosition:(NSString *)positionString fromAirplaneName:(NSString *)tailNumber;
- (void)sendNewFlightSpeed:(float)speed toPlane:(NSString *)plane;
- (void)stopFollowingAirplane:(NSString *)airplaneName;
- (void)tellAirplaneToResumeCourse:(NSTimer *)timer;
- (void)preventCollisions;

@end

@implementation ZoneController

- (id)initWithID:(int)ID {
    self = [super initWithID:ID];
    
    if (self) {
        self.controllerDelegate = self;
        self.modifiedAirplanes = [NSMutableSet set];
    }
    
    return self;
}

@synthesize positionUpdatePollingTimer = _positionUpdatePollingTimer;
@synthesize modifiedAirplanes = _modifiedAirplanes;

- (void)dealloc {
    
    [self.positionUpdatePollingTimer invalidate];
    self.positionUpdatePollingTimer = nil;
}

- (void)startSimulation {
    [super startSimulation];
    [self detectAirplanesInZone];
    
    // inits a timer to regulary poll new data from the airplanes
    self.positionUpdatePollingTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(detectAirplanesInZone) userInfo:nil repeats:YES];
}

- (void)stopSimulation {
    // stops position polling timer
    [self.positionUpdatePollingTimer invalidate];
}

# pragma mark - Messages

# pragma mark Emission
- (void)detectAirplanesInZone {
    // sends a broadcast message to all airplanes currently in zone
    [self sendMessage:@"" fromType:NVMessageCurrentPosition toAgent:[BasicController messageIdentifierForZone:self.zoneID]];
    [self.artifactDelegate updateInterfaceWithInformations:[self.controlledAirplanes allValues]];
}

- (void)sendNewFlightSpeed:(float)speed toPlane:(NSString *)plane {
    [self sendMessage:[NSString stringWithFormat:@"%f", speed] fromType:NVMessageNewSpeedInstruction toAgent:plane];
}

- (void)tellAirplaneToResumeCourse:(NSTimer *)timer {
    [self.modifiedAirplanes removeObject:[timer userInfo]];
    [self sendMessage:@"" fromType:NVMessageResumeInitialDestination toAgent:[timer userInfo]];
}

# pragma mark Analysis
- (void)finishMessageAnalysis:(NSString *)messageContent withMessageCode:(NVMessageCode)code from:(NSString *)sender originallyTo:(NSString *)originalReceiver {
    
    if (code == NVMessageCurrentPosition) {
        [self analyzePosition:messageContent fromAirplaneName:sender];
    } if (code == NVMessageLeavingZone) {
        [self stopFollowingAirplane:sender];
    }
}

- (void)analyzePosition:(NSString *)positionString fromAirplaneName:(NSString *)tailNumber {
    // message is a position
    // let's parse it
    NSArray *positionElements = [positionString componentsSeparatedByString:@";"];
    
    if ([positionElements count] != 5) {
        // invalid message ...
    } else  {
        
        ATCAirplaneInformation *information = [self.controlledAirplanes objectForKey:tailNumber];
        
        if (information == nil) {
            // airplane is new, we should add it to the collection of controlled airplanes
            information = [[ATCAirplaneInformation alloc] initWithZone:self.zoneID andPoint:[[[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:0] autorelease]];
            information.airplaneName = tailNumber;
            NSLog(@"new airplane %@, in %@", tailNumber, self.agentName);
            [self.controlledAirplanes setValue:information forKey:tailNumber];
            [information release];
        }
        
        information.destination = [positionElements objectAtIndex:0];
        information.coordinates.X = [(NSString *)[positionElements objectAtIndex:1] floatValue];
        information.coordinates.Y = [(NSString *)[positionElements objectAtIndex:2] floatValue];
        information.course = [(NSString *)[positionElements objectAtIndex:3] intValue];
        information.speed = [(NSString *)[positionElements objectAtIndex:4] intValue];
        information.informationValidity = [NSDate date];
    }
    
    [self preventCollisions];
}

- (void)preventCollisions {
    // tests all the airplanes in the zone by pairs
    for (NSString *airplane1Name in [self.controlledAirplanes keyEnumerator]) {
        for (NSString *airplane2Name in [self.controlledAirplanes keyEnumerator]) {
            if ([airplane1Name isEqualToString:airplane2Name] || [self.modifiedAirplanes containsObject:airplane2Name]) {
                continue;
            }
            ATCAirplaneInformation *airplane1 = [self.controlledAirplanes objectForKey:airplane1Name];
            ATCAirplaneInformation *airplane2 = [self.controlledAirplanes objectForKey:airplane2Name];
            if ([self evaluateRiskBetweenAirplane1:airplane1 andAirplane2:airplane2]) {
                [self sendNewFlightSpeed:(airplane2.speed + 100) toPlane:airplane2Name];
                [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(tellAirplaneToResumeCourse:) userInfo:airplane2Name repeats:NO];
                [self.modifiedAirplanes addObject:airplane1.airplaneName];
            }
        }
    }
}

- (void)stopFollowingAirplane:(NSString *)airplaneName {
    [self.controlledAirplanes removeObjectForKey:airplaneName];
    [self.artifactDelegate removeAirplane:airplaneName];
}



@end
