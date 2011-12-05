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

#define SimulationReady 0
#define SimulationStarted 1
#define SimulationStopped 2


@class Environment;

@interface MainInterfaceController : UIViewController<EnvironmentDisplayDelegate> {
    @private
    UIButton *_startStopButton;
    UIView *_mapView;
    
    int _simulationState;
    Environment *_environment;
    NSMutableDictionary *_airplanesDictionary;
}

@property (nonatomic, retain) IBOutlet UIButton *startStopButton;
@property (nonatomic, retain) IBOutlet UIView *mapView;

- (IBAction)startStopPressed:(id)sender;

@end
