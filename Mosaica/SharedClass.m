//
//  SharedClass.m
//  Sarjan
//
//  Created by TechnoMac-1 on 06/04/18.
//  Copyright © 2018 TechnoMac-1. All rights reserved.
//

#import "SharedClass.h"

@implementation SharedClass

#pragma mark Singleton Methods

+ (SharedClass*) sharedSingleton  {
    static SharedClass* theInstance = nil;
    if (theInstance == nil) {
        theInstance = [[self alloc] init];
    }
    return theInstance;
}

@end

