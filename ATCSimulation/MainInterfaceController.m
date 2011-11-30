//
//  MainInterfaceController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainInterfaceController.h"

@interface MainInterfaceController ()

@property (nonatomic, assign) BOOL started;
@property (nonatomic, retain) Environment *environment;
@property (nonatomic, retain) NSMutableDictionary *airplanesDictionary;

- (void)createViewsForInterface;

@end

@implementation MainInterfaceController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _started = NO;
        _environment = [[Environment alloc] init];
        _airplanesDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@synthesize startStopButton = _startStopButton;
@synthesize started = _started;
@synthesize environment = _environment;
@synthesize airplanesDictionary = _airplanesDictionary;
@synthesize mapView = _mapView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // creates button
    self.startStopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.startStopButton setFrame:CGRectMake(932, 20, 72, 37)];
    [self.startStopButton setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
    [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startStopButton addTarget:self action:@selector(startStopPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self createViewsForInterface];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.startStopButton = nil;
    self.mapView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

# pragma mark - Interface controls

- (void)createViewsForInterface {
    // creates map view:
    self.mapView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    [self.mapView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    [self.view addSubview:self.mapView];
    
    [self.view addSubview:self.startStopButton];
}

- (IBAction)startStopPressed:(id)sender {
    if (self.started) {
        [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
        [self.environment stopSimulation];
        
        [self.startStopButton removeFromSuperview];
        [self.mapView removeFromSuperview];
        
        [self createViewsForInterface];
    } else {
        [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.environment startSimulation];
    }
    
    self.started = !self.started;
}

# pragma mark - environment delegate methods

- (void)addAirplanesToMap:(NSArray *)newAirplanes {
    for (Airplane *airplane in newAirplanes) {
        [self addAirplaneToMap:airplane];
    }
}

- (void)addAirplaneToMap:(Airplane *)newAirplane {
    UIImageView *newAirplaneView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Pictures/airplane"]];
    [newAirplaneView setBounds:CGRectMake([newAirplane.currentPosition.coordinates.coordinateX floatValue] - 5, [newAirplane.currentPosition.coordinates.coordinateY floatValue] - 5, 10, 10)];
    
    [self.mapView addSubview:newAirplaneView];
    [newAirplaneView release];
    
    [self.airplanesDictionary setObject:newAirplaneView forKey:newAirplane];
}

- (void)removeAirplaneFromMap:(Airplane *)airplane byLandingIt:(BOOL)landed {    
    UIImageView *airplaneExitingView = [self.airplanesDictionary objectForKey:airplane];
    [self.airplanesDictionary removeObjectForKey:airplane];
    
    [airplaneExitingView removeFromSuperview];
    
//    if (landed) {
//        
//    } else {
//        // if not landed display an explosion, to explain the airplane crashed        
//    }
}

- (void)updateAirplanesPositions:(NSArray *)airplanes {
    for (Airplane *currentAirplane in airplanes) {
        UIImageView *airplaneView = [self.airplanesDictionary objectForKey:currentAirplane];
        if (airplaneView == nil) {
            continue;
        }
        
        [airplaneView setCenter:CGPointMake([currentAirplane.currentPosition.coordinates.coordinateX floatValue] - 5, [currentAirplane.currentPosition.coordinates.coordinateY floatValue] - 5)];
    }
}

- (void)dealloc {
    self.environment = nil;
    
    [super dealloc];
}

@end
