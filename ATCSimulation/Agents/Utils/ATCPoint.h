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
    float _X;
    float _Y;
}

- (id)initWithCoordinateX:(float)x andCoordinateY:(float)y;

@property (nonatomic, assign) float X;
@property (nonatomic, assign) float Y;

+ (ATCPoint *)pointFromExisting:(ATCPoint *)point;

@end
