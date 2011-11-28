//
//  BasicAgent.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicAgent.h"

@interface BasicAgent ()

@property (nonatomic, retain, readwrite) NSString *agentName;

@end

@implementation BasicAgent

- (id)initWithAgentName:(NSString *)name {
    self = [super init];
    if (self) {
        self.agentName = name;
        
        // registers with the Notification Center
        // personal message
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:self.agentName object:nil];

        // broadcast message
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:kNVBroadcastMessage object:nil];
    }
    
    return self;
}

- (void)sendMessage:(NSString *)message fromType:(NSInteger)type toAgent:(NSString *)agentName {    
    // builds an info dictionary, specifying the originating agent, and some attributes
    NSDictionary *messageContent = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.agentName, [NSNumber numberWithInt:type], message, nil] forKeys:[NSArray arrayWithObjects:kNVKeyOrigin, kNVKeyType, kNVKeyContent, nil]];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:agentName object:self userInfo:messageContent];
}

- (void)receiveMessage:(NSNotification *)notification {
    NSDictionary *messageContent = [notification userInfo];
    
    // transmits the mesage for further analyze to the delegate
    [self.messageReceiver analyzeMessage:messageContent];
}

@synthesize agentName = _agentName;
@synthesize messageReceiver = _messageReceiver;

- (void)dealloc {
    self.agentName = nil;
    self.messageReceiver = nil;
    [super dealloc];
}

@end
