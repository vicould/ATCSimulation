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

- (void)initWithAgentName:(NSString *)name {
    self = [super init];
    if (self) {
        self.agentName = name;
        currentMessage = nil;
        
        // registers with the Notification Center
        // personal message
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:self.agentName object:currentMessage];

        // broadcast message
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:kNVBroadcastMessage object:currentMessage];
    }
    
}

- (void)sendMessage:(NSString *)message fromType:(NSInteger)type toAgent:(NSString *)agentName {
    // send message using NSNotificationCenter
}

- (void)receiveMessage:(NSNotification *)notification {
    
}

@synthesize agentName = _agentName;

@end
