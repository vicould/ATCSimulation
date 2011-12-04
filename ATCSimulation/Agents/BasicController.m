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

- (void)analyzePosition:(NSString *)positionString fromAirplaneName:(NSString *)tailNumber;

@end

@implementation BasicController

- (id)init {
    int ID = [BasicController createZoneID];
    self = [super initWithAgentName:[BasicController zoneIdentifierAsStringWithID:ID]];
    
    if (self) {
        _zoneID = ID;
        _controlledAirplanes = [[NSMutableDictionary alloc] init];
        
        self.messageReceiver = self;
        
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

# pragma mark - Messages

# pragma mark Emission
- (void)detectAirplanesInZone {
    // sends a broadcast message to all airplanes currently in zone
    [self sendMessage:@"" fromType:NVMessageCurrentPosition toAgent:[BasicController messageIdentifierForZone:self.zoneID]];
}

# pragma mark Processing
- (void)analyzeMessage:(NSDictionary *)messageContent withOriginalDestinator:(NSString *)destinator {
    int code = [(NSNumber *)[messageContent objectForKey:kNVKeyCode] intValue];
    
    if (code == NVMessageCurrentPosition) {
        [self analyzePosition:[messageContent objectForKey:kNVKeyContent] fromAirplaneName:[messageContent objectForKey:kNVKeyOrigin]];
        
    } else if (code == NVMessageSimulationStarted) {
        [self startSimulation];
    } else {
        // passes the message for further analysis to the delegate
        [self.controllerDelegate finishMessageAnalysis:(NSString *)[messageContent objectForKey:kNVKeyContent] withMessageCode:(NSInteger)code from:(NSString *)[messageContent objectForKey:kNVKeyOrigin] originallyTo:destinator];
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
        
        ATCAirplaneInformation *information = [self.controlledAirplanes objectForKey:[positionElements objectAtIndex:0]];
        
        if (information == nil) {
            // airplane is new, we should add it to the collection of controlled airplanes
            new = YES;
            information = [[ATCAirplaneInformation alloc] initWithZone:self.zoneID andPoint:[[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:0]];
        }
        
        information.destination = [positionElements objectAtIndex:0];
        information.coordinates.coordinateX = [(NSString *)[positionElements objectAtIndex:1] floatValue];
        information.coordinates.coordinateY = [(NSString *)[positionElements objectAtIndex:2] floatValue];
        information.course = [(NSString *)[positionElements objectAtIndex:3] intValue];
        information.speed = [(NSString *)[positionElements objectAtIndex:4] intValue];
        
        if (new) {
            [self.controlledAirplanes setValue:information forKey:tailNumber];
        }
    }

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
