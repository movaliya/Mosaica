//
//  ShowTimeCell.h
//  Mosaica
//
//  Created by jignesh solanki on 03/07/2018.
//  Copyright © 2018 jignesh solanki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowTimeCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *Date_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Time_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Title_LBL;
@property (weak, nonatomic) IBOutlet UILabel *Description_LBL;
@property (weak, nonatomic) IBOutlet UIView *BackGrgnVIEW;
@property (strong, nonatomic) IBOutlet UIButton *Bell_BTN;

@end
