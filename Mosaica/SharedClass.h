//
//  SharedClass.h
//  Sarjan
//
//  Created by TechnoMac-1 on 06/04/18.
//  Copyright © 2018 TechnoMac-1. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SharedClass : NSObject

+ (SharedClass*) sharedSingleton;

@property (nonatomic ) NSInteger index;
@property (nonatomic ,retain) NSMutableArray *arrCategories;
@property (weak, nonatomic) NSString *storyBaordName;
@end

