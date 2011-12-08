//
//  ATCZoneBorderSegmentTest.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/7/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCZoneBorderSegmentTest.h"

@implementation ATCZoneBorderSegmentTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    ATCPoint *point1 = [[ATCPoint alloc] initWithCoordinateX:10 andCoordinateY:5];
    ATCPoint *point2 = [[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:30];
    
    segment1 = [[ATCZoneBorderSegment alloc] initWithExtremity1:point2 andExtremity2:point1 withDirectionPositive:YES];
    segment2 = [[ATCZoneBorderSegment alloc] initWithExtremity1:point1 andExtremity2:point2 withDirectionPositive:NO];
    
    [point1 release];
    [point2 release];
    
    point1 = [[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:30];
    point2 = [[ATCPoint alloc] initWithCoordinateX:40 andCoordinateY:5];
    
    segment3 = [[ATCZoneBorderSegment alloc] initWithExtremity1:point2 andExtremity2:point1 withDirectionPositive:YES];
    segment4 = [[ATCZoneBorderSegment alloc] initWithExtremity1:point1 andExtremity2:point2 withDirectionPositive:NO];
    
    [point1 release];
    [point2 release];
    
    point1 = [[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:30];
    point2 = [[ATCPoint alloc] initWithCoordinateX:40 andCoordinateY:30];
    
    segment5 = [[ATCZoneBorderSegment alloc] initWithExtremity1:point2 andExtremity2:point1 withDirectionPositive:YES];
    segment6 = [[ATCZoneBorderSegment alloc] initWithExtremity1:point1 andExtremity2:point2 withDirectionPositive:NO];
    
    [point1 release];
    [point2 release];
    
    point1 = [[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:0];
    point2 = [[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:30];
    
    segment7 = [[ATCZoneBorderSegment alloc] initWithExtremity1:point2 andExtremity2:point1 withDirectionPositive:YES];
    segment8 = [[ATCZoneBorderSegment alloc] initWithExtremity1:point1 andExtremity2:point2 withDirectionPositive:NO];

    [point1 release];
    [point2 release];
}

- (void)tearDown
{
    // Tear-down code here.
    [segment1 release];
    [segment2 release];
    [segment3 release];
    [segment4 release];
    
    [super tearDown];
}

// All code under test must be linked into the Unit Test bundle

- (void)testGeneratedCoefficients {
    STAssertEquals(segment1.a, -25.0f, @"Wrong a? %f", segment1.a);
    STAssertEquals(segment1.b, 10.0f, @"Wrong b?%f", segment1.b);
    STAssertEquals(segment1.c, 200.0f, @"Wrong c?%f", segment1.c);
    
    STAssertEquals(segment1.orthA, 10.0f, @"Wrong a? %f", segment1.orthA);
    STAssertEquals(segment1.orthB, 25.0f, @"Wrong b?%f", segment1.orthB);
    STAssertEquals(segment1.orth1C, -950.0f, @"Wrong c?%f", segment1.orth1C);
    
    STAssertEquals(segment1.orthA, 10.0f, @"Wrong a? %f", segment1.orthA);
    STAssertEquals(segment1.orthB, 25.0f, @"Wrong b?%f", segment1.orthB);
    STAssertEquals(segment1.orth2C, -225.0f, @"Wrong c?%f", segment1.orth2C);
}

- (void)testSpaceBelonging1 {
    STAssertTrue([segment1 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:25]], @"Point 15, 25 should belong to segment half-space");
}

- (void)testSpaceNotBelonging1 {
    STAssertFalse([segment1 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:10]], @"Point 15, 10 should not belong to segment half-space");
}

- (void)testSpaceBelonging2 {
    STAssertTrue([segment2 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:10]], @"Point 15, 10 should belong to the half space");
}

- (void)testSpaceNotBelonging2 {
    STAssertFalse([segment2 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:25]], @"Point 15, 25 should not belong to segment half-space");
}

- (void)testSpaceBelonging3 {
    STAssertTrue([segment3 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:35 andCoordinateY:20]], @"Point 35, 20 should belong to segment half-space");
}

- (void)testSpaceNotBelonging3 {
    STAssertFalse([segment3 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:30 andCoordinateY:10]], @"Point 30, 10 should not belong to segment half-space");
}

- (void)testSpaceBelonging4 {
    STAssertTrue([segment4 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:30 andCoordinateY:10]], @"Point 30, 10 should belong to the half space");
}

- (void)testSpaceNotBelonging4 {
    STAssertFalse([segment4 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:35 andCoordinateY:20]], @"Point 35, 20 should not belong to segment half-space");
}

- (void)testSpaceBelonging5 {
    STAssertTrue([segment5 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:35]], @"Point 20, 35 should belong to the half space");
}

- (void)testSpaceBelonging6 {
    STAssertTrue([segment6 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:20]], @"Point 20, 20 should belong to the half space");
}

- (void)testSpaceBelonging7 {
    STAssertTrue([segment7 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:30 andCoordinateY:15]], @"Point 30, 15 should belong to the half space");
}

- (void)testSpaceBelonging8 {
    STAssertTrue([segment8 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:10 andCoordinateY:15]], @"Point 10, 15 should belong to the half space");
}

- (void)testIntersectionPoint1 {
    ATCPoint *intersect = [segment1 calculateLinesIntersectionWithPoint:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:10]];
    STAssertEquals(intersect.X, 360/29.0f, @"");
    STAssertEquals(intersect.Y, 16 - 144/29.0f, @"");
}

@end
