//
//  Constants.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define SCALE 4

#define TIME_FACTOR 100

extern NSString * const kNVBroadcastMessage;

extern NSString * const kNVKeyOrigin;
extern NSString * const kNVKeyCode;
extern NSString * const kNVKeyContent;

/**
 * Codes for the messages exchanged by the agents.
 * 1 airplane
 * 2 zone controller
 * 3 airport controller
 * XYZZ:
 * X from
 * Y to
 * Z message code
*/ 
enum {
    NVMessageAcknowledgement = 1,
    NVMessageRefused = -1,
    NVMessageSimulationStarted = 10,
    NVMessageSimulationStopped = 11,

//Airplane to zone controller
    NVMessageEnteringNewZone = 1201,
    NVMessageLeavingZone = 1202,
    NVMessageCurrentPosition = 1203,
    NVMessageDestination = 1204,
    NVMessageLowFuelLevel = 1205,
    NVMessageEmergency = 1206,
    NVMessageIncident = 1207,
    NVMessageLandingIntentionZone = 1208,

//Airplane to airport controller
    NVMessageLandingIntentionAirport = 1301,
    NVMessagePlaneLanded = 1302,
    NVMessageDistanceFromAirport = 1303,
    NVMessageLevelOfFuel = 1304,
    NVMessageAircraftCategory = 1305,

//Zone controller to airplane
    NVMessageEnteringNewZoneClearance = 2301,
    NVMessageEnteringNewZoneRefusal = 2302,    
    NVMessageContactAirport = 2303,
    NVMessageRefuseContactAirport = 2304,
    NVMessageNewSpeedInstruction = 2305,
    NVMessageResumeInitialDestination = 2306,
    
    
//Zone controller to zone controller
    NVMessageInformAdjacentController = 2201,
    
//Airport controller to airplane
    NVMessageNewZoneClearance = 3101, 
    NVMessageEnterZoneRefusal = 3102,
    NVMessageLandingIntentionAirplane = 3103, 
    NVMessageCancelLanding = 3104,
    NVMessageWaitingTime = 3105

};
typedef NSInteger NVMessageCode;

/**
 * Priority for the airplanes, to set the right order for landing.
 */
enum {
    NVPriorityLow = -100,
    NVPriorityNormal = 0,
    NVPriorityEmergency = 100
};
typedef NSInteger NVPriorityType;