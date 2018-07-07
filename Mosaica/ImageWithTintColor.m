//
//  ImageWithTintColor.m
//  Nibscrm
//
//  Created by Hima on 2018-02-24.
//  Copyright © 2018 Hima. All rights reserved.
//

#import "ImageWithTintColor.h"
#import "Mosaica.pch"
@implementation ImageWithTintColor

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UIImage*)setImageWithTint:(UIImage*)image
{
    
    self.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintColor = AppGrayColor;
    return self.image;
    
}

- (UIImage*)setDispatchWithTint:(UIImage*)image {
    
    self.image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    self.tintColor = AppBlueColor;
    return self.image;
    
}

@end
