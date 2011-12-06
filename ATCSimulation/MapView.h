//
//  MapView.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/5/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ATCZone.h"

@interface MapView : UIView {
    @private
    NSArray *_zonesAndTheirBorders;
}

@property (nonatomic, retain) NSArray *zonesAndTheirBorders;

@end
