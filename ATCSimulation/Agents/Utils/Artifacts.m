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
    float distance = interval * currentPosition.speed / 3600;
    
    newPoint.coordinateX = [NSNumber numberWithFloat:(distance * cos(currentPosition.course * 2 * M_PI / 360.0))];
    newPoint.coordinateY = [NSNumber numberWithFloat:(distance * sin(currentPosition.course * 2 * M_PI / 360.0))];
    
    return newPoint;
}

@end
