//
//  ZoneController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ZoneController.h"

@interface ZoneController ()

@end

@implementation ZoneController

- (id)init {
    self = [super init];
    
    if (self) {
        self.controllerDelegate = self;
    }
    
    return self;
}

- (void)finishMessageAnalysis:(NSString *)messageContent withMessageCode:(NVMessageCode)code from:(NSString *)sender originallyTo:(NSString *)originalReceiver {
    
}



@end
