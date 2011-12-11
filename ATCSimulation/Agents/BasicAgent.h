//
//  BasicAgent.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"
#import "AgentBehaviorDelegate.h"
#import "ArtifactsDelegate.h"

#import "clips.h"

/**
 * A basic class defining some ground behaviors for an agent, such as the messaging capabilities.
 * As an agent it replies to some of the messages received from the other agents, using its reasoning capabilities to determine
 * if an answer is needed and wanted according to its goal.
 */
@interface BasicAgent : NSObject {
    @private
    NSString *_agentName;
    id<AgentBehaviorDelegate> _agentBehaviorDelegate;
    id<ArtifactsDelegate> _artifactDelegate;
}

/**
 * Creates an instance of an agent.
 * @param name The name of the agent, setting the destinator for the messages.
 */
- (id)initWithAgentName:(NSString *)name;

/**
 * Gets the name of this agent.
 */
@property (nonatomic, retain, readonly) NSString *agentName;

/**
 * A property used to set the object implementing the various methods of the AgentBehaviorDelegate.
 */
@property (nonatomic, retain) id<AgentBehaviorDelegate> agentBehaviorDelegate;

/**
 * A property used to set the object implementing the artifacts that the agent can use.
 */
@property (nonatomic, retain) id<ArtifactsDelegate> artifactDelegate;

# pragma mark - Messaging methods

/**
 * Top level method to send messages to other agents.
 * @param message The content of the message to be sent, as a string.
 * @param type The corresponding code of the message.
 * @param agentName The name of the destinator of this message.
 */
- (void)sendMessage:(NSString *)message fromType:(NVMessageCode)type toAgent:(NSString *)agentName;

/**
 * The method which is called when the agent receives a message from others.
 * @param notification The object wrapping the different elements of the message.
 */
- (void)receiveMessage:(NSNotification *)notification;

@end
