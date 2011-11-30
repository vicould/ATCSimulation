//
//  Environment.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Environment.h"

@interface Environment ()

@property (nonatomic, retain) NSArray *zones;
@property (nonatomic, retain) NSMutableArray *airplanes;
@property (nonatomic, retain) NSTimer *displayUpdateTimer;

- (void)createEnvironment;

- (ATCZone *)createZoneWithController:(BasicController *)controller isAirportController:(BOOL)airportController;
- (AirportController *)createDestinationWithName:(NSString *)destinationName;
- (Airplane *)createAirplaneWithName:(NSString *)airplaneName andDestination:(NSString *)destination;

- (void)askForDisplayUpdate:(NSTimer *)theTimer;
- (void)performDisplayUpdate;

@end

@implementation Environment

- (id)init {
    self = [super init];
    
    if (self) {
        [self createEnvironment];
    }
    
    return self;
}

@synthesize zones = _zones;
@synthesize airplanes = _airplanes;
@synthesize displayDelegate = _displayDelegate;
@synthesize displayUpdateTimer = _displayUpdateTimer;

- (void)createEnvironment {
    // creates the different zones composing the map
    self.zones = [NSArray arrayWithObject:nil];
    
    // creates the collection of airplanes
    self.airplanes = [NSMutableArray array];
}

- (ATCZone *)createZoneWithController:(BasicController *)controller isAirportController:(BOOL)airportController {
    ATCZone *zone = [[ATCZone alloc] initWithCorners:nil withControllerName:controller.agentName andIsAirport:airportController];
    
    return [zone autorelease];
}

- (Airplane *)createAirplaneWithName:(NSString *)airplaneName andDestination:(NSString *)destination{
    ATCPosition *initialPosition = [[ATCPosition alloc] initWithZone:1 andPoint:[[ATCPoint alloc] initWithCoordinateX:[NSNumber numberWithFloat:256] andCoordinateY:[NSNumber numberWithFloat:256]]];
    
    Airplane *newAirplane = [[Airplane alloc] initWithTailNumber:airplaneName initialPosition:initialPosition andDestination:destination];
    
    [self.airplanes addObject:newAirplane];
    
    return [newAirplane autorelease];
}

- (AirportController *)createDestinationWithName:(NSString *)destinationName {
    AirportController *airport = [[AirportController alloc] initWithAgentName:destinationName];
    
    return [airport autorelease];
}

- (void)startSimulation {
    // sends broadcast message so that the agents know the simulation started
    NSDictionary *messageContent = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Environment", [NSNumber numberWithInt:NVMessageSimulationStarted], nil] forKeys:[NSArray arrayWithObjects:kNVKeyOrigin, kNVKeyCode, nil]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNVBroadcastMessage object:nil userInfo:messageContent];
    
    // sets a timer so that the positions are refreshed
    self.displayUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(askForDisplayUpdate:) userInfo:nil repeats:YES];
}

- (void)stopSimulation {
    self.zones = nil;
    self.airplanes = nil;
    
    // stops the timer
    [self.displayUpdateTimer invalidate];
    
    [self createEnvironment];
}

- (void)askForDisplayUpdate:(NSTimer *)theTimer {
    [self performSelectorOnMainThread:@selector(performDisplayUpdate) withObject:nil waitUntilDone:NO];
}

- (void)performDisplayUpdate {
    [self.displayDelegate updateAirplanesPositions:self.airplanes];
}

@end
