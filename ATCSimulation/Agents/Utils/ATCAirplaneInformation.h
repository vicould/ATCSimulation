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

/**
 * A class containing all the information needed to completely characterize an airplane. It is used both by the airplane
 * and the controllers to hold the information about the airplane, and to be able to represent it correctly then.
 */
@interface ATCAirplaneInformation : NSObject {
    @private
    NSInteger _currentZoneID;
    ATCPoint *_coordinates;
    NSInteger _speed;
    NSInteger _course;
    NSString *_destination;
    NSString *_airplaneName;
}

/**
 * Creates the placeholder with some initial information.
 * @class currentZone The zone the airplane is in.
 * @class airplaneCoordinates A reference to the current location of the airplane.
 */
- (id)initWithZone:(NSInteger)currentZone andPoint:(ATCPoint *)airplaneCoordinates;

/**
 * Property containing the zone the airplane is in.
 */
@property (nonatomic, assign) NSInteger currentZoneID;

/**
 * Property describing the location of the airplane.
 */
@property (nonatomic, retain) ATCPoint *coordinates;

/**
 * The speed of the airplane.
 */
@property (nonatomic, assign) NSInteger speed;

/**
 * Its route.
 */
@property (nonatomic, assign) NSInteger course;

/**
 * Its destination.
 */
@property (nonatomic, retain) NSString *destination;

/**
 * The name of the airplane, which is unique.
 */
@property (nonatomic, retain) NSString *airplaneName;

/**
 * Duplicates one object.
 */
+ (ATCAirplaneInformation *)planeInformationFromExisting:(ATCAirplaneInformation *)info;

@end
