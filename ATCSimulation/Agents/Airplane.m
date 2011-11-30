//
//  Airplane.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Airplane.h"

@interface Airplane ()

@property (nonatomic, retain) ATCAirplaneInformation *currentPosition;
@property (nonatomic, assign) NSInteger speed;
@property (nonatomic, assign) NSInteger course;
@property (nonatomic, retain) NSString *destination;
@property (nonatomic, retain) NSString *currentController;
@property (nonatomic, retain) NSDate *lastPositionCheck;

- (void)updatePosition;

- (void)sendCurrentPosition;
- (void)changeZoneWithNewController:(NSString *)controllerName;

@end

@implementation Airplane

- (id)initWithTailNumber:(NSString *)tailNumber initialPosition:(ATCAirplaneInformation *)airplanePosition andDestination:(NSString *)destinationName {
    self = [super initWithAgentName:tailNumber];
    
    if (self) {
        self.currentPosition = airplanePosition;
        
        // registers for the broadcast messages in the zone
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:[BasicController zoneIdentifierAsStringWithID:airplanePosition.zone] object:nil];
        
        self.messageReceiver = self;
    }
    
    return self;
}

@synthesize currentPosition = _currentPosition;

- (NSInteger)course {
    return self.currentPosition.course;
}

- (void)setCourse:(NSInteger)course {
    // updates the current position each time a change is made in the route
    [self updatePosition];
    
    self.currentPosition.course = course;
}

- (NSInteger)speed {
    return self.currentPosition.speed;
}

- (void)setSpeed:(NSInteger)speed {
    // updates the current position each time a change is made in the route
    [self updatePosition];
    
    self.currentPosition.speed = speed;
}

@synthesize destination = _destination;
@synthesize currentController = _currentController;
@synthesize lastPositionCheck = _lastPositionCheck;

- (void)startSimulation {
    // inits flight time
    self.lastPositionCheck = [NSDate date];
}

- (void)updatePosition {
    // calculates current position since last check, and updates the attribute
    NSTimeInterval lastCheckInterval = [self.lastPositionCheck timeIntervalSinceNow];
    
    self.currentPosition.coordinates = [Artifacts calculateNewPositionFromCurrent:self.currentPosition afterInterval:lastCheckInterval];
    
    // updates the timestamp since last check
    self.lastPositionCheck = [NSDate date];
    
    /*
    // verifies if we changed zone
    NSInteger newZone = [Artifacts calculateCurrentZonefromX:self.currentPosition.coordinates.coordinateX andY:self.currentPosition.coordinates.coordinateY];
    
    if (newZone != self.currentPosition.zone) {
        // aha, we are leaving a zone
        
        // unregisters from the previous' zone messages, and registers for the new zone
        [[NSNotificationCenter defaultCenter] removeObserver:self name:[NSString stringWithFormat:@"Zone %d", self.currentPosition.zone] object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:[NSString stringWithFormat:@"Zone %d", newZone] object:nil];
        
        // calls the current zone controller to inform we are leaving his control, and would like the
        // new controller's name for the next zone
    }
    
    // sets a timer calling back this method to verify if we changed zone, based on the current
    // route and speed
     */
}

# pragma mark - Messages

- (void)analyzeMessage:(NSDictionary *)messageContent withOriginalDestinator:(NSString *)destinator{
    // depending on the type of the message, activates the corresponding method
    
    if ([destinator isEqualToString:kNVBroadcastMessage]) {
        // generic broadcast messages
        if ([(NSNumber *)[messageContent objectForKey:kNVKeyCode] intValue] == NVMessageSimulationStarted) {
            // message triggering simulation start
        }
        
        
    } else if ([destinator isEqualToString:[BasicController zoneIdentifierAsStringWithID:self.currentPosition.zone]]) {
        // zone broadcast messages
    } else if ([destinator isEqualToString:self.agentName]) {
        // specific messages
    }
    
}

- (void)changeZoneWithNewController:(NSString *)controllerName {
    // updates the controller we have to contact
    self.currentController = controllerName;
    
    // calls new controller, to transmit destination, position, course, and speed
    NSString *message = [NSString stringWithFormat:@"%@;%f;%f;%d;%d", self.destination, [self.currentPosition.coordinates.coordinateX floatValue], [self.currentPosition.coordinates.coordinateY floatValue], self.course, self.speed];
    
    [self sendMessage:message fromType:NVMessageEnteringNewZone toAgent:self.currentController];
}

- (void)sendCurrentPosition {
    // checks where the airplane is, to send actual value
    [self updatePosition];
    
    // creates the message as a string
    NSString *message = [NSString stringWithFormat:@"%f;%f", [self.currentPosition.coordinates.coordinateX floatValue], [self.currentPosition.coordinates.coordinateY floatValue]];
    
    [self sendMessage:message fromType:NVMessageCurrentPosition toAgent:self.currentController];
}

- (void)dealloc {
    self.currentPosition = nil;
    self.destination = nil;
    self.currentPosition = nil;
    self.lastPositionCheck = nil;
    
    [super dealloc];
}

@end
