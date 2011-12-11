//
//  ATCZoneBorderSegment+SpaceMethods.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ATCZoneBorderSegment.h"

@interface ATCZoneBorderSegment (SpaceMethods)

- (BOOL)checkIfProjectionIsInsideSegmentWithPoint:(ATCPoint *)testedPoint;
- (ATCPoint *)calculateLinesIntersectionWithPoint:(ATCPoint *)testedPoint;

@end
