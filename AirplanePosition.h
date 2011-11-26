//
//  AirplanePosition.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AirplanePosition : NSObject {
    @private
    NSInteger _zone;
    NSNumber *_positionX;
    NSNumber *_positionY;
}

- (id)initWithZone:(NSInteger)currentZone andPositionX:(NSNumber *)currentX andY:(NSNumber *)currentY;

@property (nonatomic, assign) NSInteger zone;
@property (nonatomic, retain) NSNumber *positionX;
@property (nonatomic, retain) NSNumber *positionY;

@end
