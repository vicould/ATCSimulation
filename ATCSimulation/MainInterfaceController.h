//
//  MainInterfaceController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Environment.h"
#import "EnvironmentDisplayDelegate.h"

@class Environment;

@interface MainInterfaceController : UIViewController<EnvironmentDisplayDelegate> {
    @private
    UIButton *_startStopButton;
    UIView *_mapView;
    
    BOOL _started;
    Environment *_environment;
    NSMutableDictionary *_airplanesDictionary;
}

@property (nonatomic, retain) IBOutlet UIButton *startStopButton;
@property (nonatomic, retain) IBOutlet UIView *mapView;

- (IBAction)startStopPressed:(id)sender;

@end
