//
//  AirportController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AirportController.h"

@interface AirportController ()

@property (nonatomic, retain) NSString *airportName;
@property (nonatomic, retain) ATCPoint *airportLocation;

@end

@implementation AirportController


- (id)initWithAirportName:(NSString *)airportName andLocation:(ATCPoint *)airportLocation {
    self = [super init];
    
    if (self) {
        self.controllerDelegate = self;
        _airportName = airportName;
        _airportLocation = airportLocation;
    }
    
    return self;    
}

@synthesize airportName = _airportName;
@synthesize airportLocation = _airportLocation;

- (void)finishMessageAnalysis:(NSString *)messageContent withMessageCode:(NVMessageCode)code from:(NSString *)sender originallyTo:(NSString *)originalReceiver {
    
}

@end
