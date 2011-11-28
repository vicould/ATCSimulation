//
//  ATCZoneBorder.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCZoneBorderSegment.h"

@interface ATCZoneBorderSegment ()

@property (nonatomic, retain) ATCPoint *extremity1;
@property (nonatomic, retain) ATCPoint *extremity2;
@property (nonatomic, retain) NSNumber *slope;
@property (nonatomic, retain) NSNumber *yIntersect;
@property (nonatomic, assign) BOOL directionPositive;

@end

@implementation ATCZoneBorderSegment

- (id)initWithExtremity1:(ATCPoint *)extremity1 andExtremity2:(ATCPoint *)extremity2 withDirectionPositive:(BOOL)positive {
    self = [super init];
    
    if (self) {
        self.directionPositive = positive;
        
        self.extremity1 = extremity1;
        self.extremity2 = extremity2;
        
        self.slope = [NSNumber numberWithFloat:(([extremity2.coordinateY floatValue] - [extremity1.coordinateY floatValue]) / ([extremity2.coordinateX floatValue] - [extremity1.coordinateX floatValue]))];
        self.yIntersect = [NSNumber numberWithFloat:([extremity1.coordinateY floatValue] - ([extremity2.coordinateY floatValue] - [extremity1.coordinateY floatValue]) / ([extremity2.coordinateX floatValue] - [extremity1.coordinateX floatValue]) * [extremity1.coordinateX floatValue])];
    }
    
    return self;
}

@synthesize extremity1 = _extremity1;
@synthesize extremity2 = _extremity2;
@synthesize slope = _slope;
@synthesize yIntersect = _yIntersect;
@synthesize directionPositive = _directionPositive;

- (BOOL)pointBelongsToGeneratedSpace:(ATCPoint *)testedPoint {
    NSNumber *inequationResult = [NSNumber numberWithFloat:[testedPoint.coordinateY floatValue] - [self.slope floatValue] * [testedPoint.coordinateX floatValue] - [self.yIntersect floatValue] ];
    
    if (self.directionPositive) {
        return inequationResult >= 0;
    } else {
        return inequationResult <= 0;
    }
}

- (void)dealloc {
    self.extremity1 = nil;
    self.extremity2 = nil;
    self.slope = nil;
    self.yIntersect = nil;
    
    [super dealloc];
}

@end
