//
//  ZoneController+Collision.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ZoneController.h"

@interface ZoneController (Collision)

- (BOOL)evaluateRiskBetweenAirplane1:(ATCAirplaneInformation *)airplane1 andAirplane2:(ATCAirplaneInformation *)airplane2;

@end
