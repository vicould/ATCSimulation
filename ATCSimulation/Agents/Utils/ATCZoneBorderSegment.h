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

@interface ATCZoneBorderSegment : NSObject {
    @private
    ATCPoint *_extremity1;
    ATCPoint *_extremity2;
    
    // ax + by + c = 0
    float _aLine;
    float _bLine;
    float _cLine;
    
    float _aOrthogonalLine1;
    float _bOrthogonalLine1;
    float _cOrthogonalLine1;
    
    float _aOrthogonalLine2;
    float _bOrthogonalLine2;
    float _cOrthogonalLine2;
    BOOL _directionPositive;
}

- (id)initWithExtremity1:(ATCPoint *)extremity1 andExtremity2:(ATCPoint *)extremity2 withDirectionPositive:(BOOL)positive;

@property (nonatomic, readonly, retain) ATCPoint *extremity1;
@property (nonatomic, readonly, retain) ATCPoint *extremity2;
@property (nonatomic, readonly, assign) float aLine;
@property (nonatomic, readonly, assign) float bLine;
@property (nonatomic, readonly, assign) float cLine;
@property (nonatomic, readonly, assign) BOOL directionPositive;

- (BOOL)pointBelongsToGeneratedHalfSpace:(ATCPoint *)testedPoint;
- (float )calculateDistanceToSegment:(ATCAirplaneInformation *)testedPosition;

@end
