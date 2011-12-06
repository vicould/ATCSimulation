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
@property (nonatomic, retain) NSTimer *displayUpdateTimer;

- (void)createEnvironment;

- (Airplane *)createAirplaneWithInitialInfo:(ATCAirplaneInformation *)position;

- (void)askForDisplayUpdate:(NSTimer *)theTimer;
- (void)performDisplayUpdate;
- (void)performAddAirplaneToMap:(Airplane *)newAirplane;
- (void)performAddMultipleAirplanesToMap;
- (void)performAirplane:(Airplane *)airplane;

- (void)representStartingEnvironment;

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
@synthesize displayUpdateTimer = _displayUpdateTimer;

- (void)createEnvironment {
    // creates the zone controllers
    self.zoneControllers = [[NSMutableArray alloc] initWithCapacity:2];
    [self.zoneControllers addObject:[[ZoneController alloc] init]];
    [self.zoneControllers addObject:[[ZoneController alloc] init]];

    // creates the airport controllers
    self.airportControllers = [[NSMutableArray alloc] initWithCapacity:1];
    [self.airportControllers addObject:[[AirportController alloc] initWithAirportName:@"KLAF" andLocation:[[ATCPoint alloc] initWithCoordinateX:135 andCoordinateY:140]]];
    
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
    
    ATCAirplaneInformation *airplaneData = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:[[ATCPoint alloc] initWithCoordinateX:230 andCoordinateY:80]];
    airplaneData.course = 270;
    airplaneData.speed = 100;
    airplaneData.destination = @"KORD";
    airplaneData.airplaneName = @"N38394";
    
    [self.airplanes addObject:[self createAirplaneWithInitialInfo:airplaneData]];
    
    [airplaneData release];
    
    // display the initial interface
    [self performSelectorOnMainThread:@selector(representStartingEnvironment) withObject:nil waitUntilDone:NO];
}

- (Airplane *)createAirplaneWithInitialInfo:(ATCAirplaneInformation *)position {
    
    Airplane *newAirplane = [[Airplane alloc] initWithInitialData:position];
    
    return [newAirplane autorelease];
}

- (void)startSimulation {    
    // sends broadcast message so that the agents know the simulation started
    NSDictionary *messageContent = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Environment", [NSNumber numberWithInt:NVMessageSimulationStarted], nil] forKeys:[NSArray arrayWithObjects:kNVKeyOrigin, kNVKeyCode, nil]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNVBroadcastMessage object:nil userInfo:messageContent];
    
    // sets a timer so that the positions are refreshed
    self.displayUpdateTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(askForDisplayUpdate:) userInfo:nil repeats:YES];
}

- (void)stopSimulation {
    // sends a message to the agents so that they stop playing with each other
    NSDictionary *messageContent = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Environment", [NSNumber numberWithInt:NVMessageSimulationStopped], nil] forKeys:[NSArray arrayWithObjects:kNVKeyOrigin, kNVKeyCode, nil]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kNVBroadcastMessage object:nil userInfo:messageContent];
    
    // stops the timer
    [self.displayUpdateTimer invalidate];
    
}

- (void)resetSimulation {
    self.zones = nil;
    self.airplanes = nil;
    self.airportControllers = nil;
    self.zoneControllers = nil;
    
    [self createEnvironment];
}

- (void)askForDisplayUpdate:(NSTimer *)theTimer {
    [self performSelectorOnMainThread:@selector(performDisplayUpdate) withObject:nil waitUntilDone:NO];
}

- (void)performDisplayUpdate {
    [self.displayDelegate updateAirplanesPositions:self.airplanes];
}

- (void)performAddAirplaneToMap:(Airplane *)newAirplane {
    [self.displayDelegate addAirplaneToMap:newAirplane];
}

- (void)performAddMultipleAirplanesToMap {
    [self.displayDelegate addAirplanesToMap:self.airplanes];
}

- (void)performAirplane:(Airplane *)airplane {
    [self.displayDelegate landAirplane:airplane];
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
    
    [self.displayDelegate addAirplanesToMap:self.airplanes];
}

# pragma mark - Artifacts delegation

- (void)updateInterfaceWithInformationsForZone:(NSArray *)informations {
    
}

- (void)landAirplane:(ATCAirplaneInformation *)airplane {
    
}

- (void)crashAirplane:(ATCAirplaneInformation *)airplane {
    
}

@end
