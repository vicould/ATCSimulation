//
//  ControllerBehaviorDelegate.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/30/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Constants.h"

@protocol ControllerBehaviorDelegate <NSObject>

- (void)finishMessageAnalysis:(NSString *)messageContent withMessageCode:(NVMessageCode)code from:(NSString *)sender originallyTo:(NSString *)originalReceiver;

@end
