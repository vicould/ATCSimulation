//
//  Environment.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Environment.h"

@interface Environment ()

@property (nonatomic, retain) NSMutableArray *zones;
@property (nonatomic, retain) NSMutableArray *airportControllers;
@property (nonatomic, retain) NSMutableArray *zoneControllers;
@property (retain) NSMutableArray *airplanes;

- (void)createEnvironment;

- (Airplane *)createAirplaneWithInitialInfo:(ATCAirplaneInformation *)position;

- (void)representStartingEnvironment;

- (void)onMainThreadUpdateInterfaceWithInformations:(NSArray *)informations;
- (void)onMainThreadUpdateAirplaneInformation:(ATCAirplaneInformation *)information;
- (void)onMainThreadLandAirplane:(ATCAirplaneInformation *)airplane;
- (void)onMainThreadCrashAirplane:(ATCAirplaneInformation *)airplane;
- (void)onMainThreadRemoveAirplane:(ATCAirplaneInformation *)airplane;

@end

@implementation Environment

- (id)initWithDisplayDelegate:(id)object {
    self = [super init];
    
    if (self) {
        _displayDelegate = object;
        [self createEnvironment];
    }
    
    return self;
}

@synthesize zones = _zones;
@synthesize airportControllers = _airportControllers;
@synthesize zoneControllers = _zoneControllers;
@synthesize airplanes = _airplanes;
@synthesize displayDelegate = _displayDelegate;

