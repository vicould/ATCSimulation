//
//  ArtifactsTest.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCArtifactsTest.h"

@implementation ATCArtifactsTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    environment = [[Environment alloc] initWithDisplayDelegate:nil];
}

- (void)tearDown
{
    // Tear-down code here.
    [environment release];
    
    [super tearDown];
}

- (void)testCalculateCurrentZone {
    STAssertEquals([environment calculateCurrentZoneFromPoint:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:20]], 1, @"Point is not in zone 1?");
    STAssertEquals([environment calculateCurrentZoneFromPoint:[[ATCPoint alloc] initWithCoordinateX:130 andCoordinateY:100]], 2, @"Point is not in zone 2?");
    STAssertEquals([environment calculateCurrentZoneFromPoint:[[ATCPoint alloc] initWithCoordinateX:130 andCoordinateY:160]], 3, @"Point is not in zone 3?");
}

- (void)testAzimut {
    STAssertEquals([environment calculateAzimutToDestination:@"KLAF" fromPoint:[[ATCPoint alloc] initWithCoordinateX:135 andCoordinateY:240]], 0.0f, @"Not going north?");
    STAssertEquals([environment calculateAzimutToDestination:@"KLAF" fromPoint:[[ATCPoint alloc] initWithCoordinateX:35 andCoordinateY:240]], 45.0f, @"Not going NW?");
    STAssertEquals([environment calculateAzimutToDestination:@"KLAF" fromPoint:[[ATCPoint alloc] initWithCoordinateX:35 andCoordinateY:140]], 90.0f, @"Not going east?");
    STAssertEquals([environment calculateAzimutToDestination:@"KLAF" fromPoint:[[ATCPoint alloc] initWithCoordinateX:35 andCoordinateY:40]], 135.0f, @"Not going SW?");
    STAssertEquals([environment calculateAzimutToDestination:@"KLAF" fromPoint:[[ATCPoint alloc] initWithCoordinateX:135 andCoordinateY:40]], 180.0f, @"Not going south?");
    STAssertEquals([environment calculateAzimutToDestination:@"KLAF" fromPoint:[[ATCPoint alloc] initWithCoordinateX:235 andCoordinateY:40]], 225.0f, @"Not going SE?");
    STAssertEquals([environment calculateAzimutToDestination:@"KLAF" fromPoint:[[ATCPoint alloc] initWithCoordinateX:235 andCoordinateY:140]], 270.0f, @"Not going west?");
    STAssertEquals([environment calculateAzimutToDestination:@"KLAF" fromPoint:[[ATCPoint alloc] initWithCoordinateX:235 andCoordinateY:240]], 315.0f, @"Not going NW?");
}

@end
