//
//  AirplanePosition.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AirplanePosition.h"

@implementation AirplanePosition

- (id)initWithZone:(NSInteger)currentZone andPositionX:(NSNumber *)currentX andY:(NSNumber *)currentY {
    
    self = [super init];
    
    if (self) {
        self.zone = currentZone;
        self.positionX = currentX;
        self.positionY = currentY;
    }
    
    return self;
}

@synthesize zone = _zone;
@synthesize positionX = _positionX;
@synthesize positionY = _positionY;

- (void)dealloc {
    self.positionX = nil;
    self.positionY = nil;
    
    [super dealloc];
}

@end
