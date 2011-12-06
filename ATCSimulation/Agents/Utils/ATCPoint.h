//
//  Point.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * A class containing a point on the map.
 */
@interface ATCPoint : NSObject {
    @private
    float _X;
    float _Y;
}

/**
 * Creates a point at the specified coordinates.
 * @param x
 * @param y
 */
- (id)initWithCoordinateX:(float)x andCoordinateY:(float)y;

/**
 * The x coordinate of the point.
 */
@property (nonatomic, assign) float X;

/**
 * The y coordinate of the point.
 */
@property (nonatomic, assign) float Y;

/**
 * Factory method to duplicate a point.
 * @param The point to duplicate.
 * @return A point having the same characteristics as the initial one.
 */
+ (ATCPoint *)pointFromExisting:(ATCPoint *)point;

@end
