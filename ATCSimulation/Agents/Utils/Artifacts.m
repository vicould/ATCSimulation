//
//  Artifacts.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Artifacts.h"

@implementation Artifacts

+ (NSInteger)calculateCurrentZonefromX:(NSNumber *)currentX andY:(NSNumber *)currentY {
    return 0;
}

+ (NSNumber *)distanceFromNextZone:(ATCAirplaneInformation *)position onRoute:(NSInteger *)route {
    
    return 0;
}

+ (ATCPoint *)calculateNewPositionFromCurrent:(ATCAirplaneInformation *)currentPosition afterInterval:(NSTimeInterval)interval {

    
    ATCPoint *newPoint = [ATCPoint pointFromExisting:currentPosition.coordinates];
    float distance = interval * 10 * currentPosition.speed / 3600.0;
    
    newPoint.coordinateX = currentPosition.coordinates.coordinateX + (distance * sinf(currentPosition.course * 2 * M_PI / 360.0));
    newPoint.coordinateY = currentPosition.coordinates.coordinateY - (distance * cosf(currentPosition.course * 2 * M_PI / 360.0));
    
    return newPoint;
}

@end
