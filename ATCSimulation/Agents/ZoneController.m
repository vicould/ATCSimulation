//
//  ZoneController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ZoneController.h"

@interface ZoneController ()

- (void)analyzePosition:(NSString *)positionString fromAirplaneName:(NSString *)tailNumber;

@end

@implementation ZoneController

- (id)init {
    self = [super init];
    
    if (self) {
        self.controllerDelegate = self;
    }
    
    return self;
}

- (void)finishMessageAnalysis:(NSString *)messageContent withMessageCode:(NVMessageCode)code from:(NSString *)sender originallyTo:(NSString *)originalReceiver {
    
    if (code == NVMessageCurrentPosition) {
        [self analyzePosition:messageContent fromAirplaneName:originalReceiver];
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
        information.coordinates.X = [(NSString *)[positionElements objectAtIndex:1] floatValue];
        information.coordinates.Y = [(NSString *)[positionElements objectAtIndex:2] floatValue];
        information.course = [(NSString *)[positionElements objectAtIndex:3] intValue];
        information.speed = [(NSString *)[positionElements objectAtIndex:4] intValue];
        
        if (new) {
            [self.controlledAirplanes setValue:information forKey:tailNumber];
        }
    }
    
}



@end
