//
//  MapView.m
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "MapView.h"

@implementation MapView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _zonesAndTheirBorders = nil;
    }
    return self;
}

@synthesize zonesAndTheirBorders = _zonesAndTheirBorders;

- (void)drawRect:(CGRect)rect
{
    CGContextRef drawingContext = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(drawingContext, 2);
    
    UIColor *color = [UIColor blackColor];
    CGContextSetStrokeColorWithColor(drawingContext, color.CGColor);
    
    // Array of zones, each having a property storing the corners of the zone
    for (ATCZone *currentZone in self.zonesAndTheirBorders) {
        BOOL firstPoint = YES;
        
        // moves from point to point to draw the contour
        for (ATCPoint *point in currentZone.corners) {
            if (firstPoint) {
                CGContextMoveToPoint(drawingContext,  point.X * SCALE, point.Y * SCALE);
                firstPoint = NO;
            } else {
                CGContextAddLineToPoint(drawingContext, point.X * SCALE, point.Y * SCALE);
            }
        }
        CGContextClosePath(drawingContext);
        CGContextStrokePath(drawingContext);
        
        // displays the id of the zone in the top left corner
        UILabel *zoneIDLabel = [[UILabel alloc] initWithFrame:CGRectMake(((ATCPoint *)[currentZone.corners objectAtIndex:0]).X * SCALE + 10, ((ATCPoint *)[currentZone.corners objectAtIndex:0]).Y * SCALE + 10, 75, 21)];
        zoneIDLabel.text = currentZone.controllerName;
        zoneIDLabel.backgroundColor = [UIColor colorWithWhite:1 alpha:0];
        [self addSubview:zoneIDLabel];
        [zoneIDLabel release];
    }
    
    [color release];
}

@end
