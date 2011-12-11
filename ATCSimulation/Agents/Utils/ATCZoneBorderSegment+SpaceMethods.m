//
//  ATCZoneBorderSegment+SpaceMethods.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCZoneBorderSegment+SpaceMethods.h"

@implementation ATCZoneBorderSegment (SpaceMethods)

- (BOOL)checkIfProjectionIsInsideSegmentWithPoint:(ATCPoint *)testedPoint {
    ATCPoint *intersectionPoint = [self calculateLinesIntersectionWithPoint:testedPoint];
    float deltaSegmentX = self.extremity2.X - self.extremity1.X;
    float deltaX = self.extremity2.X - intersectionPoint.X;
    
    if (!(deltaSegmentX >= 0 && deltaX >= 0) && !(deltaSegmentX <= 0 && deltaX <= 0)) {
        // if the two vectors are not in the same direction
        return FALSE;
    }
    
    float deltaSegmentY = self.extremity2.Y - self.extremity1.Y;
    float deltaY = self.extremity2.Y - intersectionPoint.Y;
    
    if (!(deltaSegmentY >= 0 && deltaY >= 0) && !(deltaSegmentY <= 0 && deltaY <= 0)) {
        // if the two vectors are not in the same direction
        return FALSE;
    }
    
    deltaSegmentX = deltaSegmentX > 0 ? deltaSegmentX : - deltaSegmentX;
    deltaX = deltaX >= 0 ? deltaX : - deltaX;
    
    deltaSegmentY = deltaSegmentY > 0 ? deltaSegmentY : - deltaSegmentY;
    deltaY = deltaY >= 0 ? deltaY : - deltaY;
    
    return deltaX <= deltaSegmentX && deltaY <= deltaSegmentY;
}

- (ATCPoint *)calculateLinesIntersectionWithPoint:(ATCPoint *)testedPoint {
    // finishes the calculation of the line orthogonal to the segment and going through testedPoint
    float cOrthogonalLine = - self.orthB * testedPoint.Y - self.orthA * testedPoint.X;
    
    float x, y;
    
    // calculates the point of intersection between the line and the segment
    if (self.a == 0) {
        x = - cOrthogonalLine / self.b;
        y = - self.c / self.b;
    } else if (self.b == 0) {
        x = - self.c / self.a;
        y = cOrthogonalLine / self.a;
    } else {
        x = (- self.a * self.c - self.b * cOrthogonalLine) / ((self.a * self.a + self.b * self.b));
        y = (self.a * (self.a * self.c + self.b * cOrthogonalLine) - self.c * (self.b * self.b + self.a * self.a)) / ((self.b * self.b + self.a * self.a) * self.b);
    }
    
    return [[[ATCPoint alloc] initWithCoordinateX:x andCoordinateY:y] autorelease];
}

@end
