//
//  Artifacts.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCAirplaneInformation.h"

@class ATCAirplaneInformation;

@interface Artifacts : NSObject

+ (NSInteger)calculateCurrentZonefromX:(NSNumber *)currentX andY:(NSNumber *)currentY;

+ (NSNumber *)distanceFromNextZone:(ATCAirplaneInformation *)position onRoute:(NSInteger *)route;

+ (ATCPoint *)calculateNewPositionFromCurrent:(ATCAirplaneInformation *)currentPosition afterInterval:(NSTimeInterval)interval;

@end
