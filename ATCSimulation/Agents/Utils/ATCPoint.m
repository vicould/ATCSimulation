//
//  Point.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCPoint.h"

@implementation ATCPoint

- (id)initWithCoordinateX:(float)x andCoordinateY:(float)y {
    self = [super init];
    
    if (self) {
        self.coordinateX = x;
        self.coordinateY = y;
    }
    
    return self;
}

@synthesize coordinateX = _coordinateX;
@synthesize coordinateY = _coordinateY;

# pragma mark - class methods

+ (ATCPoint *)pointFromExisting:(ATCPoint *)point {
    return [[[ATCPoint alloc] initWithCoordinateX:point.coordinateX andCoordinateY:point.coordinateY] autorelease];
}

@end