- (void)createEnvironment {
    BasicAgent *agent;
    
    // creates the zone controllers
    self.zoneControllers = [[NSMutableArray alloc] initWithCapacity:2];

    agent = [[ZoneController alloc] init];
    agent.artifactDelegate = self;
    [self.zoneControllers addObject:agent];
    [agent release];
    
    agent = [[ZoneController alloc] init];
    agent.artifactDelegate = self;
    [self.zoneControllers addObject:agent];
    [agent release];
    
    // creates the airport controllers
    self.airportControllers = [[NSMutableArray alloc] initWithCapacity:1];
    
    agent = [[AirportController alloc] initWithAirportName:@"KLAF" andLocation:[[ATCPoint alloc] initWithCoordinateX:135 andCoordinateY:140]];
    agent.artifactDelegate = self;
    [self.airportControllers addObject:agent];
    [agent release];
    
    // creates the different zones composing the map
    
    NSArray *corners1 = [NSArray arrayWithObjects:[[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:187], [[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:187], nil];
    ATCZone *zone1 = [[ATCZone alloc] initWithCorners:corners1 withControllerName:[(BasicAgent *)[self.zoneControllers objectAtIndex:0] agentName] andIsAirport:NO];
    
    NSArray *corners2 = [NSArray arrayWithObjects:[[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:256 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:256 andCoordinateY:187], [[ATCPoint alloc] initWithCoordinateX:192 andCoordinateY:187], [[ATCPoint alloc] initWithCoordinateX:192 andCoordinateY:127], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:127], nil];
    ATCZone *zone2 = [[ATCZone alloc] initWithCorners:corners2 withControllerName:[(BasicAgent *)[self.zoneControllers objectAtIndex:1] agentName] andIsAirport:NO];
    
    NSArray *corners3 = [NSArray arrayWithObjects:[[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:127], [[ATCPoint alloc] initWithCoordinateX:192 andCoordinateY:127], [[ATCPoint alloc] initWithCoordinateX:192 andCoordinateY:187], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:187], nil];
    ATCZone *zone3 = [[ATCZone alloc] initWithCorners:corners3 withControllerName:[(BasicAgent *)[self.airportControllers objectAtIndex:0] agentName] andIsAirport:YES];

    self.zones = [NSMutableArray arrayWithObjects:zone1, zone2, zone3, nil];
    [zone1 release];
    [zone2 release];
    [zone3 release];
    
    // creates the collection of airplanes
    self.airplanes = [NSMutableArray array];
    
    ATCAirplaneInformation *airplaneData1 = [[ATCAirplaneInformation alloc] initWithZone:2 andPoint:[[ATCPoint alloc] initWithCoordinateX:230 andCoordinateY:80]];
    airplaneData1.course = 270;
    airplaneData1.speed = 100;
    airplaneData1.destination = @"KLAF";
    airplaneData1.airplaneName = @"N38394";
    
    [self.airplanes addObject:[self createAirplaneWithInitialInfo:airplaneData1]];
    
    [airplaneData1 release];
    
    ATCAirplaneInformation *airplaneData2 = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:[[ATCPoint alloc] initWithCoordinateX:30 andCoordinateY:20]];
    airplaneData2.course = 120;
    airplaneData2.speed = 100;
    airplaneData2.destination = @"KORD";
    airplaneData2.airplaneName = @"N31862";
    
    [self.airplanes addObject:[self createAirplaneWithInitialInfo:airplaneData2]];
    
    [airplaneData2 release];
    
    // display the initial interface
    [self performSelectorOnMainThread:@selector(representStartingEnvironment) withObject:nil waitUntilDone:NO];
}

- (Airplane *)createAirplaneWithInitialInfo:(ATCAirplaneInformation *)position {
    
    Airplane *newAirplane = [[Airplane alloc] initWithInitialData:position];
    newAirplane.artifactDelegate = self;
    return [newAirplane autorelease];
}

- (void)startSimulation {    
    // sends broadcast message so that the agents know the simulation started
    NSDictionary *messageContent = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Environment", [NSNumber numberWithInt:NVMessageSimulationStarted], nil] forKeys:[NSArray arrayWithObjects:kNVKeyOrigin, kNVKeyCode, nil]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNVBroadcastMessage object:nil userInfo:messageContent];
}

- (void)stopSimulation {
    // sends a message to the agents so that they stop playing with each other
    NSDictionary *messageContent = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Environment", [NSNumber numberWithInt:NVMessageSimulationStopped], nil] forKeys:[NSArray arrayWithObjects:kNVKeyOrigin, kNVKeyCode, nil]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNVBroadcastMessage object:nil userInfo:messageContent];    
}

- (void)resetSimulation {
    self.zones = nil;
    self.airplanes = nil;
    self.airportControllers = nil;
    self.zoneControllers = nil;
    
    [self createEnvironment];
}

- (void)representStartingEnvironment {
    [self.displayDelegate displayZones:self.zones];
    
    // creates a dictionary containing as key the name of the airport, and as value the position of the controller
    NSMutableDictionary *airportsDictionary = [[NSMutableDictionary alloc] initWithCapacity:[self.zoneControllers count]];
    for (AirportController *controller in self.airportControllers) {
        [airportsDictionary setObject:controller.airportLocation forKey:controller.airportName];
    }
    
    [self.displayDelegate displayAirportControllers:airportsDictionary];
    [airportsDictionary release];
    
    NSMutableArray *initialAirplanes = [NSMutableArray arrayWithCapacity:[self.airplanes count]];
    for (Airplane *airplane in self.airplanes) {
        [initialAirplanes addObject:airplane.ownInformation];
    }
    
    [self.displayDelegate displayInitialPlanesPositions:initialAirplanes];
}

# pragma mark - Artifacts delegation


- (void)updateInterfaceWithInformations:(NSArray *)informations {
    [self performSelectorOnMainThread:@selector(onMainThreadUpdateInterfaceWithInformations:) withObject:informations waitUntilDone:NO];
}

- (void)updateAirplaneInformation:(ATCAirplaneInformation *)information {
    [self performSelectorOnMainThread:@selector(onMainThreadUpdateAirplaneInformation:) withObject:information waitUntilDone:NO];
}

- (void)landAirplane:(ATCAirplaneInformation *)airplane {
    [self performSelectorOnMainThread:@selector(onMainThreadLandAirplane:) withObject:airplane waitUntilDone:NO];
}

- (void)crashAirplane:(ATCAirplaneInformation *)airplane {
    [self performSelectorOnMainThread:@selector(onMainThreadCrashAirplane:) withObject:airplane waitUntilDone:NO];
}

- (void)removeAirplane:(ATCAirplaneInformation *)airplane {
    [self performSelectorOnMainThread:@selector(onMainThreadRemoveAirplane:) withObject:airplane waitUntilDone:NO];
}

# pragma mark Corresponding methods for the delegation on the main thread

- (void)onMainThreadUpdateInterfaceWithInformations:(NSArray *)informations {
    [self.displayDelegate updateDetectedAirplanes:informations];
}

- (void)onMainThreadUpdateAirplaneInformation:(ATCAirplaneInformation *)information {
    [self.displayDelegate updateAirplanePositionWithInfo:information];
}

- (void)onMainThreadLandAirplane:(ATCAirplaneInformation *)airplane {
    [self.displayDelegate landAirplane:airplane];
}

- (void)onMainThreadCrashAirplane:(ATCAirplaneInformation *)airplane {
    [self.displayDelegate crashAirplane:airplane];
}

- (void)onMainThreadRemoveAirplane:(ATCAirplaneInformation *)airplane {
    [self.displayDelegate removeAirplaneFromView:airplane];
}

@end
