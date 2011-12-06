//
//  ZoneController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BasicController.h"
#import "ControllerBehaviorDelegate.h"

@class BasicController;

/**
 * One of the two specialized agent playing the role of a controller. It can track the airplanes, and communicate with
 * them.
 */
@interface ZoneController : BasicController<ControllerBehaviorDelegate> {
    
}

@end
