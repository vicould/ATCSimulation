//
//  MessageAnalyzerDelegate.h
//  ATCSimulation
//
//  Created by Ludovic Delaveau on 11/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol MessageAnalyzerDelegate <NSObject>

- (void)analyzeMessage:(NSDictionary *)messageContent;

@end
