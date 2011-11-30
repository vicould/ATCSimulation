//
//  Airplane.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicAgent.h"
#import "ATCPosition.h"
#import "AgentBehaviorDelegate.h"
#import "Artifacts.h"

@class ATCPosition;
@class Artifacts;

@interface Airplane : BasicAgent<AgentBehaviorDelegate> {
    @private
    ATCPosition *_currentPosition;
    NSString *_currentController;
    NSString *_destination;
    NSDate *_lastPositionCheck;
}

// properties needed for the omniscience of the environment
// between the agents only messages are used otherwise
@property (nonatomic, retain, readonly) ATCPosition *currentPosition;
@property (nonatomic, assign, readonly) NSInteger speed;
@property (nonatomic, assign, readonly) NSInteger course;
@property (nonatomic, retain, readonly) NSString *destination;

- (id)initWithTailNumber:(NSString *)tailNumber initialPosition:(ATCPosition *)airplanePosition andDestination:(NSString *)destinationName;

@end
