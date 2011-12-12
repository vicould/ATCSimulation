//
//  ZoneController+Collision.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ZoneController+Collision.h"

@implementation ZoneController (Collision)

- (BOOL)evaluateRiskBetweenAirplane1:(ATCAirplaneInformation *)airplane1 andAirplane2:(ATCAirplaneInformation *)airplane2 {
    ATCPoint *intersection = [self.artifactDelegate calculatePlanesIntersectionWithPlane1Infos:airplane1 andPlane2Infos:airplane2];
    
    if (intersection.X == MAXFLOAT) {
        // no intersection between the two planes, ok
        return NO;
    }
    
    // now that we have the intersection, we measure the risk of collision
    // we want the distance from the airplane to the point greater than 10 miles
    
    // use a polar referential, with the origin being the intersection
    
    // airplanes have probably moved since we got their message
    float r1 = sqrtf(powf(airplane1.coordinates.X - intersection.X, 2) + powf(airplane1.coordinates.Y - intersection.Y, 2)) + [airplane1.informationValidity timeIntervalSinceNow] * airplane1.speed;
    
    float r2 = sqrtf(powf(airplane2.coordinates.X - intersection.X, 2) + powf(airplane2.coordinates.Y - intersection.Y, 2)) + [airplane2.informationValidity timeIntervalSinceNow] * airplane2.speed;
    
    float entryTime1, exitTime1;
    float entryTime2, exitTime2;
    
    entryTime1 = (r1 - 10) / airplane1.speed;
    exitTime1 = (r1 + 10) / airplane1.speed;
    entryTime2 = (r2 - 10) / airplane2.speed;
    exitTime2 = (r2 + 10) / airplane2.speed;
    
    // if it overlaps, there is a risk of collision
    if (entryTime1 <= entryTime2 && entryTime2 <= exitTime1) {
        return YES;
    } else if (entryTime2 <= entryTime1 && entryTime1 <= exitTime2) {
        return YES;
    }
    
    return NO;
}

@end
