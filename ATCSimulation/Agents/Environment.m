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

- (ATCZone *)createZoneWithController:(BasicController *)controller isAirportController:(BOOL)airportController;
- (AirportController *)createDestinationWithName:(NSString *)destinationName;
- (Airplane *)createAirplaneWithInitialInfo:(ATCAirplaneInformation *)position;

- (void)askForDisplayUpdate:(NSTimer *)theTimer;
- (void)performDisplayUpdate;
- (void)performAddAirplaneToMap:(Airplane *)newAirplane;
- (void)performAddMultipleAirplanesToMap;
- (void)performAirplane:(Airplane *)airplane;

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
    // creates the different zones composing the map
    self.zones = [NSArray arrayWithObject:[[ZoneController alloc] init]];
    
    // creates the collection of airplanes
    self.airplanes = [NSMutableArray array];
    
    ATCAirplaneInformation *airplaneData = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:[[ATCPoint alloc] initWithCoordinateX:250 andCoordinateY:80]];
    airplaneData.course = 270;
    airplaneData.speed = 100;
    airplaneData.destination = @"KORD";
    airplaneData.airplaneName = @"N38394";
    
    [self.airplanes addObject:[self createAirplaneWithInitialInfo:airplaneData]];
    
    [airplaneData release];
    
    // displays the first airplanes on the interface    
    [self performSelectorOnMainThread:@selector(performAddMultipleAirplanesToMap) withObject:nil waitUntilDone:NO];
}

- (ATCZone *)createZoneWithController:(BasicController *)controller isAirportController:(BOOL)airportController {
    ATCZone *zone = [[ATCZone alloc] initWithCorners:nil withControllerName:controller.agentName andIsAirport:airportController];
    
    return [zone autorelease];
}

- (Airplane *)createAirplaneWithInitialInfo:(ATCAirplaneInformation *)position {
    
    Airplane *newAirplane = [[Airplane alloc] initWithInitialData:position];
    
    return [newAirplane autorelease];
}

- (AirportController *)createDestinationWithName:(NSString *)destinationName {
    AirportController *airport = [[AirportController alloc] initWithAgentName:destinationName];
    
    return [airport autorelease];
}

- (void)startSimulation {
    // draws the borders of the zones on the interface
    
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

# pragma mark - Artifacts delegation

- (void)updateInterfaceWithInformationsForZone:(NSArray *)informations {
    
}

- (void)landAirplane:(ATCAirplaneInformation *)airplane {
    
}

- (void)crashAirplane:(ATCAirplaneInformation *)airplane {
    
}

@end
