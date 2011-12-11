//
//  ZoneController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ZoneController.h"

@interface ZoneController ()

@property (nonatomic, retain) NSTimer *positionUpdatePollingTimer;

- (void)analyzePosition:(NSString *)positionString fromAirplaneName:(NSString *)tailNumber;
- (void)sendNewFlightCourse:(float)course toPlane:(NSString *)plane;
- (void)stopFollowingAirplane:(NSString *)airplaneName;

@end

@implementation ZoneController

- (id)initWithID:(int)ID {
    self = [super initWithID:ID];
    
    if (self) {
        self.controllerDelegate = self;
    }
    
    return self;
}

@synthesize positionUpdatePollingTimer = _positionUpdatePollingTimer;

- (void)dealloc {
    
    [self.positionUpdatePollingTimer invalidate];
    [self.positionUpdatePollingTimer release];
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

- (void)sendNewFlightCourse:(float)course toPlane:(NSString *)plane {
    [self sendMessage:[NSString stringWithFormat:@"%f", course] fromType:NVMessageNewRouteInstruction toAgent:plane];
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
        BOOL new = NO;
        
        ATCAirplaneInformation *information = [self.controlledAirplanes objectForKey:tailNumber];
        
        if (information == nil) {
            // airplane is new, we should add it to the collection of controlled airplanes
            new = YES;
            information = [[ATCAirplaneInformation alloc] initWithZone:self.zoneID andPoint:[[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:0]];
            information.airplaneName = tailNumber;
            NSLog(@"new airplane %@, in %@", tailNumber, self.agentName);
        }
        
        information.destination = [positionElements objectAtIndex:0];
        information.coordinates.X = [(NSString *)[positionElements objectAtIndex:1] floatValue];
        information.coordinates.Y = [(NSString *)[positionElements objectAtIndex:2] floatValue];
        information.course = [(NSString *)[positionElements objectAtIndex:3] intValue];
        information.speed = [(NSString *)[positionElements objectAtIndex:4] intValue];
        information.informationValidity = [NSDate date];

        if (new) {
            [self.controlledAirplanes setValue:information forKey:tailNumber];
        }
    }
    
}

- (void)preventCollisions {
    
}

- (void)stopFollowingAirplane:(NSString *)airplaneName {
    [self.controlledAirplanes removeObjectForKey:airplaneName];
    [self.artifactDelegate removeAirplane:airplaneName];
}



@end
