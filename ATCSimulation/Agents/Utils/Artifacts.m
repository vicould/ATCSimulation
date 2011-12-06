//
//  Artifacts.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Artifacts.h"

@implementation Artifacts

+ (NSInteger)calculateCurrentZonefromPoint:(ATCPoint *)location{
    return 0;
}

+ (float)distanceFromNextZone:(ATCPoint *)position onRoute:(NSInteger *)route {
    
    return 0;
}

+ (ATCPoint *)calculateNewPositionFromCurrent:(ATCAirplaneInformation *)currentPosition afterInterval:(NSTimeInterval)interval {    
    ATCPoint *newPoint = [ATCPoint pointFromExisting:currentPosition.coordinates];
    float distance = interval * 10 * currentPosition.speed / 3600.0;
    
    newPoint.X = currentPosition.coordinates.X + (distance * sinf(currentPosition.course * 2 * M_PI / 360.0));
    newPoint.Y = currentPosition.coordinates.Y - (distance * cosf(currentPosition.course * 2 * M_PI / 360.0));
    
    return newPoint;
}

@end
