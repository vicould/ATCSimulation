//
//  Environment.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Environment.h"

@implementation Environment

- (id)init {
    self = [super init];
    
    if (self) {
        // creates the different zones composing the map
        
        // creates the collection of airplanes
        _airplanes = [NSMutableArray array];
    }
    
    return self;
}

@synthesize zones = _zones;
@synthesize airplanes = _airplanes;
@synthesize displayDelegate = _displayDelegate;

- (Airplane *)createAirplaneWithName:(NSString *)airplaneName andDestination:(NSString *)destination{
    ATCPosition *initialPosition = [[ATCPosition alloc] initWithZone:1 andPoint:[[ATCPoint alloc] initWithCoordinateX:[NSNumber numberWithFloat:256] andCoordinateY:[NSNumber numberWithFloat:256]]];
    
    Airplane *newAirplane = [[Airplane alloc] initWithTailNumber:airplaneName initialPosition:initialPosition andDestination:destination];
    
    [self.airplanes addObject:newAirplane];
    
    return [newAirplane autorelease];
}

@end
