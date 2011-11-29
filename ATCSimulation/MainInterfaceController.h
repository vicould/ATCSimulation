//
//  MainInterfaceController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Environment.h"

@class Environment;

@interface MainInterfaceController : UIViewController {
    @private
    UIButton *_startStopButton;
    BOOL _started;
    Environment *_environment;
}

@property (nonatomic, retain) IBOutlet UIButton *startStopButton;

- (IBAction)startStopPressed:(id)sender;

@end
