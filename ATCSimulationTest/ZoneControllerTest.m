//
//  ZoneControllerTests.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ZoneControllerTest.h"

@implementation ZoneControllerTest

- (void)setUp
{
    [super setUp];

    // Set-up code here.
    environment = [[Environment alloc] initWithDisplayDelegate:nil];
    controller1 = [[ZoneController alloc] initWithID:1];
    controller1.artifactDelegate = environment;
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testEvaluateRisk1 {
    ATCPoint *coordinates1 = [[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:20];
    ATCAirplaneInformation *airplane1 = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:coordinates1];
    airplane1.course = 180;
    airplane1.speed = 100;
    airplane1.informationValidity = [NSDate date];
    [coordinates1 release];
    
    ATCPoint *coordinates2 = [[ATCPoint alloc] initWithCoordinateX:40 andCoordinateY:40];
    ATCAirplaneInformation *airplane2 = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:coordinates2];
    airplane2.course = 270;
    airplane2.speed = 100;
    airplane2.informationValidity = [NSDate date];
    [coordinates2 release];
    
    STAssertTrue([controller1 evaluateRiskBetweenAirplane1:airplane1 andAirplane2:airplane2], @"Not colliding?");
    
    [airplane1 release];
    [airplane2 release];
}

- (void)testEvaluateRisk2 {
    ATCPoint *coordinates1 = [[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:20];
    ATCAirplaneInformation *airplane1 = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:coordinates1];
    airplane1.course = 180;
    airplane1.speed = 100;
    airplane1.informationValidity = [NSDate date];
    [coordinates1 release];
    
    ATCPoint *coordinates2 = [[ATCPoint alloc] initWithCoordinateX:40 andCoordinateY:40];
    ATCAirplaneInformation *airplane2 = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:coordinates2];
    airplane2.course = 0;
    airplane2.speed = 100;
    airplane2.informationValidity = [NSDate date];
    [coordinates2 release];
    
    STAssertFalse([controller1 evaluateRiskBetweenAirplane1:airplane1 andAirplane2:airplane2], @"Colliding?");
    
    [airplane1 release];
    [airplane2 release];
}

- (void)testEvaluateRisk3 {
    ATCPoint *coordinates1 = [[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:20];
    ATCAirplaneInformation *airplane1 = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:coordinates1];
    airplane1.course = 90;
    airplane1.speed = 100;
    airplane1.informationValidity = [NSDate date];
    [coordinates1 release];
    
    ATCPoint *coordinates2 = [[ATCPoint alloc] initWithCoordinateX:40 andCoordinateY:20];
    ATCAirplaneInformation *airplane2 = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:coordinates2];
    airplane2.course = 270;
    airplane2.speed = 100;
    airplane2.informationValidity = [NSDate date];
    [coordinates2 release];
    
    STAssertTrue([controller1 evaluateRiskBetweenAirplane1:airplane1 andAirplane2:airplane2], @"Not colliding?");
    
    [airplane1 release];
    [airplane2 release];
}

- (void)testEvaluateRisk4 {
    ATCPoint *coordinates1 = [[ATCPoint alloc] initWithCoordinateX:60 andCoordinateY:60];
    ATCAirplaneInformation *airplane1 = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:coordinates1];
    airplane1.course = 315;
    airplane1.speed = 100;
    airplane1.informationValidity = [NSDate date];
    [coordinates1 release];
    
    ATCPoint *coordinates2 = [[ATCPoint alloc] initWithCoordinateX:20 andCoordinateY:20];
    ATCAirplaneInformation *airplane2 = [[ATCAirplaneInformation alloc] initWithZone:1 andPoint:coordinates2];
    airplane2.course = 135;
    airplane2.speed = 100;
    airplane2.informationValidity = [NSDate date];
    [coordinates2 release];
    
    STAssertTrue([controller1 evaluateRiskBetweenAirplane1:airplane1 andAirplane2:airplane2], @"Not colliding?");
    
    [airplane1 release];
    [airplane2 release];
}

@end
