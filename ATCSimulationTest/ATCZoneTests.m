//
//  ATCZoneTests.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCZoneTests.h"

@implementation ATCZoneTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    NSArray *corners1 = [NSArray arrayWithObjects:[[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:0], [[ATCPoint alloc] initWithCoordinateX:128 andCoordinateY:187], [[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:187], nil];
    zone1 = [[ATCZone alloc] initWithCorners:corners1 withControllerName:@"zobi" zoneID:1 andIsAirport:NO];
}

- (void)tearDown
{
    // Tear-down code here.
    [zone1 release];
    
    [super tearDown];
}

// All code under test must be linked into the Unit Test bundle
- (void)testBelongsToZone {
    STAssertTrue([zone1 pointBelongsToZone:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:40]], @"Point 20, 40 should be in the zone");
}

- (void)testDoesNotBelongsToZone {
    STAssertFalse([zone1 pointBelongsToZone:[[ATCPoint alloc] initWithCoordinateX:200 andCoordinateY:40]], @"Point 200, 40 should not be in the zone");
}

@end
