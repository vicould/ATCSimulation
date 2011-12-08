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
    segment1 = [[ATCZoneBorderSegment alloc] initWithExtremity1:[[ATCPoint alloc] initWithCoordinateX:10 andCoordinateY:5] andExtremity2:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:30] withDirectionPositive:YES];
    
    segment2 = [[ATCZoneBorderSegment alloc] initWithExtremity1:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:30] andExtremity2:[[ATCPoint alloc] initWithCoordinateX:40 andCoordinateY:5] withDirectionPositive:YES];
    
    segment3 = [[ATCZoneBorderSegment alloc] initWithExtremity1:[[ATCPoint alloc] initWithCoordinateX:10 andCoordinateY:5] andExtremity2:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:30] withDirectionPositive:NO];
    
    segment4 = [[ATCZoneBorderSegment alloc] initWithExtremity1:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:30] andExtremity2:[[ATCPoint alloc] initWithCoordinateX:40 andCoordinateY:5] withDirectionPositive:NO];
    
    segment5 = [[ATCZoneBorderSegment alloc] initWithExtremity1:[[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:30] andExtremity2:[[ATCPoint alloc] initWithCoordinateX:40 andCoordinateY:30] withDirectionPositive:NO];
    
    segment6 = [[ATCZoneBorderSegment alloc] initWithExtremity1:[[ATCPoint alloc] initWithCoordinateX:0 andCoordinateY:30] andExtremity2:[[ATCPoint alloc] initWithCoordinateX:40 andCoordinateY:30] withDirectionPositive:YES];
    
    segment7 = [[ATCZoneBorderSegment alloc] initWithExtremity1:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:0] andExtremity2:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:30] withDirectionPositive:NO];
    
    segment8 = [[ATCZoneBorderSegment alloc] initWithExtremity1:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:0] andExtremity2:[[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:30] withDirectionPositive:YES];

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
    STAssertEquals(segment1.aLine, 25.0f, @"Wrong a? %f", segment1.aLine);
    STAssertEquals(segment1.bLine, -10.0f, @"Wrong b?%f", segment1.bLine);
    STAssertEquals(segment1.cLine, -200.0f, @"Wrong c?%f", segment1.cLine);
    
    STAssertEquals(segment1.aOrthogonalLine1, -10.0f, @"Wrong a? %f", segment1.aOrthogonalLine1);
    STAssertEquals(segment1.bOrthogonalLine1, -25.0f, @"Wrong b?%f", segment1.bOrthogonalLine1);
    STAssertEquals(segment1.cOrthogonalLine1, 225.0f, @"Wrong c?%f", segment1.cOrthogonalLine1);
    
    STAssertEquals(segment1.aOrthogonalLine2, -10.0f, @"Wrong a? %f", segment1.aOrthogonalLine2);
    STAssertEquals(segment1.bOrthogonalLine2, -25.0f, @"Wrong b?%f", segment1.bOrthogonalLine2);
    STAssertEquals(segment1.cOrthogonalLine2, 950.0f, @"Wrong c?%f", segment1.cOrthogonalLine2);
}

- (void)testSpaceBelonging1 {
    STAssertTrue([segment1 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:40]], @"Point 15, 40 should belong to segment half-space");
}

- (void)testSpaceNotBelonging1 {
    STAssertFalse([segment1 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:5]], @"Point 15, 5 should not belong to segment half-space");
}

- (void)testSpaceBelonging2 {
    STAssertTrue([segment2 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:30 andCoordinateY:40]], @"Point 30, 40 should belong to the half space");
}

- (void)testSpaceNotBelonging2 {
    STAssertFalse([segment2 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:5]], @"Point 15, 5 should not belong to segment half-space");
}

- (void)testSpaceBelonging3 {
    STAssertTrue([segment3 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:5]], @"Point 15, 5 should belong to segment half-space");
}

- (void)testSpaceNotBelonging3 {
    STAssertFalse([segment3 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:40]], @"Point 15, 40 should not belong to segment half-space");
}

- (void)testSpaceBelonging4 {
    STAssertTrue([segment4 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:5]], @"Point 15, 5 should belong to the half space");
}

- (void)testSpaceNotBelonging4 {
    STAssertFalse([segment4 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:30 andCoordinateY:40]], @"Point 30, 40 should not belong to segment half-space");
}

- (void)testSpaceBelonging5 {
    STAssertTrue([segment5 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:5]], @"Point 15, 5 should belong to the half space");
}

- (void)testSpaceBelonging6 {
    STAssertTrue([segment6 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:35]], @"Point 15, 5 should belong to the half space");
}

- (void)testSpaceBelonging7 {
    STAssertTrue([segment7 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:15 andCoordinateY:5]], @"Point 15, 5 should belong to the half space");
}

- (void)testSpaceBelonging8 {
    STAssertTrue([segment8 pointBelongsToGeneratedHalfSpace:[[ATCPoint alloc] initWithCoordinateX:25 andCoordinateY:5]], @"Point 15, 5 should belong to the half space");
}

@end
