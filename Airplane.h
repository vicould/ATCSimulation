//
//  Airplane.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "BasicAgent.h"
#import "ATCPosition.h"
#import "MessageAnalyzerDelegate.h"
#import "Artifacts.h"

@class ATCPosition;
@class Artifacts;

@interface Airplane : BasicAgent<MessageAnalyzerDelegate> {
    @private
    ATCPosition *_currentPosition;
    NSString *_currentController;
    NSInteger _speed;
    NSInteger _course;
    NSString *_destination;
    NSDate *_lastPositionCheck;
}

- (id)initWithTailNumber:(NSString *)tailNumber initialPosition:(ATCPosition *)airplanePosition andDestination:(NSString *)destinationName;

@end
