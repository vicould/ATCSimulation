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

@synthesize agentName = _agentName;
@synthesize agentBehaviorDelegate = _agentBehaviorDelegate;
@synthesize artifactDelegate = _artifactDelegate;

- (void)sendMessage:(NSString *)message fromType:(NVMessageCode)type toAgent:(NSString *)agentName {    
    // builds an info dictionary, specifying the originating agent, and some attributes
    NSDictionary *messageContent = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:self.agentName, [NSNumber numberWithInt:type], message, nil] forKeys:[NSArray arrayWithObjects:kNVKeyOrigin, kNVKeyCode, kNVKeyContent, nil]];
    
    NSLog(@"%@ %@ %d %@", self.agentName, agentName, type, message);
    
    [[NSNotificationCenter defaultCenter] postNotificationName:agentName object:self userInfo:messageContent];
}

- (void)receiveMessage:(NSNotification *)notification {
    NSDictionary *messageContent = [notification userInfo];
    
    int code = [(NSNumber *)[messageContent objectForKey:kNVKeyCode] intValue];
    
    if ([[notification name] isEqualToString:kNVBroadcastMessage]) {
        // generic broadcast messages
        if (code == NVMessageSimulationStarted) {
            // message triggering simulation start
            [self.agentBehaviorDelegate startSimulation];
            return;
        } else if (code == NVMessageSimulationStopped) {
            [self.agentBehaviorDelegate stopSimulation];
            return;
        }
    }
    
    // transmits the mesage for further analyze to the delegate
    [self.agentBehaviorDelegate analyzeMessage:messageContent withOriginalDestinator:[notification name]];
}

- (void)dealloc {
    self.agentName = nil;
    self.agentBehaviorDelegate = nil;
    
    // unregisters the notifications observers
    [[NSNotificationCenter defaultCenter] removeObserver:self name:self.agentName object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kNVBroadcastMessage object:nil];
    
    [super dealloc];
}

@end
