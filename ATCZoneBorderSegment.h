//
//  ATCZoneBorder.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCPoint.h"

@class ATCPoint;

@interface ATCZoneBorderSegment : NSObject {
    @private
    ATCPoint *_extremity1;
    ATCPoint *_extremity2;
    NSNumber *_slope;
    NSNumber *_yIntersect;
    BOOL _directionPositive;
}

- (id)initWithExtremity1:(ATCPoint *)extremity1 andExtremity2:(ATCPoint *)extremity2 withDirectionPositive:(BOOL)positive;

@property (nonatomic, readonly, retain) ATCPoint *extremity1;
@property (nonatomic, readonly, retain) ATCPoint *extremity2;
@property (nonatomic, readonly, retain) NSNumber *slope;
@property (nonatomic, readonly, retain) NSNumber *yIntersect;
@property (nonatomic, readonly, assign) BOOL directionPositive;

- (BOOL)pointBelongsToGeneratedSpace:(ATCPoint *)testedPoint;

@end
