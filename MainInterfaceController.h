//
//  MainInterfaceController.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainInterfaceController : UIViewController {
    @private
    UIButton *_startStopButton;
    BOOL _started;
}

@property (nonatomic, retain) IBOutlet UIButton *startStopButton;

- (IBAction)startStopPressed:(id)sender;

@end
