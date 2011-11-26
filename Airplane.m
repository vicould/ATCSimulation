//
//  Airplane.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Airplane.h"

@interface Airplane ()

@property (nonatomic, retain) AirplanePosition *currentPosition;
@property (nonatomic, assign) NSInteger speed;
@property (nonatomic, assign) NSInteger route;
@property (nonatomic, retain) NSString *destination;

@end

@implementation Airplane

- (id)initWithTailNumber:(NSString *)tailNumber initialPosition:(AirplanePosition *)airplanePosition andDestination:(NSString *)destinationName {
    self = [super initWithAgentName:tailNumber];
    
    if (self) {
        self.currentPosition = airplanePosition;
    }
    
    return self;
}

@synthesize currentPosition = _currentPosition;
@synthesize route = _route;
@synthesize speed = _speed;
@synthesize destination = _destination;

- (void)dealloc {
    self.currentPosition = nil;
    self.destination = nil;
    
    [super dealloc];
}

@end
