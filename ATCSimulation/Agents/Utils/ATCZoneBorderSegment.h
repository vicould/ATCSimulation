//
//  ATCZoneBorder.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCPoint.h"
#import "ATCAirplaneInformation.h"

@class ATCPoint;
@class ATCAirplaneInformation;

/**
 * A class to represent one element of the border, containing methods to perform atomic operations on this segment.
 * It contains properties to obtain the representation of the line, with the equation ay + bx + c = 0.
 */
@interface ATCZoneBorderSegment : NSObject {
    @private
    ATCPoint *_extremity1;
    ATCPoint *_extremity2;
    
    // ax + by + c = 0
    float _a;
    float _b;
    float _c;
    
    float _orthA;
    float _orthB;
    float _orth1C;
    float _orth2C;
    
    BOOL _directionPositive;
}

/**
 * Creates one segment, from extremity1 to extremity2.
 * @param extremity1 The first extremity of the segment.
 * @param extremity2 The second extremity of the segment.
 * @param positive A boolean telling if the zone is above or under this segment, useful to determine
 * the direction of the half-space.
 */
- (id)initWithExtremity1:(ATCPoint *)extremity1 andExtremity2:(ATCPoint *)extremity2 withDirectionPositive:(BOOL)positive;

@property (nonatomic, readonly, retain) ATCPoint *extremity1;
@property (nonatomic, readonly, retain) ATCPoint *extremity2;
@property (nonatomic, readonly, assign) float a;
@property (nonatomic, readonly, assign) float b;
@property (nonatomic, readonly, assign) float c;
@property (nonatomic, readonly, assign) BOOL directionPositive;
@property (nonatomic, readonly, assign) float orthA;
@property (nonatomic, readonly, assign) float orthB;
@property (nonatomic, readonly, assign) float orth1C;
@property (nonatomic, readonly, assign) float orth2C;

/**
 * Tests if the point belongs to the half-space generated by the inequation, with the coefficients expressed in the other properties.
 * @param testedPoint The point to test.
 * @return Returns YES if the point is inside the half-space.
 */
- (BOOL)pointBelongsToGeneratedHalfSpace:(ATCPoint *)testedPoint;

/**
 * Calculates the distance from the location of the airplane to the current segment, distance which can be infinite if the 
 * airplane never meets the segment on its current course.
 * @param testedPosition The information about the aircraft to test.
 * @return Returns the distance to the current segment, if the airplane continued to fly straight on its course.
 */
- (float)calculateDistanceToSegment:(ATCAirplaneInformation *)testedPosition;

@end
