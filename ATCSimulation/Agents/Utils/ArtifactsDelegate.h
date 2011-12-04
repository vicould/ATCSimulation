//
//  ArtifactsDelegate.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/3/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCAirplaneInformation.h"



@protocol ArtifactsDelegate <NSObject>

- (void)updateInterfaceWithInformationsForZone:(NSArray *)informations;
- (void)landAirplane:(ATCAirplaneInformation *)airplane;
- (void)crashAirplane:(ATCAirplaneInformation *)airplane;

@end
