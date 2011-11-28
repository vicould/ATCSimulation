//
//  AirplanePosition.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCPoint.h"

@class ATCPoint;

@interface ATCPosition : NSObject {
    @private
    NSInteger _zone;
    ATCPoint *_coordinates;
}

- (id)initWithZone:(NSInteger)currentZone andPoint:(ATCPoint *)airplaneCoordinates;

@property (nonatomic, assign) NSInteger zone;
@property (nonatomic, retain) ATCPoint *coordinates;

@end
