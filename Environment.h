//
//  Environment.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ATCZone.h"

@class ATCZone;

@interface Environment : NSObject {
    @private
    NSArray *_zones;
}

@property (nonatomic, retain) NSArray *zones;

@end
