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
@property (nonatomic, retain) NSTimer *positionUpdater;
@property (nonatomic, assign) int deviated;

- (void)updatePosition;

- (void)sendCurrentPosition;
- (void)changeZoneWithNewController:(NSString *)controllerName;

- (void)updatePositionInEnvironmemt:(NSTimer *)timer;

@end

@implementation Airplane

- (id)initWithInitialData:(ATCAirplaneInformation *)airplaneInformation {
    self = [super initWithAgentName:airplaneInformation.airplaneName];
    
    if (self) {
        self.ownInformation = airplaneInformation;
        
        // registers for the broadcast messages in the zone
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:[BasicController messageIdentifierForZone:self.ownInformation.currentZoneID] object:nil];
        
        self.agentBehaviorDelegate = self;
    }
    
    return self;
}

@synthesize ownInformation = _ownInformation;
@synthesize positionUpdater = _positionUpdater;

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

- (NSDate *)lastPositionCheck {
    return self.ownInformation.informationValidity;
}

- (void)setLastPositionCheck:(NSDate *)lastPositionCheck {
    self.ownInformation.informationValidity = lastPositionCheck;
}

@synthesize deviated;

- (void)startSimulation {
    self.deviated = 0;
    // inits flight time
    self.lastPositionCheck = [NSDate date];
    
    self.course = [self.artifactDelegate calculateAzimutToDestination:self.destination fromPoint:self.ownInformation.coordinates];
    
    self.positionUpdater = [NSTimer scheduledTimerWithTimeInterval:0.25 target:self selector:@selector(updatePositionInEnvironmemt:) userInfo:nil repeats:YES];
}

- (void)stopSimulation {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:[BasicController messageIdentifierForZone:self.ownInformation.currentZoneID] object:nil];
    
    [self.positionUpdater invalidate];
}

- (void)updatePosition {
    // calculates current position since last check, and updates the attribute
    NSTimeInterval lastCheckInterval = - [self.lastPositionCheck timeIntervalSinceNow];
    
    self.ownInformation.coordinates = [self.artifactDelegate calculateNewPositionFromCurrent:self.ownInformation afterInterval:lastCheckInterval];
    
    // updates the timestamp since last check
    self.lastPositionCheck = [NSDate date];
    
    // verifies if we are on the runway
    if ([self.artifactDelegate checkIfPointIsOnRunway:self.ownInformation.coordinates fromZone:self.ownInformation.currentZoneID]) {
        // we are on the runway
        [self stopSimulation];
        [self.artifactDelegate landAirplane:self.ownInformation.airplaneName];
        NSLog(@"Arrived");
    }
    
    // verifies if we changed zone
    int newZone = [self.artifactDelegate calculateCurrentZoneFromPoint:self.ownInformation.coordinates];
    
    if (newZone != self.ownInformation.currentZoneID) {
        // aha, we are leaving a zone
        
        // tells the controller
        [self sendMessage:@"" fromType:NVMessageLeavingZone toAgent:[BasicController zoneIdentifierAsStringWithID:self.ownInformation.currentZoneID]];
        
        // unregisters from the previous' zone messages, and registers for the new zone
        [[NSNotificationCenter defaultCenter] removeObserver:self name:[BasicController messageIdentifierForZone:self.ownInformation.currentZoneID] object:nil];
        
        self.ownInformation.currentZoneID = newZone;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveMessage:) name:[BasicController messageIdentifierForZone:self.ownInformation.currentZoneID] object:nil];
    }
}

- (void)updatePositionInEnvironmemt:(NSTimer *)timer {
    if (self.deviated == 0) {
        // we follow our self course
        self.course = [self.artifactDelegate calculateAzimutToDestination:self.destination fromPoint:self.ownInformation.coordinates];
    }

    [self updatePosition];
    
    [self.artifactDelegate updateAirplaneInformation:self.ownInformation];
}

# pragma mark - Messages

- (void)analyzeMessage:(NSDictionary *)messageContent withOriginalDestinator:(NSString *)destinator{
    // depending on the type of the message, activates the corresponding method
    int messageCode = [(NSNumber *)[messageContent objectForKey:kNVKeyCode] intValue];
    
    NSString *zoneIdentifier = [BasicController messageIdentifierForZone:self.ownInformation.currentZoneID];
    
    if ([destinator isEqualToString:kNVBroadcastMessage]) {
        // generic broadcast messages
    } else if ([destinator isEqualToString:zoneIdentifier]) {
        // zone broadcast messages
        if (messageCode == NVMessageCurrentPosition) {
            [self sendCurrentPosition];
        }
    } else if ([destinator isEqualToString:self.agentName]) {
        // specific messages
        if (messageCode == NVMessageCurrentPosition) {
            [self sendCurrentPosition];
        } else if (messageCode == NVMessageNewRouteInstruction) {
            self.deviated++;
            // parses the message to get the new course
            int newCourse = [(NSString *)[messageContent objectForKey:kNVKeyContent] intValue];
            self.course = newCourse;
        } else if (messageCode == NVMessageResumeInitialDestination) {
            self.deviated--;
            self.course = [self.artifactDelegate calculateAzimutToDestination:self.destination fromPoint:self.ownInformation.coordinates];
        }
    }
    
}

- (void)changeZoneWithNewController:(NSString *)controllerName {
    // updates the controller we have to contact
    self.currentController = controllerName;
    
    // calls new controller, to transmit destination, position, course, and speed
    NSString *message = [NSString stringWithFormat:@"%@;%f;%f;%d;%d", self.destination, self.ownInformation.coordinates.X, self.ownInformation.coordinates.Y, self.course, self.speed];
    
    [self sendMessage:message fromType:NVMessageEnteringNewZone toAgent:self.currentController];
}

- (void)sendCurrentPosition {
    // checks where the airplane is, to send actual value
    [self updatePosition];
    
    // creates the message as a string
    NSString *message = [NSString stringWithFormat:@"%@;%f;%f;%d;%d", self.destination, self.ownInformation.coordinates.X, self.ownInformation.coordinates.Y, self.course, self.speed];
    
    [self sendMessage:message fromType:NVMessageCurrentPosition toAgent:[BasicController zoneIdentifierAsStringWithID:self.ownInformation.currentZoneID]];
}

- (void)dealloc {
    self.positionUpdater = nil;
    
    self.ownInformation = nil;
    self.destination = nil;
    self.ownInformation = nil;
    self.lastPositionCheck = nil;
    
    [super dealloc];
}

@end
