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

@interface ATCAirplaneInformation : NSObject {
    @private
    NSInteger _currentZoneID;
    ATCPoint *_coordinates;
    NSInteger _speed;
    NSInteger _course;
    NSString *_destination;
    NSString *_airplaneName;
}

- (id)initWithZone:(NSInteger)currentZone andPoint:(ATCPoint *)airplaneCoordinates;

@property (nonatomic, assign) NSInteger currentZoneID;
@property (nonatomic, retain) ATCPoint *coordinates;
@property (nonatomic, assign) NSInteger speed;
@property (nonatomic, assign) NSInteger course;
@property (nonatomic, retain) NSString *destination;
@property (nonatomic, retain) NSString *airplaneName;

+ (ATCAirplaneInformation *)planeInformationFromExisting:(ATCAirplaneInformation *)info;

@end
