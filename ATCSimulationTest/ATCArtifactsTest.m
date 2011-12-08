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

- (void)testCalculateCurrentZone1 {
    STAssertEquals([environment calculateCurrentZoneFromPoint:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:20]], 1, @"Point is not in zone 1?");
}

- (void)testCalculateCurrentZone2 {
    STAssertEquals([environment calculateCurrentZoneFromPoint:[[ATCPoint alloc] initWithCoordinateX:130 andCoordinateY:100]], 2, @"Point is not in zone 2?");
}

- (void)testCalculateCurrentZone3 {
    STAssertEquals([environment calculateCurrentZoneFromPoint:[[ATCPoint alloc] initWithCoordinateX:130 andCoordinateY:160]], 3, @"Point is not in zone 3?");
}


@end
