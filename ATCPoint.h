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
    NSNumber *_coordinateX;
    NSNumber *_coordinateY;
}

- (id)initWithCoordinateX:(NSNumber *)x andCoordinateY:(NSNumber *)y;

@property (nonatomic, retain) NSNumber *coordinateX;
@property (nonatomic, retain) NSNumber *coordinateY;

@end
