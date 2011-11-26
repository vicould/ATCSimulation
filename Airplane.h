//
//  Airplane.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicAgent.h"
#import "AirplanePosition.h"

@class AirplanePosition;

@interface Airplane : BasicAgent {
    @private
    AirplanePosition *_currentPosition;
    NSInteger _speed;
    NSInteger _route;
    NSString *_destination;
}

- (id)initWithTailNumber:(NSString *)tailNumber initialPosition:(AirplanePosition *)airplanePosition andDestination:(NSString *)destinationName;

@property (nonatomic, readonly, retain) AirplanePosition *currentPosition;
@property (nonatomic, readonly, assign) NSInteger speed;
@property (nonatomic, readonly, assign) NSInteger route;
@property (nonatomic, readonly, retain) NSString *destination;

@end
