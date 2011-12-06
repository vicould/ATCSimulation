//
//  BasicController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicAgent.h"
#import "AgentBehaviorDelegate.h"
#import "ControllerBehaviorDelegate.h"
#import "ATCAirplaneInformation.h"

@class ATCAirplaneInformation;
@class Environment;

/**
 * A class defining the common behaviors of the specialized controllers. It also uses another delegate to finish handling
 * messages, start and stop the simulation, etc.
 */
@interface BasicController : BasicAgent<AgentBehaviorDelegate> {
    @private
    NSMutableDictionary *_controlledAirplanes;
    int _zoneID;
    id<ControllerBehaviorDelegate> _controllerDelegate;
    NSTimer *positionUpdatePollingTimer;
}

/**
 * A dictionary referencing the different airplanes controlled by this controller, containing the name of the agent as key
 * and the information about the airplane as value.
 */
@property (readonly, retain) NSMutableDictionary *controlledAirplanes;

/**
 * The zone the controller is belonging to.
 */
@property (nonatomic, readonly, assign) int zoneID;

/**
 * The delegate implementing the various specialized behaviors of a controller.
 */
@property (nonatomic, retain) id<ControllerBehaviorDelegate> controllerDelegate;

/**
 * The active radar mode, trying to recover information about the airplanes currently flying in the zone.
 */
- (void)detectAirplanesInZone;

/**
 * An abstract method to create a unique ID for each class.
 * @return Returns an unique id that can be used to identify the zones.
 */
+ (int)createZoneID;

/**
 * Convenient method to represent the zone ID, used as agent name.
 * @param id The id of the zone where a representation is needed.
 */
+ (NSString *)zoneIdentifierAsStringWithID:(int)ID;

/**
 *  Another convenient method to create the the identifier the zone is listening to for incoming messages.
 */
+ (NSString *)messageIdentifierForZone:(int)zoneID;

@end
