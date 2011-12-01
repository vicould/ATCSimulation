//
//  Point.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/27/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ATCPoint : NSObject {
    @private
    float _coordinateX;
    float _coordinateY;
}

- (id)initWithCoordinateX:(float)x andCoordinateY:(float)y;

@property (nonatomic, assign) float coordinateX;
@property (nonatomic, assign) float coordinateY;

+ (ATCPoint *)pointFromExisting:(ATCPoint *)point;

@end
