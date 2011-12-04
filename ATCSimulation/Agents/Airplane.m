//
//  Airplane.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Airplane.h"

@interface Airplane ()

@property (nonatomic, retain) ATCAirplaneInformation *ownInformation;
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

- (id)initWithInitialData:(ATCAirplaneInformation *)airplaneInformation {
    self = [super initWithAgentName:airplaneInformation.airplaneName];
    
    if (self) {
        self.ownInformation = airplaneInformation;
        
        // registers for the broadcast messages in the zone
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:[BasicController messageIdentifierForZone:self.ownInformation.currentZoneID] object:nil];
        
        self.messageReceiver = self;
    }
    
    return self;
}

@synthesize ownInformation = _ownInformation;

- (NSInteger)course {
    return self.ownInformation.course;
}

- (void)setCourse:(NSInteger)course {
    // updates the current position each time a change is made in the route
    [self updatePosition];
    
    self.ownInformation.course = course;
}

- (NSInteger)speed {
    return self.ownInformation.speed;
}

- (void)setSpeed:(NSInteger)speed {
    // updates the current position each time a change is made in the route
    [self updatePosition];
    
    self.ownInformation.speed = speed;
}

- (NSString *)destination {
    return self.ownInformation.destination;
}

- (void)setDestination:(NSString *)destination {
    self.ownInformation.destination = destination;
}

@synthesize currentController = _currentController;
@synthesize lastPositionCheck = _lastPositionCheck;

- (void)startSimulation {
    // inits flight time
    self.lastPositionCheck = [NSDate date];
}

- (void)updatePosition {
    // calculates current position since last check, and updates the attribute
    NSTimeInterval lastCheckInterval = - [self.lastPositionCheck timeIntervalSinceNow];
    
    self.ownInformation.coordinates = [Artifacts calculateNewPositionFromCurrent:self.ownInformation afterInterval:lastCheckInterval];
    
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
    NSNumber *messageCode = (NSNumber *)[messageContent objectForKey:kNVKeyCode];
    
    NSString *zoneIdentifier = [BasicController messageIdentifierForZone:self.ownInformation.currentZoneID];
    
    if ([destinator isEqualToString:kNVBroadcastMessage]) {
        // generic broadcast messages
        if ([(NSNumber *)[messageContent objectForKey:kNVKeyCode] intValue] == NVMessageSimulationStarted) {
            // message triggering simulation start
            [self startSimulation];
        }
    } else if ([destinator isEqualToString:zoneIdentifier]) {
        // zone broadcast messages        
        if ([messageCode intValue] == NVMessageCurrentPosition) {
            [self sendCurrentPosition];
        }
    } else if ([destinator isEqualToString:self.agentName]) {
        // specific messages
        if ([messageCode intValue] == NVMessageCurrentPosition) {
            [self sendCurrentPosition];
        }
    }
    
}

- (void)changeZoneWithNewController:(NSString *)controllerName {
    // updates the controller we have to contact
    self.currentController = controllerName;
    
    // calls new controller, to transmit destination, position, course, and speed
    NSString *message = [NSString stringWithFormat:@"%@;%f;%f;%d;%d", self.destination, self.ownInformation.coordinates.coordinateX, self.ownInformation.coordinates.coordinateY, self.course, self.speed];
    
    [self sendMessage:message fromType:NVMessageEnteringNewZone toAgent:self.currentController];
}

- (void)sendCurrentPosition {
    // checks where the airplane is, to send actual value
    [self updatePosition];
    
    // creates the message as a string
    NSString *message = [NSString stringWithFormat:@"%@;%f;%f;%d;%d", self.destination, self.ownInformation.coordinates.coordinateX, self.ownInformation.coordinates.coordinateY, self.course, self.speed];
    
    [self sendMessage:message fromType:NVMessageCurrentPosition toAgent:[BasicController zoneIdentifierAsStringWithID:self.ownInformation.currentZoneID]];
}

- (void)dealloc {
    self.ownInformation = nil;
    self.destination = nil;
    self.ownInformation = nil;
    self.lastPositionCheck = nil;
    
    [super dealloc];
}

@end
