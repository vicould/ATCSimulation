//
//  Point.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCPoint.h"

@implementation ATCPoint

- (id)initWithCoordinateX:(NSNumber *)x andCoordinateY:(NSNumber *)y {
    self = [super init];
    
    if (self) {
        self.coordinateX = x;
        self.coordinateY = y;
    }
    
    return self;
}

@synthesize coordinateX = _coordinateX;
@synthesize coordinateY = _coordinateY;

- (void)dealloc {
    self.coordinateX = nil;
    self.coordinateY = nil;
    
    [super dealloc];
}

@end
