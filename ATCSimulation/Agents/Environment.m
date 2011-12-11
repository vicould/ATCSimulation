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
@property (nonatomic, retain) NSMutableDictionary *zoneWhitePages;
@property (nonatomic, assign) int lastID;
@property (nonatomic, retain) NSDictionary *airportsWhitePages;

- (void)createEnvironment;
- (Airplane *)createAirplaneWithInitialInfo:(ATCAirplaneInformation *)position;
- (void)representStartingEnvironment;

- (void)onMainThreadUpdateInterfaceWithInformations:(NSArray *)informations;
- (void)onMainThreadUpdateAirplaneInformation:(ATCAirplaneInformation *)information;
- (void)onMainThreadLandAirplane:(NSString *)airplaneName;
- (void)onMainThreadCrashAirplane:(ATCAirplaneInformation *)airplane;
- (void)onMainThreadRemoveAirplane:(NSString *)airplaneName;

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
@synthesize zoneWhitePages = _zoneWhitePages;
@synthesize lastID = _lastID;
@synthesize airportsWhitePages = _airportsWhitePages;

- (void)createEnvironment {
    self.lastID = 0;
    
    // maps the id of the zone to the name of the controller handling it
    self.zoneWhitePages = [[NSMutableDictionary alloc] initWithCapacity:3];
    self.airportsWhitePages = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    BasicController *controller;
    
    // creates the zone controllers
    self.zoneControllers = [[NSMutableArray alloc] initWithCapacity:2];

    controller = [[ZoneController alloc] initWithID:[self createZoneID]];
    controller.artifactDelegate = self;
    [self.zoneControllers addObject:controller];
    [self.zoneWhitePages setObject:controller.agentName forKey:[NSNumber numberWithInt:controller.zoneID]];
    [controller release];
    
    controller = [[ZoneController alloc] initWithID:[self createZoneID]];
    controller.artifactDelegate = self;
    [self.zoneControllers addObject:controller];
    [self.zoneWhitePages setObject:controller.agentName forKey:[NSNumber numberWithInt:controller.zoneID]];
    [controller release];
    
    // creates the airport controllers
    self.airportControllers = [[NSMutableArray alloc] initWithCapacity:1];
    
    ATCPoint *airportLocation = [[ATCPoint alloc] initWithCoordinateX:135 andCoordinateY:140];
    controller = [[AirportController alloc] initWithAirportName:@"KLAF" location:airportLocation andID:[self createZoneID]];
    controller.artifactDelegate = self;
    [self.airportControllers addObject:controller];
    [self.zoneWhitePages setObject:controller.agentName forKey:[NSNumber numberWithInt:controller.zoneID]];
    [self.airportsWhitePages setValue:airportLocation forKey:@"KLAF"];

    [airportLocation release];
    [controller release];
    
    // creates the different zones composing the map
    
    NSArray *corners1 = [NSArray arrayWithObjects:[[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:187], [[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:187], nil];
    controller = [self.zoneControllers objectAtIndex:0];
    ATCZone *zone1 = [[ATCZone alloc] initWithCorners:corners1 withControllerName:controller.agentName zoneID:controller.zoneID andIsAirport:NO];
    
    NSArray *corners2 = [NSArray arrayWithObjects:[[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:256 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:256 andCoordinateY:187], [[ATCPoint alloc] initWithCoordinateX:192 andCoordinateY:187], [[ATCPoint alloc] initWithCoordinateX:192 andCoordinateY:127], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:127], nil];
    controller = [self.zoneControllers objectAtIndex:1];
    ATCZone *zone2 = [[ATCZone alloc] initWithCorners:corners2 withControllerName:controller.agentName zoneID:controller.zoneID andIsAirport:NO];
    
    NSArray *corners3 = [NSArray arrayWithObjects:[[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:127], [[ATCPoint alloc] initWithCoordinateX:192 andCoordinateY:127], [[ATCPoint alloc] initWithCoordinateX:192 andCoordinateY:187], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:187], nil];
    controller = [self.airportControllers objectAtIndex:0];
    ATCZone *zone3 = [[ATCZone alloc] initWithCorners:corners3 withControllerName:controller.agentName zoneID:controller.zoneID andIsAirport:YES];

    self.zones = [NSMutableArray arrayWithObjects:zone1, zone2, zone3, nil];
    [zone1 release];
    [zone2 release];
    [zone3 release];
    
    // creates the collection of airplanes
    self.airplanes = [NSMutableArray array];
    
    ATCAirplaneInformation *airplaneData1 = [[ATCAirplaneInformation alloc] initWithZone:2 andPoint:[[ATCPoint alloc] initWithCoordinateX:140 andCoordinateY:80]];
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
    self.zoneWhitePages = nil;
    self.airportsWhitePages = nil;
    
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

# pragma mark Position artifacts

- (NSInteger)calculateCurrentZoneFromPoint:(ATCPoint *)location {
    for (ATCZone *zone in self.zones) {
        if ([zone pointBelongsToZone:location]) {
            return zone.zoneID;
        }
    }
    return 0;
}

- (float)distanceFromNextZone:(ATCPoint *)position onRoute:(NSInteger *)route {
    // TODO
    return 0;
}

- (ATCPoint *)calculateNewPositionFromCurrent:(ATCAirplaneInformation *)currentPosition afterInterval:(NSTimeInterval)interval {
    ATCPoint *newPoint = [ATCPoint pointFromExisting:currentPosition.coordinates];
    float distance = interval * TIME_FACTOR * currentPosition.speed / 3600.0;
    
    newPoint.X = currentPosition.coordinates.X + (distance * sinf(currentPosition.course * 2 * M_PI / 360.0));
    newPoint.Y = currentPosition.coordinates.Y - (distance * cosf(currentPosition.course * 2 * M_PI / 360.0));
    
    return newPoint;
}

- (NSString *)controllerNameForZoneID:(int)zoneID {
    NSString *controllerName = [self.zoneWhitePages objectForKey:[NSNumber numberWithInt:zoneID]];
    return controllerName;
}

- (float)calculateAzimutToDestination:(NSString *)destination fromPoint:(ATCPoint *)currentLocation {
    ATCPoint *airportOriginalLocation = [self.airportsWhitePages objectForKey:destination];
    ATCPoint *airportLocation = [ATCPoint pointFromExisting:airportOriginalLocation];
    
    // let's switch to the referential of the airplane
    airportLocation.X = airportLocation.X - currentLocation.X;
    airportLocation.Y = airportLocation.Y - currentLocation.Y;
    
    if (airportLocation.X == 0) {
        return airportLocation.Y >= 0 ? 180 : 0;
    }
    
    float theta = atanf(airportLocation.Y / airportLocation.X);
    
    theta = airportLocation.X < 0 ? theta + M_PI : theta;
    
    // theta is in radians, and corresponds to π/2 + azimut
    return (M_PI_2 + theta) * 180 / M_PI;
}

# pragma mark Zone artifacts

- (int)createZoneID {
    self.lastID++;
    return self.lastID;
}

- (ATCPoint *)calculatePlanesIntersectionWithPlane1Infos:(ATCAirplaneInformation *)plane1 andPlane2Infos:(ATCAirplaneInformation *)plane2 {
    // calculates equations from point and route
    float a1, b1, c1, a2, b2, c2;
    float x, y;
    
    [self lineEquationFromPoint:plane1.coordinates andCourse:plane1.course WithA:&a1 b:&b1 andC:&c1];
    [self lineEquationFromPoint:plane2.coordinates andCourse:plane2.course WithA:&a2 b:&b2 andC:&c2];
    
    // resolves equation
    if (a1 == 0) {
        if (a2 == 0) {
            if (c1 == 0 || c2 == 0) {
                if (b1 == b2 || b1 == - b2) {
                    x = 0;
                    y = 0;
                } else {
                    x = MAXFLOAT;
                    y = MAXFLOAT;
                }
            } else {
                if (b1 / c1 == b2 / c2) {
                    x = plane1.coordinates.X < plane2.coordinates.X ? plane1.coordinates.X + plane1.speed * abs(plane1.coordinates.X - plane2.coordinates.X) / (plane1.speed + plane2.speed) : plane2.coordinates.X + plane2.speed * abs(plane1.coordinates.X - plane2.coordinates.X) / (plane1.speed + plane2.speed);
                    y = c1 / b1;
                } else {
                    x = MAXFLOAT;
                    y = MAXFLOAT;
                }
            }
        } else {
            x = - (c2 - b2 * c1 / b1) / a2;
            y = - c1 / b1;
        }
    } else if (b1 == 0) {
        if (b2 == 0) {
            // parallel paths, no way
            if (c1 == 0 || c2 == 0) {
                if (a1 == a2 || a1 == -a2) {
                    x = 0;
                    y = 0;
                } else {
                    x = MAXFLOAT;
                    y = MAXFLOAT;
                }
            } else {
                if (c1 / a1 == c2 / a2) {
                    x = - c1 / a1;
                    y = plane1.coordinates.Y < plane2.coordinates.Y ? plane1.coordinates.Y + plane1.speed * abs(plane1.coordinates.Y - plane2.coordinates.Y) / (plane1.speed + plane2.speed) : plane2.coordinates.Y + plane2.speed * abs(plane1.coordinates.Y - plane2.coordinates.Y) / (plane1.speed + plane2.speed);
                } else {
                    x = MAXFLOAT;
                    y = MAXFLOAT;
                }
            }
        } else {
            x = - c1 / a1;
            y = - (c2 - a2 * c1 / a1) / b2;
        }
    } else {
        if (a2 == 0) {
            x = - (c1 - b1 * c2 / b2) / a1;
            y = - c2 / b2;
        } else if (b2 == 0) {
            x = - c2 / a2;
            y = - (c1 - a1 * c2 / a2) / b1;
        } else {
            // tests if we have parallel paths
            if (a1 / a2 == b1 / b2) {
                if (c2 == 0) {
                    if (c1 == 0) {
                        x = plane1.coordinates.X < plane2.coordinates.X ? plane1.coordinates.X + plane1.speed * abs(plane1.coordinates.X - plane2.coordinates.X) / (plane1.speed + plane2.speed) : plane2.coordinates.X + plane2.speed * abs(plane1.coordinates.X - plane2.coordinates.X) / (plane1.speed + plane2.speed);
                        y = (- a1 * x - c1) / b1;
                    } else {
                        x = MAXFLOAT;
                        y = MAXFLOAT;
                    }
                } else if (c1 / c2 == a1 / a2) {
                    // same equation, same line
                    x = plane1.coordinates.X < plane2.coordinates.X ? plane1.coordinates.X + plane1.speed * abs(plane1.coordinates.X - plane2.coordinates.X) / (plane1.speed + plane2.speed) : plane2.coordinates.X + plane2.speed * abs(plane1.coordinates.X - plane2.coordinates.X) / (plane1.speed + plane2.speed);
                    y = (- a1 * x - c1) / b1;
                } else {
                    // colinear vectors
                    x = MAXFLOAT;
                    y = MAXFLOAT;
                }
            } else {
                x = - (c1 + (a2 * c1 - c2 * a1) / (a1 * b2 - a2 * b1)) / a1;
                y = (a2 * c1 - c2 * a1) / (a1 * b2 - a2 * b1);
            }
        }
    }
    
    return [[[ATCPoint alloc] initWithCoordinateX:x andCoordinateY:y] autorelease];
}

- (void)lineEquationFromPoint:(ATCPoint *)initialPoint andCourse:(float)course WithA:(float *)a b:(float *)b andC:(float *)c {
    
    // simplifies coefficients in case of particular angle values
    if (course == 0) {
        *a = -4;
        *b = 0;
    } else if (course == 45) {
        *a = -4;
        *b = -4;
    } else if (course == 90) {
        *a = 0;
        *b = -4;
    } else if (course == 135) {
        *a = 4;
        *b = -4;
    } else if (course == 180) {
        *a = 4;
        *b = 0;
    } else if (course == 225) {
        *a = 4;
        *b = 4;
    } else if (course == 270) {
        *a = 0;
        *b = 4;
    } else if (course == 315) {
        *a = -4;
        *b = 4;
    } else {
        // gets the equation in the referential of the airplane
        float theta = 3 * M_PI_2 + course * M_PI / 180;
        
        *a = - 4 * cosf(theta); // why 4? why not?
        *b = 4 * sinf(theta);
    }
    
    *c = - *b * initialPoint.Y - *a * initialPoint.X;
}

# pragma mark Airplanes display artifacts

- (void)updateAirplaneInformation:(ATCAirplaneInformation *)information {
    [self performSelectorOnMainThread:@selector(onMainThreadUpdateAirplaneInformation:) withObject:information waitUntilDone:NO];
}

- (void)landAirplane:(ATCAirplaneInformation *)airplane {
    [self performSelectorOnMainThread:@selector(onMainThreadLandAirplane:) withObject:airplane waitUntilDone:NO];
}

- (void)crashAirplane:(ATCAirplaneInformation *)airplane {
    [self performSelectorOnMainThread:@selector(onMainThreadCrashAirplane:) withObject:airplane waitUntilDone:NO];
}

- (void)removeAirplane:(NSString *)airplaneName {
    [self performSelectorOnMainThread:@selector(onMainThreadRemoveAirplane:) withObject:airplaneName waitUntilDone:NO];
}

# pragma mark Controllers display artifacts

- (void)updateInterfaceWithInformations:(NSArray *)informations {
    [self performSelectorOnMainThread:@selector(onMainThreadUpdateInterfaceWithInformations:) withObject:informations waitUntilDone:NO];
}

# pragma mark Corresponding methods for the delegation of the interface on the main thread

- (void)onMainThreadUpdateInterfaceWithInformations:(NSArray *)informations {
    [self.displayDelegate updateDetectedAirplanes:informations];
}

- (void)onMainThreadUpdateAirplaneInformation:(ATCAirplaneInformation *)information {
    [self.displayDelegate updateAirplanePositionWithInfo:information];
}

- (void)onMainThreadLandAirplane:(NSString *)airplaneName {
    [self.displayDelegate landAirplane:airplaneName];
}

- (void)onMainThreadCrashAirplane:(ATCAirplaneInformation *)airplane {
    [self.displayDelegate crashAirplane:airplane];
}

- (void)onMainThreadRemoveAirplane:(NSString *)airplaneName {
    [self.displayDelegate removeAirplaneFromView:airplaneName];
}

@end
