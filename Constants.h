//
//  Constants.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString * const kNVBroadcastMessage;

extern NSString * const kNVKeyOrigin;
extern NSString * const kNVKeyType;
extern NSString * const kNVKeyContent;

/* message types
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
    NVMessageEnteringNewZone = 1201,
    NVMessageLeavingZone = 1202,
    NVMessageCurrentPosition = 1203,
    NVMessageDestination = 1204,
    NVMessageLowFuelLevel = 1205,
    NVMessageEmergency = 1206,
    NVMessageIncident = 1207,
    NVMessageLandingIntentionZone = 1208,
    NVMessageLandingIntentionAirport = 1301,
    NVMessagePlaneLanded = 1302,
    NVMessageDistanceFromAirport = 1303,
    NVMessageLevelOfFuel = 1304,
    NVMessageAircraftCategory = 1305,
};
typedef NSInteger NVMessageType;

/*
 *
 */
enum {
    NVPriorityLow = -100,
    NVPriorityNormal = 0,
    NVPriorityEmergency = 100
};
typedef NSInteger NVPriorityType;