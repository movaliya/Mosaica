//
//  Drawer.h
//  CCKFNavDrawer
//
//  Created by calvin on 2/2/14.
//  Copyright (c) 2014年 com.calvin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawerView : UIView

@property (weak, nonatomic) IBOutlet UITableView *drawerTableView;
@property (weak, nonatomic) IBOutlet UIButton *Back_BTN;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LogoWidht;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LogoHight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LBLLeading;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LBL_Trailing;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *LogoLBLGap;
@end
