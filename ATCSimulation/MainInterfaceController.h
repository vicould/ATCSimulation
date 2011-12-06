//
//  MainInterfaceController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "Environment.h"
#import "EnvironmentDisplayDelegate.h"
#import "MapView.h"

#define SimulationReady 0
#define SimulationStarted 1
#define SimulationStopped 2


@class Environment;

/**
 * The view controller for the interface, communicating with the user and the simulation.
 */
@interface MainInterfaceController : UIViewController<EnvironmentDisplayDelegate> {
    @private
    UIButton *_startStopButton;
    MapView *_mapView;
    UIView *_controllersView;
    UIView *_airplanesView;
    
    int _simulationState;
    Environment *_environment;
    NSMutableDictionary *_airplanesTransmitted;
    NSMutableDictionary *_airplanesDetected;
}

@property (nonatomic, retain) IBOutlet UIButton *startStopButton;
@property (nonatomic, retain) IBOutlet MapView *mapView;
@property (nonatomic, retain) IBOutlet UIView *controllersView;
@property (nonatomic, retain) IBOutlet UIView *airplanesView;

- (IBAction)startStopPressed:(id)sender;

@end
