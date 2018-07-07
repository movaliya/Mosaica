//
//  MenuCell.h
//  HalalMeatDelivery
//
//  Created by kaushik on 25/08/16.
//  Copyright © 2016 kaushik. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ImageWithTintColor.h"

@interface MenuCell : UITableViewCell
{
    
}
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *IconHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *IconWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *IconX;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *ImgLblGap;


@property (strong, nonatomic) IBOutlet UILabel *Title_LBL;
@property (weak, nonatomic) IBOutlet ImageWithTintColor *IconIMG;

@end
