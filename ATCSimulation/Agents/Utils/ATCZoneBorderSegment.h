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
    NSNumber *_aLine;
    NSNumber *_bLine;
    NSNumber *_cLine;
    
    NSNumber *_aOrthogonalLine1;
    NSNumber *_bOrthogonalLine1;
    NSNumber *_cOrthogonalLine1;
    
    NSNumber *_aOrthogonalLine2;
    NSNumber *_bOrthogonalLine2;
    NSNumber *_cOrthogonalLine2;
    BOOL _directionPositive;
}

- (id)initWithExtremity1:(ATCPoint *)extremity1 andExtremity2:(ATCPoint *)extremity2 withDirectionPositive:(BOOL)positive;

@property (nonatomic, readonly, retain) ATCPoint *extremity1;
@property (nonatomic, readonly, retain) ATCPoint *extremity2;
@property (nonatomic, readonly, retain) NSNumber *aLine;
@property (nonatomic, readonly, retain) NSNumber *bLine;
@property (nonatomic, readonly, retain) NSNumber *cLine;
@property (nonatomic, readonly, assign) BOOL directionPositive;

- (BOOL)pointBelongsToGeneratedHalfSpace:(ATCPoint *)testedPoint;
- (NSNumber *)calculateDistanceToSegment:(ATCAirplaneInformation *)testedPosition;

@end
