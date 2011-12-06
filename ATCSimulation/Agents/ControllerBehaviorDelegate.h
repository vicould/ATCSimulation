//
//  ControllerBehaviorDelegate.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

/**
 * This protocol defines the various methods a controller needs to implement, to provide an extended support for other capabilities
 * reached through the messaging features.
 */
@protocol ControllerBehaviorDelegate <NSObject>

/**
 * This method is usually called if the BasicController was not able to use the message received. It transmits the message
 * calling maybe more specific methods of the controller, with the content of the initial message.
 * @param messageContent The content of the message, containing formatted information.
 * @param code The code of the message.
 * @param sender The initial sender of the message.
 * @param originalReceiver The destination of the message, which can this agent, or all the agents etc.
 */
- (void)finishMessageAnalysis:(NSString *)messageContent withMessageCode:(NVMessageCode)code from:(NSString *)sender originallyTo:(NSString *)originalReceiver;

@end
