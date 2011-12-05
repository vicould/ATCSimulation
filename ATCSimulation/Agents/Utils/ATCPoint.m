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
        self.X = x;
        self.Y = y;
    }
    
    return self;
}

@synthesize X = _X;
@synthesize Y = _Y;

# pragma mark - class methods

+ (ATCPoint *)pointFromExisting:(ATCPoint *)point {
    return [[[ATCPoint alloc] initWithCoordinateX:point.X andCoordinateY:point.Y] autorelease];
}

@end
