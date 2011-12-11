//
//  ZoneControllerTests.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

//  Logic unit tests contain unit test code that is designed to be linked into an independent test executable.
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

#import <SenTestingKit/SenTestingKit.h>
#import "ZoneController.h"
#import "ZoneController+Collision.h"
#import "Environment.h"

@interface ZoneControllerTest : SenTestCase {
    @private
    Environment *environment;
    ZoneController *controller1;
}

@end
