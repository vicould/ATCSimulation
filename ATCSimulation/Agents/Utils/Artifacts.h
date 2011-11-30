//
//  Artifacts.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCPosition.h"

@class ATCPosition;

@interface Artifacts : NSObject

+ (NSInteger)calculateCurrentZonefromX:(NSNumber *)currentX andY:(NSNumber *)currentY;

+ (NSNumber *)distanceFromNextZone:(ATCPosition *)position onRoute:(NSInteger *)route;

+ (ATCPoint *)calculateNewPositionFromCurrent:(ATCPosition *)currentPosition afterInterval:(NSTimeInterval)interval;

@end
