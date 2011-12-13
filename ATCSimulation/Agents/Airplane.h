//
//  Airplane.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicAgent.h"
#import "ATCAirplaneInformation.h"
#import "AgentBehaviorDelegate.h"
#import "BasicController.h"

@class ATCAirplaneInformation;
@class Artifacts;
@class BasicController;

/**
 * The agent representing an airplane. It flies by itself with some characteristics defined in its ownInformation property.
 */
@interface Airplane : BasicAgent<AgentBehaviorDelegate> {
    @private
    ATCAirplaneInformation *_ownInformation;
    NSString *_currentController;
    NSTimer *_positionUpdater;
    int deviated;
    float oldSpeed;
}

/**
 * Creates an instance of the airplane, setting the characteristics using the ATCAirplaneInformation class, which holds
 * data such as the speed, the course, etc.
 * @param airplaneInformation A collection of informations about this airplane.
 */
- (id)initWithInitialData:(ATCAirplaneInformation *)airplaneInformation;

// properties needed for the omniscience of the environment
// between the agents only messages are used otherwise

/**
 * Gets the information instance for this object.
 */
@property (nonatomic, retain, readonly) ATCAirplaneInformation *ownInformation;

/**
 * Gets the speed of the airplane.
 */
@property (nonatomic, assign, readonly) NSInteger speed;

/**
 * Gets the course of the airplane.
 */
@property (nonatomic, assign, readonly) NSInteger course;

/**
 * Gets the destination of the airplane.
 */
@property (nonatomic, retain, readonly) NSString *destination;

@end
