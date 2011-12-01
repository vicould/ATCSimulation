//
//  AirplanePosition.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCAirplaneInformation.h"

@implementation ATCAirplaneInformation

- (id)initWithZone:(NSInteger)currentZone andPoint:(ATCPoint *)airplaneCoordinates {
    
    self = [super init];
    
    if (self) {
        self.zone = currentZone;
        self.coordinates = airplaneCoordinates;
    }
    
    return self;
}

@synthesize zone = _zone;
@synthesize coordinates = _coordinates;
@synthesize speed = _speed;
@synthesize course = _course;
@synthesize destination = _destination;

- (void)dealloc {
    self.coordinates = nil;
    
    [super dealloc];
}

# pragma mark - Class methods

+ (ATCAirplaneInformation *)planeInformationFromExisting:(ATCAirplaneInformation *)info {
    ATCPoint *newPoint = [ATCPoint pointFromExisting:info.coordinates];
    
    ATCAirplaneInformation *newPosition = [[ATCAirplaneInformation alloc] initWithZone:info.zone
                                                        andPoint:newPoint];
    newPosition.course = info.course;
    newPosition.speed = info.speed;
    newPosition.destination = info.destination;
    
    return [newPosition autorelease];
}

@end
