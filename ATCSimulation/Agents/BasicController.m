//
//  BasicController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicController.h"

@interface BasicController ()

@property (nonatomic, retain) NSMutableDictionary *controlledAirplanes;
@property (nonatomic, assign) NSInteger zoneID;
@property (nonatomic, retain) id<ControllerBehaviorDelegate> controllerDelegate;

- (void)analyzePosition:(NSString *)positionString fromAirplaneName:(NSString *)tailNumber;

@end

@implementation BasicController

- (id)init {
    NSInteger ID = [BasicController createZoneID];
    self = [super initWithAgentName:[BasicController zoneIdentifierAsStringWithID:ID]];
    
    if (self) {
        _zoneID = ID;
        _controlledAirplanes = [[NSMutableDictionary alloc] init];
        
        self.messageReceiver = self;
        
    }
    
    return self;
}

@synthesize controlledAirplanes = _controlledAirplanes;
@synthesize zoneID = _zoneID;
@synthesize controllerDelegate = _controllerDelegate;

- (void)startSimulation {
    [self detectAirplanesInZone];
}

# pragma mark - Messages

# pragma mark Emission
- (void)detectAirplanesInZone {
    // send a broadcast message to all airplanes currently in zone
    [self sendMessage:@"" fromType:NVMessageCurrentPosition toAgent:[BasicController messageIdentifierForZone:self.zoneID]];
}

# pragma mark Processing
- (void)analyzeMessage:(NSDictionary *)messageContent withOriginalDestinator:(NSString *)destinator {
    int code = [(NSNumber *)[messageContent objectForKey:kNVKeyCode] intValue];
    
    if (code == NVMessageCurrentPosition) {
        [self analyzePosition:[messageContent objectForKey:kNVKeyContent] fromAirplaneName:[messageContent objectForKey:kNVKeyOrigin]];
        
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
        
        ATCAirplaneInformation *information = [self.controlledAirplanes objectForKey:(NSString *)[positionElements objectAtIndex:0]];
        
        if (information == nil) {
            // airplane is new, we should add it to the collection of controlled airplanes
            new = YES;
            information = [[ATCAirplaneInformation alloc] initWithZone:self.zoneID andPoint:[[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:0]];
        }
        
        
        
        if (new) {
            
        }
    }

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

+ (NSString *)messageIdentifierForZone:(NSInteger)zoneID {
    return [NSString stringWithFormat:@"Zone %d messages", zoneID];
}

@end
