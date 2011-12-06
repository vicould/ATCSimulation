//
//  MainInterfaceController.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/29/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MainInterfaceController.h"

@interface MainInterfaceController ()

@property (nonatomic, assign) int simulationState;
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
        _simulationState = -1;        
        _airplanesDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

@synthesize startStopButton = _startStopButton;
@synthesize simulationState = _simulationState;
@synthesize environment = _environment;
@synthesize airplanesDictionary = _airplanesDictionary;
@synthesize mapView = _mapView;
@synthesize controllersView = _controllersView;
@synthesize airplanesView = _airplanesView;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)loadView {
    self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    
    // creates button
    self.startStopButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.startStopButton setFrame:CGRectMake(932, 20, 72, 37)];
    [self.startStopButton setTitleColor:[UIColor colorWithWhite:0 alpha:1] forState:UIControlStateNormal];
    [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
    [self.startStopButton addTarget:self action:@selector(startStopPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [self createViewsForInterface];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.environment = [[Environment alloc] initWithDisplayDelegate:self];
    self.simulationState = SimulationReady;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.startStopButton = nil;
    self.mapView = nil;
    self.airplanesView = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft || interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

# pragma mark - Interface controls

- (void)createViewsForInterface {
    // creates map view:
    self.mapView = [[MapView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    [self.mapView setBackgroundColor:[UIColor colorWithWhite:0.9 alpha:1.0]];
    [self.view addSubview:self.mapView];

    self.controllersView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    [self.controllersView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [self.view addSubview:self.controllersView];
    
    self.airplanesView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1024, 748)];
    [self.airplanesView setBackgroundColor:[UIColor colorWithWhite:1 alpha:0]];
    [self.view addSubview:self.airplanesView];
    
    [self.view addSubview:self.startStopButton];
}

- (IBAction)startStopPressed:(id)sender {
    switch (self.simulationState) {
        case SimulationReady:
            [self.startStopButton setTitle:@"Stop" forState:UIControlStateNormal];
            
            // starts the simulation
            [self.environment startSimulation];
            self.simulationState = SimulationStarted;
            break;
            
        case SimulationStarted:
            [self.startStopButton setTitle:@"Reset" forState:UIControlStateNormal];
            
            // stops the simulation
            [self.environment stopSimulation];
            self.simulationState = SimulationStopped;
            break;
            
        case SimulationStopped:
            [self.startStopButton setTitle:@"Start" forState:UIControlStateNormal];
            
            // resets the simulation
            [self.environment resetSimulation];
            [self.mapView removeFromSuperview];
            self.mapView = nil;
            
            [self.airplanesView removeFromSuperview];
            self.airplanesView = nil;
            
            // as the views are stacks, and we want the button to be always on top of the stack, remove it
            // from the superview to add it above the map layer
            [self.startStopButton removeFromSuperview];
            
            [self createViewsForInterface];
            self.simulationState = SimulationReady;
            break;
            
        default:
            break;
    }
}

# pragma mark - environment delegate methods

- (void)addAirplanesToMap:(NSArray *)newAirplanes {
    for (Airplane *airplane in newAirplanes) {
        [self addAirplaneToMap:airplane];
    }
}

- (void)addAirplaneToMap:(Airplane *)newAirplane {
    UIImageView *newAirplaneView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"airplane"]];
    [newAirplaneView setFrame:CGRectMake(newAirplane.ownInformation.coordinates.X * SCALE - 10, newAirplane.ownInformation.coordinates.Y * SCALE - 10, 20, 20)];
    
    // sets the initial orientation for the aircraft
    CATransform3D initialCourseRotation = CATransform3DMakeRotation(newAirplane.course * 2 * M_PI / 360.0, 0, 0, 1);
    newAirplaneView.layer.transform = initialCourseRotation;
    
    [self.controllersView addSubview:newAirplaneView];
    [newAirplaneView release];
    
    // the dict contains as key the name of the aircraft, and an array as object containing the view, the orientation and the position
    [self.airplanesDictionary setObject:[NSMutableArray arrayWithObjects:newAirplaneView, [NSNumber numberWithInt:newAirplane.course], [ATCPoint pointFromExisting:newAirplane.ownInformation.coordinates], nil] forKey:newAirplane.ownInformation.airplaneName];
}

- (void)crashAirplane:(Airplane *)airplane {
    UIImageView *airplaneExitingView = [self.airplanesDictionary objectForKey:airplane];
    [self.airplanesDictionary removeObjectForKey:airplane];
    
    [airplaneExitingView removeFromSuperview];    
}

- (void)landAirplane:(Airplane *)airplane {    
    UIImageView *airplaneExitingView = [(NSArray *)[self.airplanesDictionary objectForKey:airplane] objectAtIndex:0];
    [self.airplanesDictionary removeObjectForKey:airplane];
    
    [airplaneExitingView removeFromSuperview];
}

- (void)updateAirplanesPositions:(NSArray *)airplanes {
    for (Airplane *currentAirplane in airplanes) {
        NSMutableArray *currentAirplaneData = [self.airplanesDictionary objectForKey:currentAirplane.ownInformation.airplaneName];
        UIImageView *airplaneView = [currentAirplaneData objectAtIndex:0];
        NSNumber *previousCourse = [currentAirplaneData objectAtIndex:1];
        ATCPoint *previousPosition = [currentAirplaneData objectAtIndex:2];
        
        if (airplaneView == nil) {
            continue;
        }
                                                                                                                                                                          
        // prepares the transformation of the view, with the necessary translation and rotation
        CATransform3D translation = CATransform3DMakeTranslation((currentAirplane.ownInformation.coordinates.X - previousPosition.X) * SCALE, (currentAirplane.ownInformation.coordinates.Y - previousPosition.Y) * SCALE, 0);
        // the translation should be made according to what has been previously translated
        
        CATransform3D rotation = CATransform3DMakeRotation((currentAirplane.course - [previousCourse intValue]) * 2 * M_PI / 360.0 , 0, 0, 1);
        
        // concats the previous transformation applied to the view with the new ones
        CATransform3D transformResult = CATransform3DConcat(airplaneView.layer.transform, translation);
        transformResult = CATransform3DConcat(transformResult, rotation);
        
        // sets the new transform to the layer
        airplaneView.layer.transform = transformResult;
        [airplaneView setNeedsDisplay];
        
        [currentAirplaneData replaceObjectAtIndex:1 withObject:[NSNumber numberWithInt:currentAirplane.course]];
        // previous position seems to be indeed changed, but next iteration it is the initial value
        previousPosition.X = currentAirplane.ownInformation.coordinates.X;
        previousPosition.Y = currentAirplane.ownInformation.coordinates.Y;
    }
}


- (void)displayZones:(NSArray *)zones {
    self.mapView.zonesAndTheirBorders = zones;
    [self.mapView setNeedsDisplay];
}

- (void)displayZonesControllers:(NSDictionary *)zonesControllers {
    // the dictionary contains the name of the agent as key, and the position as value
    for (NSString *name in zonesControllers.keyEnumerator) {
        UIImageView *controllerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"controller"]];
        ATCPoint *controller_position = [zonesControllers objectForKey:name];
        controllerView.center = CGPointMake(controller_position.X * SCALE + 60, controller_position.Y * SCALE + 60);
        [self.controllersView addSubview:controllerView];
        [controllerView release];
    }
}

- (void)displayAirportControllers:(NSDictionary *)airportsControllers {
    // the dictionary contains the name of the agent as key, and the position as value
    for (NSString *name in airportsControllers.keyEnumerator) {
        UIImageView *controllerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"runway"]];
        ATCPoint *controller_position = [airportsControllers objectForKey:name];
        // the position of runway needs to be accurate, that's why we don't add an offset
        controllerView.frame = CGRectMake(controller_position.X * SCALE, controller_position.Y * SCALE, 137, 20);
        
        [self.controllersView addSubview:controllerView];
        [controllerView release];
    }
}

- (void)dealloc {
    self.environment = nil;
    
    [super dealloc];
}

@end
