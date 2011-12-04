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
#import "Artifacts.h"
#import "BasicController.h"

@class ATCAirplaneInformation;
@class Artifacts;
@class BasicController;

@interface Airplane : BasicAgent<AgentBehaviorDelegate> {
    @private
    ATCAirplaneInformation *_ownInformation;
    NSString *_currentController;
    NSDate *_lastPositionCheck;
}

- (id)initWithInitialData:(ATCAirplaneInformation *)airplaneInformation;

// properties needed for the omniscience of the environment
// between the agents only messages are used otherwise
@property (nonatomic, retain, readonly) ATCAirplaneInformation *ownInformation;
@property (nonatomic, assign, readonly) NSInteger speed;
@property (nonatomic, assign, readonly) NSInteger course;
@property (nonatomic, retain, readonly) NSString *destination;

@end
