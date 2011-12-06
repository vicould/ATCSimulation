//
//  MessageAnalyzerDelegate.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * This protocol defines abstract methods an agent needs to implement to provide more evolved behaviors than the common BasicAgent 
 * object.
 */
@protocol AgentBehaviorDelegate <NSObject>

/**
 * Finish processing the message, as kindly cut by the BasicAgent.
 * @param messageContent A dictionary containing the different characteristics of the message, such as its type,
 * its content, etc.
 * @param destinator The original destinator of this message (the particular agent, broadcast methods, etc.).
 */
- (void)analyzeMessage:(NSDictionary *)messageContent withOriginalDestinator:(NSString *)destinator;

/**
 * Asks the agent to begin to run, processing the inputs and trying to reach its goal.
 */
- (void)startSimulation;

/**
 * Asks the agent to stop all the activities.
 */
- (void)stopSimulation;

@end
