//
//  BasicAgent.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@interface BasicAgent : NSObject {
    @private
    NSString *_agentName;
    id currentMessage;
}

@property (nonatomic, retain, readonly) NSString *agentName;

- (void)initWithAgentName:(NSString *)name;


// messaging methods
- (void)sendMessage:(NSString *)message fromType:(NSInteger)type toAgent:(NSString *)agentName;
- (void)receiveMessage:(NSNotification *)notification;

@end
